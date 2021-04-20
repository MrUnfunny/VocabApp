import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_vocab/constants/configs.dart';
import 'package:my_vocab/providers/home_provider.dart';
import 'package:my_vocab/services/utils.dart';

class FavCard extends StatelessWidget {
  FavCard({Key key, @required this.word, @required this.date});

  final Map word;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: kDismissColor,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      key: Key(word['word'] as String),
      onDismissed: (direction) async {
        Provider.of<HomeProvider>(context, listen: false)
            .addtoFavorites(word as Map<String, dynamic>);
        // await FavDB().remove({'word': word});
        Provider.of<HomeProvider>(context, listen: false).getFavorites();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capitalize(word['word'] as String),
                  style: kCardTextStyle,
                ),
                const SizedBox(
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
