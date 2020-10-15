import 'package:flutter/material.dart';

class WordOfTheDayCard extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  const WordOfTheDayCard({
    Key key,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(0),
      onPressed: onPressed,
      icon: Icon(
        this.icon,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }
}
