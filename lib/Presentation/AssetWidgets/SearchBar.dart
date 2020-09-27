import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_vocab/Constants.dart';
import 'package:my_vocab/services/Dictionary/getMeaning.dart';
import 'package:my_vocab/services/api/datamuseApi.dart';
import 'package:http/http.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => myShowSearch(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 0.5, color: Colors.black12),
        ),
        child: Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Color(0xffF54A16),
                ),
                onPressed: null),
            Text(
              "Search",
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
    return super.appBarTheme(context).copyWith(
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
        onPressed: () => Meaning().getMeaning(word: query),
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    final res = Meaning().getMeaning(word: query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query != null)
      return ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: FutureBuilder(
              builder: (context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasData) return Text(snapshot.data[index]);
                return Center(
                  child: Container(),
                );
              },
              future: searchListFuture(query),
            ),
          );
        },
        itemCount: 20,
      );
    return Container();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return BackButton(color: Colors.white);
  }
}

Future<List<String>> searchListFuture(String query) async {
  try {
    final Response res = await datamuseApi.get(params: {"s": query, "max": 20});
    final resJson = jsonDecode(res.body);
    final List<String> resList =
        List.from(resJson.map((value) => value['word']));
    return resList;
  } catch (e) {
    print("@Error at datamuse api: $e");
    return null;
  }
}
