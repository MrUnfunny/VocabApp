import 'package:flutter/material.dart';
import 'package:my_vocab/constants/configs.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard(
      {@required this.icon, @required this.title, @required this.onTap});

  final IconData icon;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(
                width: 30,
              ),
              Flexible(
                child: Text(
                  title,
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
