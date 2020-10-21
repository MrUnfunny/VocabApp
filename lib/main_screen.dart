import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/Screens/favorites/favorites_screen.dart';
import 'package:my_vocab/Presentation/Screens/history-screen/history_screen.dart';
import 'package:my_vocab/Presentation/Screens/home-screen/screen.dart';
import 'package:my_vocab/Presentation/Screens/settings/settings_screen.dart';
import 'package:my_vocab/services/model/enum/api_request_status.dart';
import 'package:my_vocab/viewmodels/home_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const id = 'MainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:
          (BuildContext context, HomeProvider homeProvider, Widget child) =>
              Scaffold(
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
        bottomNavigationBar:
            (homeProvider.apiRequestStatus == ApiRequestStatus.loaded)
                ? BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: _page,
                    onTap: (pageIndex) {
                      _pageController.jumpToPage(pageIndex);
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
                      )
                    ],
                  )
                : null,
      ),
    );
  }
}
