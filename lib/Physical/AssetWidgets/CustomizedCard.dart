import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color:  Colors.accents[0],
              offset: Offset(0,35),
              blurRadius: 50.0,
              spreadRadius: 10.0,
            )
          ],
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
