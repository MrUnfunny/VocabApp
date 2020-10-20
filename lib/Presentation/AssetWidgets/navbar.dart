import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/Screens/history-screen/history_screen.dart';
import 'package:my_vocab/Presentation/Screens/home-screen/screen.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;

  const NavBar({Key key, this.currentIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (value) {
        Navigator.pushNamed(context, childrenOfNavbar[value]);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'home',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'fav')
      ],
    );
  }
}

const childrenOfNavbar = [HomePage.id, HistoryScreen.id];
