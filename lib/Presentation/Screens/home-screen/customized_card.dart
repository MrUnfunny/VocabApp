import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_vocab/Presentation/AssetWidgets/action_card.dart';
import 'package:my_vocab/Presentation/Screens/word-detail/screen.dart';
import 'package:my_vocab/constants.dart';
import 'package:my_vocab/services/Dictionary/get_word_audio.dart';
import 'package:my_vocab/services/Dictionary/get_word_of_the_day.dart';
import 'package:my_vocab/services/play_audio.dart';
import 'package:my_vocab/viewmodels/home_provider.dart';
import 'package:provider/provider.dart';

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, HomeProvider homeProvider, Widget child) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          margin: EdgeInsets.symmetric(vertical: 20.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "WORD OF THE DAY",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(
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
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    homeProvider.wordOfTheDay['word'].toUpperCase(),
                    style: kCustomCardWordTextStyle.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    homeProvider.wordOfTheDay['meaning'],
                    style: kCustomCardWordTextStyle.copyWith(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ActionCard(
                        icon: Icons.favorite_border,
                        onPressed: null,
                      ),
                      ActionCard(
                        icon: Icons.content_copy,
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text: homeProvider.wordOfTheDay['word']));
                          Fluttertoast.showToast(
                              msg: 'Text Copied To Clipboard');
                        },
                      ),
                      ActionCard(
                        icon: Icons.bookmark_border,
                        onPressed: null,
                      ),
                      ActionCard(
                        icon: Icons.open_in_new_outlined,
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
              )
            ],
          ),
        );
      },
    );
  }
}

getMeaningOfWordFuture() async {
  final res = await WordOfTheDay().getMeaning();
  return res;
}
