import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/Screens/home-screen/customized_card.dart';
import 'package:my_vocab/Presentation/AssetWidgets/search_bar.dart';
import 'package:my_vocab/Presentation/AssetWidgets/custom_app_bar.dart';
import 'package:my_vocab/Presentation/Screens/welcome_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: Drawer(
        elevation: 20.0,
      ),
      body: WillPopScope(
        onWillPop: () => onWillPop(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                CustomAppBar(),
                SearchBar(),
                CustomCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
