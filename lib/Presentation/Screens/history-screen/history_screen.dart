import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/AssetWidgets/custom_app_bar.dart';
import 'package:my_vocab/services/local_databases/history.dart';
import 'package:my_vocab/viewmodels/home_provider.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  static final id = 'History_Screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomAppBar(title: 'History'),
            ),
            Expanded(
              child: Consumer(
                builder: (BuildContext context, HomeProvider homeProvider,
                        Widget child) =>
                    ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: homeProvider.historyWords.length,
                  itemBuilder: (BuildContext context, int index) {
                    return HistoryCard(
                      word: homeProvider.historyWords[index]['word'],
                      date: homeProvider.historyWords[index]['date'],
                    );
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
  final key = UniqueKey();
  final String word;
  final String date;

  HistoryCard({Key key, @required this.word, @required this.date})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      onDismissed: (direction) async {
        await HistoryDB().remove({'word': word});
        Provider.of<HomeProvider>(context, listen: false).getHistory();
        if ((await HistoryDB().listAll()).isEmpty && Navigator.canPop(context))
          Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey.shade300,
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
                  word,
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
