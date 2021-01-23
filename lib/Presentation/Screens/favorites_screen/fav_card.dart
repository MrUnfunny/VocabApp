import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_vocab/constants/configs.dart';
import 'package:my_vocab/providers/home_provider.dart';
import 'package:my_vocab/services/utils.dart';

class FavCard extends StatelessWidget {
  final Map word;
  final String date;

  FavCard({Key key, @required this.word, @required this.date})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: kDismissColor,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      key: Key(word['word']),
      onDismissed: (direction) async {
        Provider.of<HomeProvider>(context, listen: false).addtoFavorites(word);
        // await FavDB().remove({'word': word});
        Provider.of<HomeProvider>(context, listen: false).getFavorites();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capitalize(word['word']),
                  style: kCardTextStyle,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(date),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
