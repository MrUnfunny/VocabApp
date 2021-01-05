import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:my_vocab/Presentation/Screens/favorites_screen/screen.dart';
import 'package:my_vocab/Presentation/Screens/home-screen/screen.dart';
import 'package:my_vocab/Presentation/Screens/like-screen/liked.dart';
import 'package:my_vocab/Presentation/Screens/sign_in_screen.dart';
import 'package:my_vocab/Presentation/Screens/sign_up_screen.dart';
import 'package:my_vocab/Presentation/Screens/welcome_screen.dart';
import 'package:my_vocab/Presentation/Screens/word-detail/screen.dart';
import 'package:my_vocab/hive/hiveDb.dart';
import 'package:my_vocab/main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_vocab/providers/home_provider.dart';
import 'package:my_vocab/providers/word_detail_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_vocab/Presentation/Screens/history-screen/history_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DotEnv().load('.env');

  final directoryPath = await getApplicationDocumentsDirectory();
  await Hive.init(directoryPath.path);
  await HiveDB.init();

  //caching all vector images so that UI doesn't have to wait for them to load
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

  runApp(
    EasyLocalization(
      path: 'Assets/langs',
      supportedLocales: [Locale('en', 'US'), Locale('hi', 'IN')],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeProvider()),
          ChangeNotifierProvider(create: (_) => WordDetailProvider()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
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
        FavScreen.id: (context) => FavScreen(),
        LikeScreen.id: (context) => LikeScreen(),
      },
    );
  }
}
