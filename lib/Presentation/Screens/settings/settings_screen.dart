import 'package:flutter/material.dart';
import 'package:my_vocab/constants.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                SettingsCard(
                  icon: Icons.favorite_border_outlined,
                  title: 'Favorite',
                ),
                SettingsCard(
                  icon: Icons.verified_user_outlined,
                  title: 'Profile',
                ),
                SettingsCard(
                  icon: Icons.info_outline_rounded,
                  title: 'About',
                ),
                SettingsCard(
                  icon: Icons.description_outlined,
                  title: 'Licenses',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const SettingsCard({@required this.icon, @required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print(this.title + ' was tapped'),
      child: Column(children: [
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
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.white,
        ),
      ]),
    );
  }
}
