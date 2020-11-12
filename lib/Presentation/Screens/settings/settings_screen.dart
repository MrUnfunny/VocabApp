import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/Screens/favorites_screen/screen.dart';
import 'package:my_vocab/constants/constants.dart';
import 'package:my_vocab/services/auth/auth.dart';

class SettingsScreen extends StatefulWidget {
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
        "title": tr('favorites'),
        "function": () => Navigator.of(context).pushNamed(FavScreen.id),
      },
      {
        "icon": Icons.verified_user_outlined,
        "title": tr('profile'),
        "function": () => print("PRofile was tapped"),
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
        "icon": Icons.info_outline_rounded,
        "title": tr('about'),
        "function": () => print("About was tapped"),
      },
      {
        "icon": Icons.description_outlined,
        "title": tr('licenses'),
        "function": () => print("Licenses was tapped"),
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
        height: MediaQuery.of(context).size.height * 0.7,
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
    );
  }
}

class SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const SettingsCard(
      {@required this.icon, @required this.title, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                this.icon,
                color: Colors.white,
              ),
              SizedBox(
                width: 30,
              ),
              Flexible(
                child: Text(
                  this.title,
                  style: kLargeTextStyle.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
