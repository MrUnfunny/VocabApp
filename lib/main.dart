import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_vocab/Presentation/Screens/home-screen/home_screen.dart';
import 'package:my_vocab/Presentation/Screens/sign_in_screen.dart';
import 'package:my_vocab/Presentation/Screens/sign_up_screen.dart';
import 'package:my_vocab/Presentation/Screens/welcome_screen.dart';
import 'package:my_vocab/Presentation/Screens/word-detail/screen.dart';

bool isLoggedIn = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DotEnv().load('.env');

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
      initialRoute: (FirebaseAuth.instance.currentUser != null)
          ? HomePage.id
          : WelcomeScreen.id,
      routes: {
        SignInScreen.id: (context) => SignInScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        HomePage.id: (context) => HomePage(),
        WordDetailScreen.id: (context) => WordDetailScreen(),
      },
    );
  }
}
