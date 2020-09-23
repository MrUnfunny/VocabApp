import 'package:flutter/material.dart';
import 'package:my_vocab/Constants.dart';

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
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    FlatButton(onPressed: null, child: null);
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return BackButton();
  }
}
