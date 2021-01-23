import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:my_vocab/Presentation/Screens/like-screen/liked.dart';
import 'package:my_vocab/constants/configs.dart';
import 'package:my_vocab/services/auth/auth.dart';

import 'settings_card.dart';

class SettingsScreen extends StatefulWidget {
  final Function callBackFunction;

  const SettingsScreen({Key key, this.callBackFunction}) : super(key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Map<String, dynamic>> _settingsCardItems = [];

  @override
  void initState() {
    super.initState();
    _settingsCardItems = [
      {
        "icon": Icons.favorite_border_outlined,
        "title": tr('like'),
        "function": () {
          widget.callBackFunction();
          Navigator.of(context).pushNamed(LikeScreen.id);
        },
      },
      {
        "icon": Icons.translate,
        "title": tr('languages'),
        "function": () => EasyLocalization.of(context).locale =
            (EasyLocalization.of(context).locale == Locale('hi', 'IN'))
                ? Locale('en', 'US')
                : Locale('hi', 'IN'),
      },
      {
        "icon": Icons.description_outlined,
        "title": tr('about'),
        "function": () {
          widget.callBackFunction();

          showAboutDialog(
            context: context,
            applicationName: "MyVocab",
            applicationVersion: '0.0.1',
            applicationIcon: Icon(FontAwesomeIcons.appStore),
            applicationLegalese:
                "This is just a simple open source vocabulary app built for practice. For suggestions or to view source code, visit MrUnfunny on Github",
          );
        }
      },
      {
        "icon": Icons.logout,
        "title": tr('logout'),
        "function": () => Auth().signOut(context: context),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: (Auth().getProfilePhoto() == null)
                  ? AssetImage('Assets/images/profile.png')
                  : NetworkImage(Auth().getProfilePhoto()),
              backgroundColor: Colors.transparent,
              onBackgroundImageError: (exception, stackTrace) =>
                  log("$exception \n $stackTrace"),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              Auth().getUserName() ?? '',
              style: kLargeTextStyle.copyWith(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _settingsCardItems.length,
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                itemBuilder: (context, index) {
                  return SettingsCard(
                    icon: _settingsCardItems[index]['icon'],
                    title: _settingsCardItems[index]['title'],
                    onTap: _settingsCardItems[index]['function'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
