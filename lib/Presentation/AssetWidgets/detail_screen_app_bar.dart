import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:my_vocab/providers/home_provider.dart';
import 'package:my_vocab/services/play_audio.dart';
import 'package:my_vocab/services/utils.dart';

import '../../constants/configs.dart';
import 'action_card.dart';

class DetailScreenAppBar extends StatelessWidget {
  const DetailScreenAppBar({
    this.word,
    Key key,
  }) : super(key: key);

  final String word;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, HomeProvider homeProvider, child) => Column(
        children: [
          Row(
            children: [
              const BackButton(
                color: Colors.white,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (word != null)
                      Flexible(
                        child: Text(
                          capitalize(word),
                          style: kAppBarStyle.copyWith(
                              color: Colors.white, fontSize: 40),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: IconButton(
                        icon: const Icon(
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
            margin: const EdgeInsets.only(top: 32, left: 40, right: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionCard(
                  icon: (homeProvider.likedWords.contains(word.toLowerCase()))
                      ? Icons.favorite
                      : Icons.favorite_border,
                  onPressed: () =>
                      (homeProvider.likedWords.contains(word.toLowerCase()))
                          ? homeProvider.removeFromLiked(word.toLowerCase())
                          : homeProvider.addtoLiked(word.toLowerCase()),
                  word: tr('like'),
                ),
                ActionCard(
                  icon: Icons.content_copy,
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: word));
                    Fluttertoast.showToast(msg: 'Text Copied To Clipboard');
                  },
                  word: 'copy',
                ),
                const ActionCard(
                  icon: Icons.border_clear,
                  onPressed: null,
                  word: 'dono',
                ),
                ActionCard(
                  icon: (homeProvider.favWords
                          .any((element) => element['word'] == word))
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  onPressed: () => (!homeProvider.favWords.any((element) =>
                          element['word'].toLowerCase() == word.toLowerCase()))
                      ? homeProvider.addtoFavorites({
                          'word': word.toLowerCase(),
                          'date':
                              DateFormat('yyyy-MM-dd').format(DateTime.now())
                        })
                      : homeProvider.removeFromFav({
                          'word': word.toLowerCase(),
                          'date':
                              DateFormat('yyyy-MM-dd').format(DateTime.now())
                        }),
                  word: 'favorite',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
