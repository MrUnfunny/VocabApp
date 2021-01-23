import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_vocab/constants/configs.dart';
import 'package:my_vocab/hive/hiveDb.dart';
import 'package:my_vocab/providers/home_provider.dart';
import 'package:my_vocab/services/utils.dart';

class HistoryCard extends StatelessWidget {
  final String word;
  final String date;
  final IconData icon;
  final Function onPressed;

  HistoryCard({
    @required this.word,
    @required this.date,
    @required this.icon,
    @required this.onPressed,
  });
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
      key: Key(word),
      onDismissed: (direction) async {
        HiveDB.instance.remove(word);
        Provider.of<HomeProvider>(context, listen: false).getHistory();
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
                  capitalize(word),
                  style: kCardTextStyle,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(date),
              ],
            ),
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
