import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:my_vocab/constants/configs.dart';
import 'package:my_vocab/services/auth/auth.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool isTextWhite;
  const CustomAppBar({
    Key key,
    this.isTextWhite = false,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
          child: Text(
            this.title,
            style: (isTextWhite)
                ? kAppBarStyle.copyWith(color: Colors.white)
                : kAppBarStyle,
          ),
        ),
        Container(
          child: CircleAvatar(
            radius: 20.0,
            backgroundImage: (Auth().getProfilePhoto() == null)
                ? AssetImage('Assets/images/profile.png')
                : NetworkImage(Auth().getProfilePhoto()),
            backgroundColor: Colors.transparent,
            onBackgroundImageError: (exception, stackTrace) =>
                log("$exception \n $stackTrace"),
          ),
        )
      ],
    );
  }
}
