import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_vocab/constants/configs.dart';
import 'package:my_vocab/Presentation/Screens/word-detail/screen.dart';
import 'package:my_vocab/services/api/datamuse_api.dart';
import 'package:http/http.dart';
import 'package:my_vocab/providers/home_provider.dart';
import 'package:provider/provider.dart';

// Search bar used in HomeScreen

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => myShowSearch(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 0.5,
            color: kLightBlack,
          ),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () => myShowSearch(context),
            ),
            Text(
              tr('search'),
              style: TextStyle(color: kBackgroundColor, fontSize: 17.0),
            ),
          ],
        ),
      ),
    );
  }
}

myShowSearch(context) {
  showSearch(context: context, delegate: Search());
}

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        primaryColor: Theme.of(context).primaryColor,
        textTheme: super.appBarTheme(context).textTheme.copyWith(
            headline6: super.appBarTheme(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                )));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () => FocusScope.of(context).unfocus(),
      ),
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchListFuture(query),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return Column(
            children: [
              if (snapshot.connectionState != ConnectionState.done)
                LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index]),
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WordDetailScreen(
                            word: snapshot.data[index],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                ),
              ),
            ],
          );
        if (query != '' && !snapshot.hasData)
          return LinearProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
          );
        return Consumer(
          builder:
              (BuildContext context, HomeProvider homeProvider, Widget child) =>
                  ListView.builder(
            itemBuilder: (context, index) => Dismissible(
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                color: kDismissColor,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              key: Key(homeProvider.historyWords[index]['word']),
              child: ListTile(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WordDetailScreen(
                      word: homeProvider.historyWords[index]['word'],
                    ),
                  ),
                ),
                title: Text(homeProvider.historyWords[index]['word']),
                trailing: IconButton(
                  icon: Icon(Icons.history),
                  onPressed: () =>
                      query = homeProvider.historyWords[index]['word'],
                ),
              ),
            ),
            itemCount: homeProvider.historyWords.length,
          ),
        );
      },
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return BackButton(color: Colors.white);
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }
}

///method to get search result from dataMuse api
Future<List<String>> searchListFuture(String query) async {
  try {
    if (query != '' && query != null) {
      final Response res =
          await datamuseApi.get(params: {"sp": "$query*", "max": 20});
      final resJson = jsonDecode(res.body);
      final List<String> resList =
          List.from(resJson.map((value) => value['word']));
      return resList;
    }
    return null;
  } catch (e) {
    log("@Error at datamuse api: $e");
    return null;
  }
}
