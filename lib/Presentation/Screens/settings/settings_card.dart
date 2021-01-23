import 'package:flutter/material.dart';
import 'package:my_vocab/constants/configs.dart';

class SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const SettingsCard({@required this.icon, @required this.title, @required this.onTap});
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
