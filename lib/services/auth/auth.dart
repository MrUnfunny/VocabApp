import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/Screens/HomeScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  signInWithGoogle({@required BuildContext context}) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount account = await googleSignIn.signIn();
      final GoogleSignInAuthentication auth = await account.authentication;
      final OAuthCredential creds = GoogleAuthProvider.credential(
          accessToken: auth.accessToken, idToken: auth.idToken);
      final UserCredential user = await _auth.signInWithCredential(creds);
      return user.user;
    } catch (e) {
      print("error is $e");
      _showDialog(error: e, context: context);
      return null;
    }
  }

  signOut({BuildContext context}) async {
    await GoogleSignIn().signOut();
    _auth.signOut();
    Navigator.pop(context);
  }

  _showDialog({@required error, @required BuildContext context}) {
    final errorMessage =
        (error.message != null) ? error.message : "UnIdentified Error";
    final SnackBar snackBar = SnackBar(content: Text("ERROR: $errorMessage"));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
