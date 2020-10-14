import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_vocab/services/play_audio.dart';

import '../../constants.dart';
import 'action_card.dart';

class DetailScreenAppBar extends StatelessWidget {
  final String word;

  const DetailScreenAppBar({
    this.word,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            BackButton(
              color: Colors.white,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (word != null)
                    Text(
                      "${word[0].toUpperCase()}${word.substring(1)}",
                      style: kAppBarStyle.copyWith(
                          color: Colors.white, fontSize: 40),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      icon: Icon(
                        Icons.volume_up,
                        size: 32,
                        color: Colors.white,
                      ),
                      onPressed: () => WordAudio().playAudio(word),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Container(
          child: Container(
            margin: EdgeInsets.only(top: 32, left: 40, right: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrange[400]),
                    child: ActionCard(
                      icon: Icons.favorite_border,
                      onPressed: null,
                      size: 40,
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrange[400]),
                    child: ActionCard(
                      icon: Icons.content_copy,
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: word));
                        Fluttertoast.showToast(msg: 'Text Copied To Clipboard');
                      },
                      size: 40,
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrange[400]),
                    child: ActionCard(
                      icon: Icons.border_clear,
                      onPressed: null,
                      size: 40,
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrange[400]),
                    child: ActionCard(
                      icon: Icons.bookmark_border,
                      onPressed: null,
                      size: 40,
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
