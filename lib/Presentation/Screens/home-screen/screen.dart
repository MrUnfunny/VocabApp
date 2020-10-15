import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_vocab/Presentation/AssetWidgets/loading_widget.dart';
import 'package:my_vocab/Presentation/Screens/history-screen/history_screen.dart';
import 'package:my_vocab/Presentation/Screens/home-screen/word_of_the_day_card.dart';
import 'package:my_vocab/Presentation/AssetWidgets/search_bar.dart';
import 'package:my_vocab/Presentation/AssetWidgets/custom_app_bar.dart';
import 'package:my_vocab/Presentation/Screens/home-screen/horizontal_scroll_card.dart';
import 'package:my_vocab/Presentation/Screens/welcome_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_vocab/constants.dart';
import 'package:my_vocab/services/model/enum/api_request_status.dart';
import 'package:my_vocab/viewmodels/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const id = 'Home_Page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
    init();
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        Provider.of<HomeProvider>(context, listen: false)
            .getWordOfTheDayAndHistory());
  }

  init() {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if (user == null) Navigator.pushReplacementNamed(context, WelcomeScreen.id);
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Press back again to exit",
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:
          (BuildContext context, HomeProvider homeProvider, Widget child) =>
              Scaffold(
        backgroundColor: Colors.grey[100],
        drawer: Drawer(
          elevation: 20.0,
        ),
        body: WillPopScope(
          onWillPop: () => onWillPop(),
          child: (homeProvider.apiRequestStatus == ApiRequestStatus.loaded)
              ? SafeArea(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      CustomAppBar(
                        title: 'Vocabulary',
                      ),
                      SearchBar(),
                      CustomCard(),
                      SizedBox(
                        height: 8.0,
                      ),
                      if (homeProvider.historyWords.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text(
                              'History',
                              style: kAppBarStyle.copyWith(fontSize: 20.0),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, HistoryScreen.id),
                              child: Text(
                                'See all',
                                style: kSmallTextStyle.copyWith(
                                  color: Colors.brown.shade600,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Container(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeProvider.historyWords.length,
                            itemBuilder: (BuildContext context, int index) =>
                                HorizontalScrollCard(
                              word: homeProvider.historyWords[
                                  homeProvider.historyWords.length -
                                      index -
                                      1]['word'],
                              date: homeProvider.historyWords[
                                  homeProvider.historyWords.length -
                                      index -
                                      1]['date'],
                            ),
                          )),
                    ],
                  ),
                )
              : LoadingWidget(),
        ),
      ),
    );
  }
}
