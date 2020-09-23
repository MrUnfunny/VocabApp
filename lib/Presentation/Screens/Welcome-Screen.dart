import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_vocab/Presentation/AssetWidgets/Button.dart';
import 'package:my_vocab/Presentation/Screens/Sign-In-Screen.dart';
import 'package:my_vocab/Presentation/Screens/Sign-Up-Screen.dart';
import 'package:my_vocab/Constants.dart';

const SVGName = 'Assets/Vectors/bookReading.svg';

class WelcomeScreen extends StatelessWidget {
  static String id = "Welcome_Screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            Container(
              child: Center(
                child: SvgPicture.asset(
                  SVGName,
                  width: 300,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Keep Track of All Your Vocabulary",
              textAlign: TextAlign.center,
              style: kLargeTextStyle,
            ),
            Container(
              padding: EdgeInsets.only(
                top: 15.0,
                left: 50.0,
                right: 50.0,
                bottom: 5.0,
              ),
              child: Text(
                "Vocabulary is a matter of word building as well as word using",
                textAlign: TextAlign.center,
                style: kSmallTextStyle,
              ),
            ),
            CircularButtonWithoutSplash(
              buttonText: "Sign In",
              topMargin: 60,
              filled: true,
              fillColorInHex: 0xffff4f18,
              onTap: () {
                Navigator.pushNamed(context, SignInScreen.id);
              },
            ),
            CircularButtonWithoutSplash(
              buttonText: "Sign Up",
              topMargin: 20,
              filled: false,
              fillColorInHex: 0xffff4f18,
              onTap: () {
                Navigator.pushNamed(context, SignUpScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
