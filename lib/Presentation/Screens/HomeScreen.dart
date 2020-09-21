import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/AssetWidgets/SearchBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_vocab/Presentation/AssetWidgets/CustomizedCard.dart';
import 'package:my_vocab/Presentation/Screens/Welcome-Screen.dart';
import 'package:my_vocab/services/auth/auth.dart';

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
    // final _auth = FirebaseAuth.instance;
    // final user = _auth.currentUser;
    // if (user == null) Navigator.pushReplacementNamed(context, WelcomeScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff333839),
      ),
      home: Scaffold(
        drawer: Drawer(
          elevation: 20.0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: IconButton(
                        onPressed: () {
                          Auth().signOut(context: context);
                        },
                        icon: Icon(
                          FontAwesomeIcons.list,
                        )),
                    padding: EdgeInsets.only(left: 10.0),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                    child: Text(
                      "Hey There!",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 30.0,
                          color: Color(0xff272d2f)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 120),
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.black12,
                    ),
                  )
                ],
              ),
              SearchBar(),
              CustomCard()
            ],
          ),
        ),
      ),
    );
  }
}
