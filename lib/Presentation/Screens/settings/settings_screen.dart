import 'package:flutter/material.dart';
import 'package:my_vocab/constants/constants.dart';

Map<String, IconData> _settingsCardData = {
  'Favorites': Icons.favorite_border_outlined,
  'Profile': Icons.verified_user_outlined,
  'About': Icons.info_outline_rounded,
  'Licenses': Icons.description_outlined,
};

class SettingsScreen extends StatelessWidget {
  final _stringList = _settingsCardData.keys.toList();
  final _iconList = _settingsCardData.values.toList();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.separated(
          itemCount: _settingsCardData.length,
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Divider(
              color: Colors.white,
            ),
          ),
          itemBuilder: (context, index) {
            return SettingsCard(
              icon: _iconList[index],
              title: _stringList[index],
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

  const SettingsCard({@required this.icon, @required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print(this.title + ' was tapped'),
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
