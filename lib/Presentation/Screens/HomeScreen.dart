import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/AssetWidgets/CustomizedCard.dart';
import 'package:my_vocab/Presentation/AssetWidgets/SearchBar.dart';
import 'package:my_vocab/Presentation/Screens/Welcome-Screen.dart';

class HomePage extends StatefulWidget {
  static const id = 'Home_Page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 20.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                    child: Text(
                      "Vocabulary",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 16.0),
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Theme.of(context).accentColor,
                    ),
                  )
                ],
              ),
              SearchBar(),
              CustomCard(),
            ],
          ),
        ),
      ),
    );
  }
}
