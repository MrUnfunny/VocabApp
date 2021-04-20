import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularButtonWithoutSplash extends StatelessWidget {
  CircularButtonWithoutSplash({
    this.buttonText,
    this.topMargin,
    this.filled,
    this.fillColorInHex,
    this.onTap,
  });

  final String buttonText;
  final double topMargin;
  final bool filled;
  final int fillColorInHex;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300.0,
        padding: const EdgeInsets.symmetric(
          vertical: 13.0,
        ),
        margin: EdgeInsets.only(
          top: topMargin,
          bottom: 10.0,
        ),
        decoration: BoxDecoration(
            color: (filled) ? Color(fillColorInHex) : null,
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(
              style: BorderStyle.solid,
              color: Color(fillColorInHex),
            )),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: (filled) ? Colors.white : Color(fillColorInHex),
          ),
        ),
      ),
    );
  }
}
