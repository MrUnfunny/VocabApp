import 'package:flutter/material.dart';
import 'package:my_vocab/Constants.dart';
import 'package:my_vocab/services/Dictionary/getMeaning.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => myShowSearch(context),
      child: Container(
        decoration: BoxDecoration(
          color: kBackgroundColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.0),
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
            headline6: super
                .appBarTheme(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.normal, color: Colors.white)));
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
    // TODO: implement buildSuggestions
    return Container();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return BackButton(color: Colors.white);
  }
}
