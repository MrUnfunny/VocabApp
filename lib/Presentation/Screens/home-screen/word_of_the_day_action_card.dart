import 'package:flutter/material.dart';

class WordOfTheDayCard extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final String tooltipMsg;

  const WordOfTheDayCard({
    Key key,
    @required this.icon,
    @required this.onPressed,
    @required this.tooltipMsg,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: (this.tooltipMsg == null) ? 'default' : this.tooltipMsg,
      child: IconButton(
        padding: EdgeInsets.all(0),
        onPressed: onPressed,
        icon: Icon(
          this.icon,
          size: 30.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
