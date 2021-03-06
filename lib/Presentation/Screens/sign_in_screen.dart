import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:my_vocab/Presentation/AssetWidgets/bottom_bar_textfield.dart';
import 'package:my_vocab/Presentation/Screens/sign_up_screen.dart';
import 'package:my_vocab/constants/configs.dart';
import 'package:my_vocab/main_screen.dart';
import 'package:my_vocab/services/auth/auth.dart';
import 'package:my_vocab/services/firestore_data.dart';
import 'package:my_vocab/services/validators/email.dart';
import 'package:my_vocab/services/validators/password.dart';

const SVGName = 'Assets/Vectors/welcomeBack.svg';
const googleLogo = 'Assets/Vectors/googleLogo.svg';

class SignInScreen extends StatefulWidget {
  static String id = "SignIn_Screen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email, password;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => ModalProgressHUD(
          inAsyncCall: loading,
          child: SafeArea(
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
                      Navigator.pushReplacementNamed(context, SignUpScreen.id);
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
                    color: Theme.of(context).primaryColor,
                  ),
                  verMargin: 30.0,
                  horMargin: 30.0,
                  inputType: TextInputType.emailAddress,
                  isPassword: false,
                  validator: (value) {
                    if (value != null) return Email.validate(value);
                    return true;
                  },
                  errorText: "Invalid Email",
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                BottomBarTextField(
                  text: "Enter your password",
                  icon: Icon(
                    FontAwesomeIcons.lock,
                    color: Theme.of(context).primaryColor,
                  ),
                  verMargin: 0.0,
                  horMargin: 30.0,
                  inputType: TextInputType.visiblePassword,
                  isPassword: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      if (email == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Enter Email Id for resetting password'),
                          ),
                        );
                      } else
                        FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email);
                    },
                    child: Text(
                      "Forgot Password",
                      textAlign: TextAlign.end,
                      style: kSmallTextStyle,
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 25.0, horizontal: 100.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 10.0),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      if (Email.validate(email) && Password.validate(password))
                        await Auth().signIn(
                            email: email, password: password, context: context);
                      else
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Please enter valid Email and Password"),
                          ),
                        );
                      setState(() {
                        loading = false;
                      });
                    },
                  ),
                ),
                Text(
                  "Or Sign In via",
                  textAlign: TextAlign.center,
                  style: kSmallTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.facebook,
                        size: 40.0,
                        color: Colors.blue.shade700,
                      ),
                      onPressed: () async {
                        final user =
                            await Auth().signInWithFacebook(context: context);
                        if (user != null) {
                          Navigator.pushReplacementNamed(
                            context,
                            MainScreen.id,
                          );

                          FirestoreInterface().addUser();
                        }
                        log("Exception occurred: User is null");
                      },
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: SvgPicture.asset(
                          googleLogo,
                          width: 37.0,
                        ),
                      ),
                      onTap: () async {
                        final user =
                            await Auth().signInWithGoogle(context: context);
                        if (user != null) {
                          FirestoreInterface().addUser();
                          Navigator.pushReplacementNamed(
                            context,
                            MainScreen.id,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
