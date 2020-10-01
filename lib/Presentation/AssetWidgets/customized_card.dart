import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/AssetWidgets/action_card.dart';
import 'package:my_vocab/constants.dart';
import 'package:my_vocab/services/Dictionary/get_word_of_the_day.dart';

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return Column(
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
                        Icon(
                          Icons.volume_up,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${snapshot.data['word'].toUpperCase()}",
                      style: kCustomCardWordTextStyle.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data['meaning'],
                      style: kCustomCardWordTextStyle.copyWith(fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ActionCard(
                          icon: Icons.border_inner,
                          onPressed: null,
                        ),
                        ActionCard(
                          icon: Icons.content_copy,
                          onPressed: null,
                        ),
                        ActionCard(
                          icon: Icons.favorite_border,
                          onPressed: null,
                        ),
                        ActionCard(
                          icon: Icons.bookmark_border,
                          onPressed: null,
                        ),
                      ],
                    )
                  ],
                );
              return Center(child: CircularProgressIndicator());
            },
            future: getMeaningOfWordFuture(),
          )
        ],
      ),
    );
  }
}

getMeaningOfWordFuture() async {
  // final res = await Meaning().getMeaning(word: 'Abstract');
  final res = await WordOfTheDay().getMeaning();
  return res;
}
