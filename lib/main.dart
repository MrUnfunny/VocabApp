import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_vocab/Presentation/Screens/HomeScreen.dart';
import 'package:my_vocab/Presentation/Screens/Sign-In-Screen.dart';
import 'package:my_vocab/Presentation/Screens/Sign-Up-Screen.dart';
import 'package:my_vocab/Presentation/Screens/Welcome-Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'Assets/Vectors/bookReading.svg'),
      null);
  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'Assets/Vectors/googleLogo.svg'),
      null);
  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'Assets/Vectors/SignUp.svg'),
      null);
  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'Assets/Vectors/welcomeBack.svg'),
      null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xffff4f18),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        SignInScreen.id: (context) => SignInScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        HomePage.id: (context) => HomePage(),
      },
    );
  }
}
