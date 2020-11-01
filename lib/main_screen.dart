import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/Screens/favorites_screen/screen.dart';
import 'package:my_vocab/Presentation/Screens/history-screen/history_screen.dart';
import 'package:my_vocab/Presentation/Screens/home-screen/screen.dart';
import 'package:my_vocab/Presentation/Screens/settings/settings_screen.dart';
import 'package:my_vocab/model/enum/api_request_status.dart';
import 'package:my_vocab/viewmodels/home_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const id = 'MainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final double max = 200.0;
  AnimationController animationController;
  Animation finalAnimation;
  bool isSettingsVisible = false;

  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    finalAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.decelerate);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: finalAnimation,
      builder: (context, child) {
        double slide = finalAnimation.value * max;
        double scale = 1 - (finalAnimation.value * 0.1);
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Color(0xff2a9d8f),
              body: Transform(
                transform: Matrix4.identity()..translate(-slide),
                child: Transform.translate(
                  offset: Offset(200, 0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: SettingsScreen(),
                  ),
                ),
              ),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(-slide)
                ..scale(scale),
              alignment: Alignment.centerLeft,
              child: Consumer(
                builder: (BuildContext context, HomeProvider homeProvider,
                        Widget child) =>
                    Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(20 * finalAnimation.value),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (currentPageIndex) {
                          setState(() {
                            this._page = currentPageIndex;
                          });
                        },
                        children: [
                          HomeScreen(),
                          HistoryScreen(),
                          FavScreen(),
                          SettingsScreen(),
                        ],
                      ),
                      bottomNavigationBar: (homeProvider.apiRequestStatus ==
                              ApiRequestStatus.loaded)
                          ? BottomNavigationBar(
                              type: BottomNavigationBarType.fixed,
                              currentIndex: _page,
                              onTap: (pageIndex) {
                                if (pageIndex == 3) {
                                  toggleSettings();
                                  isSettingsVisible = !isSettingsVisible;
                                } else
                                  _pageController.animateToPage(pageIndex,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                              },
                              items: [
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.home),
                                  label: 'Home',
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.history),
                                  label: 'History',
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.favorite),
                                  label: 'Fav',
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.settings),
                                  label: 'Settings',
                                ),
                              ],
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void toggleSettings() {
    if (animationController.status == AnimationStatus.completed)
      animationController.reverse();
    else {
      animationController.forward();
    }
  }
}
