import 'package:flutter/material.dart';

class WordOfTheDayIcon extends StatelessWidget {
  const WordOfTheDayIcon({
    Key key,
    @required this.icon,
    @required this.onPressed,
    @required this.tooltipMsg,
  });

  final IconData icon;
  final Function() onPressed;
  final String tooltipMsg;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: (tooltipMsg == null) ? 'default' : tooltipMsg,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 30.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
