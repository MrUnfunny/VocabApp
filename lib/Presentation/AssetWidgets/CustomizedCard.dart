import 'package:flutter/material.dart';
import 'package:my_vocab/Constants.dart';
import 'package:my_vocab/services/Dictionary/getMeaning.dart';

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
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
                      "${snapshot.data.word.toUpperCase()}",
                      style: kCustomCardWordTextStyle.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data.definitions[1].definition,
                      style: kCustomCardWordTextStyle.copyWith(fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Save to Favorites",
                          style: kCustomCardWordTextStyle.copyWith(
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Expand Details",
                          style: kCustomCardWordTextStyle.copyWith(
                              fontWeight: FontWeight.w600),
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
  final res = await Meaning().getMeaning(word: 'Abstract');
  return res;
}
