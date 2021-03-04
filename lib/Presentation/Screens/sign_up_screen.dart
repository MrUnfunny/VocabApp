import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_vocab/Presentation/Screens/sign_in_screen.dart';
import 'package:my_vocab/constants/configs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_vocab/Presentation/AssetWidgets/bottom_bar_textfield.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_vocab/services/auth/auth.dart';
import 'package:my_vocab/services/validators/email.dart';
import 'package:my_vocab/services/validators/password.dart';

const SignUpSVG = 'Assets/Vectors/SignUp.svg';
const googleLogo = 'Assets/Vectors/googleLogo.svg';

class SignUpScreen extends StatefulWidget {
  static String id = "SignUp_Screen";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email, password;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => ModalProgressHUD(
          inAsyncCall: loading,
          child: SafeArea(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 30.0),
                  child: GestureDetector(
                    child: Text(
                      "Sign In",
                      style: kSmallTextStyle,
                      textAlign: TextAlign.end,
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, SignInScreen.id);
                    },
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: SvgPicture.asset(
                    SignUpSVG,
                    width: 350.0,
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
                    if (mounted)
                      setState(() {
                        email = value;
                      });
                  },
                ),
                BottomBarTextField(
                  inputType: TextInputType.visiblePassword,
                  text: "Enter your password",
                  icon: Icon(
                    FontAwesomeIcons.lock,
                    color: Theme.of(context).primaryColor,
                  ),
                  verMargin: 0.0,
                  horMargin: 30.0,
                  isPassword: true,
                  validator: (value) {
                    if (value != null) return Password.validate(value);
                    return true;
                  },
                  errorText: "Weak Password",
                  onChanged: (value) {
                    if (mounted)
                      setState(() {
                        password = value;
                      });
                  },
                ),
                SizedBox(
                  height: 10.0,
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
                      "Sign Up",
                      style: kLargeTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      if (Email.validate(email) && Password.validate(password))
                        await Auth().signUp(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
