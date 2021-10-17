import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_vocab/Presentation/Screens/home-screen/word_of_the_day_action_card.dart';
import 'package:my_vocab/Presentation/Screens/word-detail/screen.dart';
import 'package:my_vocab/constants/configs.dart';
import 'package:my_vocab/providers/home_provider.dart';
import 'package:my_vocab/services/play_audio.dart';
import 'package:provider/provider.dart';

class WordOfTheDayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, HomeProvider homeProvider, Widget child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    tr('word_of_the_day'),
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.volume_up,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await WordAudio()
                          .playAudio(homeProvider.wordOfTheDay['word']);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                homeProvider.wordOfTheDay['word'].toUpperCase(),
                style: kCustomCardWordTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                homeProvider.wordOfTheDay['meaning'],
                style: kCustomCardWordTextStyle.copyWith(fontSize: 16.0),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WordOfTheDayIcon(
                    icon: (homeProvider.likedWords
                            .contains(homeProvider.wordOfTheDay['word']))
                        ? Icons.favorite
                        : Icons.favorite_border,
                    tooltipMsg: 'save to liked',
                    onPressed: () {
                      (!homeProvider.likedWords.contains(
                        homeProvider.wordOfTheDay['word'],
                      ))
                          ? homeProvider
                              .addtoLiked(homeProvider.wordOfTheDay['word'])
                          : homeProvider.removeFromLiked(
                              homeProvider.wordOfTheDay['word']);
                    },
                  ),
                  WordOfTheDayIcon(
                    icon: Icons.content_copy,
                    tooltipMsg: 'Copy to clipboard',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                          text: homeProvider.wordOfTheDay['word']));
                      Fluttertoast.showToast(msg: 'Text Copied To Clipboard');
                    },
                  ),
                  WordOfTheDayIcon(
                    icon: Icons.bookmark_border,
                    tooltipMsg: 'Add to Favorites',
                    onPressed: () async {
                      return Fluttertoast.showToast(
                          msg: 'Cannot add word of the day to Favorites');
                    },
                  ),
                  WordOfTheDayIcon(
                    icon: Icons.open_in_new_outlined,
                    tooltipMsg: 'Go to definition',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WordDetailScreen(
                          word: Provider.of<HomeProvider>(context)
                              .wordOfTheDay['word'],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
