import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_vocab/Utilities//Constants.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.symmetric(horizontal: 10.0,),
      child: Material(
        elevation: 20.0,
        borderRadius: BorderRadius.circular(20.0),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(fontFamily: 'Montserrat',fontSize: 18.0),
            prefixIcon: Icon(FontAwesomeIcons.search,size: 25.0,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}
