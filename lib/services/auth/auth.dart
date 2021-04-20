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
  Future<void> signUp(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirestoreInterface().addUser();

      await Navigator.pushReplacementNamed(context, MainScreen.id);
    } on Exception catch (e) {
      log('Exception @createAccount: $e');
      _showDialog(
        error: e,
        context: context,
      );
    }
  }

  Future<void> signIn(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      FirestoreInterface().addUser();
      await Navigator.pushReplacementNamed(context, MainScreen.id);
    } on Exception catch (e) {
      _showDialog(error: e, context: context);
    }
  }

  Future<User> signInWithGoogle({@required BuildContext context}) async {
    try {
      final googleSignIn = GoogleSignIn();
      final account = await googleSignIn.signIn();
      if (account == null) {
        final snackBar =
            const SnackBar(content: Text('ERROR: Sign In cancelled by user'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return null;
      }
      final googleAuth = await account.authentication;
      final creds = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final user = await _auth.signInWithCredential(creds);
      return user.user;
    } on Exception catch (e) {
      log('error is $e');
      _showDialog(error: e, context: context);
      return null;
    }
  }

  // ignore: missing_return
  Future<UserCredential> signInWithFacebook(
      {@required BuildContext context}) async {
    try {
      final fb = FacebookLogin();

      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      switch (res.status) {
        case FacebookLoginStatus.success:
          final accessToken = res.accessToken;
          final credentials =
              FacebookAuthProvider.credential(accessToken.token);
          final user = await _auth.signInWithCredential(credentials);
          return user;

          break;
        case FacebookLoginStatus.cancel:
          log('Exception @facebookLogin ${res.status}');
          break;
        case FacebookLoginStatus.error:
          _showDialog(
              context: context, error: 'Failed to Sign In via Facebook');
          log('Exception @facebookLogin ${res.status}');
          break;
      }
    } on Exception catch (e) {
      _showDialog(error: e, context: context);
      return null;
    }
  }

  Future<void> signOut({@required BuildContext context}) async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      await Navigator.pushReplacementNamed(context, WelcomeScreen.id);
    } on Exception catch (e) {
      log('Exception @signout: $e');
    }
  }

  ImageProvider<Object> getProfilePhoto() {
    final imageUrl = FirebaseAuth.instance.currentUser.photoURL;
    if (imageUrl == null) {
      return const AssetImage('Assets/images/profile.png');
    }
    return NetworkImage(imageUrl);
  }

  String getUserName() {
    final username = FirebaseAuth.instance.currentUser.displayName;
    return username;
  }

  _showDialog({@required error, @required BuildContext context}) {
    if (error.runtimeType == NoSuchMethodError) {
      error = 'UnIdentified Error!';
    } else if (error.runtimeType != String) {
      error = (error?.message != null) ? error?.message : 'UnIdentified Error';
    }
    final snackBar = SnackBar(content: Text('ERROR: $error'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
