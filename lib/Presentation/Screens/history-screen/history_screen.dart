import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_vocab/Presentation/AssetWidgets/custom_app_bar.dart';
import 'package:my_vocab/constants/constants.dart';
import 'package:my_vocab/hive/hiveDb.dart';
import 'package:my_vocab/viewmodels/home_provider.dart';
import 'package:provider/provider.dart';

final svgAsset = 'Assets/Vectors/empty.svg';

class HistoryScreen extends StatelessWidget {
  static const id = 'History_Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomAppBar(
                title: tr('history'),
                isTextWhite: true,
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Consumer(
                  builder: (BuildContext context, HomeProvider homeProvider,
                      Widget child) {
                    if (homeProvider.historyWords.isNotEmpty)
                      return ListView.builder(
                        itemCount: homeProvider.historyWords.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0)
                            return SizedBox(
                              height: 10.0,
                            );
                          return HistoryCard(
                            word: homeProvider.historyWords[index - 1]['word'],
                            date: homeProvider.historyWords[index - 1]
                                    ['date'] ??
                                '',
                            icon: (homeProvider.favWords.contains(
                                    homeProvider.historyWords[index - 1]))
                                ? Icons.bookmark
                                : Icons.bookmark_outline,
                            onPressed: (homeProvider.favWords.contains(
                                    homeProvider.historyWords[index - 1]))
                                ? () => homeProvider.removeFromFav(
                                    homeProvider.historyWords[index - 1])
                                : () => homeProvider.addtoFavorites(
                                    homeProvider.historyWords[index - 1]),
                          );
                        },
                      );
                    else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              svgAsset,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            tr('empty'),
                            style: kLargeTextStyle,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
        color: Colors.red,
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
                  '${word[0].toUpperCase()}${word.substring(1)}',
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
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
