import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/Screens/HomeScreen.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  signUp(
      {@required email,
      @required password,
      @required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacementNamed(context, HomePage.id);
    } catch (e) {
      print('Exception @createAccount: $e');
      _showDialog(
        error: e,
        context: context,
      );
    }
  }

  signIn(
      {@required email,
      @required password,
      @required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, HomePage.id);
    } catch (e) {
      _showDialog(error: e, context: context);
    }
  }

  _showDialog({@required error, @required BuildContext context}) {
    final SnackBar snackBar =
        SnackBar(content: Text("ERROR: ${error.message}"));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
