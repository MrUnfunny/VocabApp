import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularButtonWithoutSplash extends StatelessWidget {
  final buttonText;
  final double topMargin;
  final bool filled;
  final int fillColorInHex;
  final Function onTap;

  CircularButtonWithoutSplash({
    this.buttonText,
    this.topMargin,
    this.filled,
    this.fillColorInHex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Text(
          this.buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: (filled) ? Colors.white : Color(this.fillColorInHex),
          ),
        ),
        width: 300.0,
        padding: EdgeInsets.symmetric(
          vertical: 13.0,
        ),
        margin: EdgeInsets.only(
          top: this.topMargin,
          bottom: 10.0,
        ),
        decoration: BoxDecoration(
            color: (filled) ? Color(this.fillColorInHex) : null,
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(
              style: BorderStyle.solid,
              color: Color(this.fillColorInHex),
            )),
      ),
      onTap: onTap,
    );
  }
}
