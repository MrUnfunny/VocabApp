import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_vocab/Physical/AssetWidgets/BottomBarTextField.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_vocab/Utilities/Constants.dart';
import 'package:my_vocab/Physical/Screens/HomeScreen.dart';
import 'package:my_vocab/Physical/Screens/Sign-Up-Screen.dart';


const SVGName = 'Assets/Vectors/welcomeBack.svg';
const googleLogo = 'Assets/Vectors/googleLogo.svg';

class SignInScreen extends StatelessWidget {
  static String id = "SignIn_Screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 30.0),
              child: GestureDetector(
                child: Text(
                  "Sign Up",
                  style: kSmallTextStyle,
                  textAlign: TextAlign.end,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, SignUpScreen.id);
                },
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: SvgPicture.asset(
                SVGName,
                width: 400.0,
              ),
            ),
            BottomBarTextField(
              text: "Enter your email",
              icon: Icon(
                FontAwesomeIcons.envelope,
                color: Color(0xffff4f18),
              ),
              verMargin: 30.0,
              horMargin: 30.0,
              inputType: TextInputType.emailAddress,
              isPassword: false,
            ),
            BottomBarTextField(
              text: "Enter your password",
              icon: Icon(
                FontAwesomeIcons.lock,
                color: Color(0xffff4f18),
              ),
              verMargin: 0.0,
              horMargin: 30.0,
              isPassword: true,
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0, top: 10.0),
              child: Text(
                "Forgot Password",
                textAlign: TextAlign.end,
                style: kSmallTextStyle.copyWith(
                    color: Color(0xffff4f18), fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 25.0, horizontal: 100.0),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                color: Color(0xffff4f18),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                onPressed: () {
                  Navigator.pushNamed(context,HomePage.id);
                },
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              "Or Sign In via",
              textAlign: TextAlign.center,
              style: kSmallTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Icon(
                      FontAwesomeIcons.facebook,
                      size: 40.0,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SvgPicture.asset(
                        googleLogo,
                        width: 37.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
