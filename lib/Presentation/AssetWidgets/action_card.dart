import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final String word;

  const ActionCard({
    Key key,
    this.icon,
    this.onPressed,
    this.word,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepOrange[400]),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: IconButton(
              padding: EdgeInsets.all(0),
              onPressed: onPressed,
              icon: Icon(
                this.icon,
                size: 32.0,
                color: Colors.white,
              ),
            ),
          ),
          Flexible(
            child: Text(
              word,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
