import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_vocab/viewmodels/wordDetail.dart';
import 'package:provider/provider.dart';

class WordDetailScreen extends StatefulWidget {
  static String id = "WordDetail_Screen";
  @override
  _WordDetailScreenState createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => WordDetailProvider(),
      child: ModalProgressHUD(
          inAsyncCall: Provider.of<WordDetailProvider>(context).loading,
          child: Scaffold(
            body: Center(
              child: Text("coooooooooooooooooooool"),
            ),
          )),
    );
  }
}
