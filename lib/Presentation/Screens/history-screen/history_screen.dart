import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_vocab/Presentation/AssetWidgets/custom_app_bar.dart';
import 'package:my_vocab/Presentation/AssetWidgets/navbar.dart';
import 'package:my_vocab/services/local_databases/history.dart';
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
                title: 'History',
                isTextWhite: true,
              ),
            ),
            Expanded(
              child: Consumer(builder: (BuildContext context,
                  HomeProvider homeProvider, Widget child) {
                if (homeProvider.historyWords.isNotEmpty)
                  return Container(
                    padding: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: homeProvider.historyWords.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HistoryCard(
                          word: homeProvider.historyWords[index]['word'],
                          date: homeProvider.historyWords[index]['date'],
                        );
                      },
                    ),
                  );
                else {
                  return SvgPicture.asset(svgAsset);
                }
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(
        currentIndex: 1,
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final String word;
  final String date;

  HistoryCard({Key key, @required this.word, @required this.date})
      : super(key: key);
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
        await HistoryDB().remove({'word': word});
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
            Icon(
              Icons.bookmark_outline,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
