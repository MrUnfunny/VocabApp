import 'package:flutter/material.dart';

import 'package:my_vocab/constants.dart';
import 'package:my_vocab/services/auth/auth.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({
    Key key,
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
            style: kAppBarStyle,
          ),
        ),
        GestureDetector(
          onTap: () {
            print("Signed Out");
            Auth().signOut(context: context);
          },
          child: Container(
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: (Auth().getProfilePhoto() == null)
                  ? AssetImage('Assets/images/profile.png')
                  : NetworkImage(Auth().getProfilePhoto()),
              backgroundColor: Colors.transparent,
              onBackgroundImageError: (exception, stackTrace) =>
                  print("$exception \n $stackTrace"),
            ),
          ),
        )
      ],
    );
  }
}
