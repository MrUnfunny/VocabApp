import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_vocab/Presentation/Screens/favorites/favorites_screen.dart';
import 'package:my_vocab/Presentation/Screens/home-screen/screen.dart';
import 'package:my_vocab/Presentation/Screens/settings/settings_screen.dart';
import 'package:my_vocab/Presentation/Screens/sign_in_screen.dart';
import 'package:my_vocab/Presentation/Screens/sign_up_screen.dart';
import 'package:my_vocab/Presentation/Screens/welcome_screen.dart';
import 'package:my_vocab/Presentation/Screens/word-detail/screen.dart';
import 'package:my_vocab/main_screen.dart';
import 'package:my_vocab/viewmodels/home_provider.dart';
import 'package:my_vocab/viewmodels/word_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_vocab/Presentation/Screens/history-screen/history_screen.dart';

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
  await precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'Assets/Vectors/error.svg'),
      null);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => WordDetailProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xffff4f18),
      ),
      initialRoute: (FirebaseAuth.instance.currentUser != null)
          ? MainScreen.id
          : WelcomeScreen.id,
      routes: {
        MainScreen.id: (context) => MainScreen(),
        SignInScreen.id: (context) => SignInScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        WordDetailScreen.id: (context) => WordDetailScreen(),
        HistoryScreen.id: (context) => HistoryScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        FavScreen.id: (context) => FavScreen(),
      },
    );
  }
}
