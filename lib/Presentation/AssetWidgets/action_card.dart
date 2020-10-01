import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final double size;

  const ActionCard({
    Key key,
    this.icon,
    this.onPressed,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(0),
      onPressed: onPressed,
      icon: Icon(
        this.icon,
        size: size ?? 30.0,
        color: Colors.white,
      ),
    );
  }
}
