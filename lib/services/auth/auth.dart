import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_vocab/Presentation/Screens/welcome_screen.dart';
import 'package:my_vocab/main_screen.dart';
import 'package:my_vocab/services/firestore_data.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  signUp(
      {@required email,
      @required password,
      @required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirestoreInterface().addUser();

      Navigator.pushReplacementNamed(context, MainScreen.id);
    } catch (e) {
      log('Exception @createAccount: $e');
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

      FirestoreInterface().addUser();
      Navigator.pushReplacementNamed(context, MainScreen.id);
    } catch (e) {
      _showDialog(error: e, context: context);
    }
  }

  signInWithGoogle({@required BuildContext context}) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) {
        final SnackBar snackBar =
            SnackBar(content: Text("ERROR: Sign In cancelled by user"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await account.authentication;
      final OAuthCredential creds = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final UserCredential user = await _auth.signInWithCredential(creds);
      return user.user;
    } catch (e) {
      log("error is $e");
      _showDialog(error: e, context: context);
      return null;
    }
  }

  signInWithFacebook({@required BuildContext context}) async {
    try {
      final fb = FacebookLogin();

      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      switch (res.status) {
        case FacebookLoginStatus.success:
          final FacebookAccessToken accessToken = res.accessToken;
          final OAuthCredential credentials =
              FacebookAuthProvider.credential(accessToken.token);
          final UserCredential user =
              await _auth.signInWithCredential(credentials);
          return user;

          break;
        case FacebookLoginStatus.cancel:
          log("Exception @facebookLogin ${res.status}");
          break;
        case FacebookLoginStatus.error:
          _showDialog(
              context: context, error: "Failed to Sign In via Facebook");
          log("Exception @facebookLogin ${res.status}");
          break;
      }
    } catch (e) {
      _showDialog(error: e, context: context);
      return null;
    }
  }

  signOut({@required BuildContext context}) async {
    try {
      GoogleSignIn().signOut();
      _auth.signOut();
      Navigator.pushReplacementNamed(context, WelcomeScreen.id);
    } catch (e) {
      log('Exception @signout: $e');
    }
  }

  String getProfilePhoto() {
    final String imageUrl = FirebaseAuth.instance.currentUser.photoURL;
    return imageUrl;
  }

  String getUserName() {
    final String username = FirebaseAuth.instance.currentUser.displayName;
    return username;
  }

  _showDialog({@required error, @required BuildContext context}) {
    if (error.runtimeType == NoSuchMethodError)
      error = "UnIdentified Error!";
    else if (error.runtimeType != String)
      error = (error?.message != null) ? error?.message : "UnIdentified Error";
    final SnackBar snackBar = SnackBar(content: Text("ERROR: $error"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
