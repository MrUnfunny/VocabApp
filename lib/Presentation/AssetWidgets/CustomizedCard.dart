import 'package:flutter/material.dart';
import 'package:my_vocab/Constants.dart';

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      margin: EdgeInsets.symmetric(vertical: 16.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: kBackgroundColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text("dflkjasdfhsakf"),
    );
  }
}
