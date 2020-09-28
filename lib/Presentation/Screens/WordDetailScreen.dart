import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_vocab/services/Dictionary/getMeaning.dart';
import 'package:my_vocab/services/Models/dictionary.dart';

class WordDetailScreen extends StatefulWidget {
  static String id = "WordDetail_Screen";
  final String word;

  const WordDetailScreen({Key key, this.word});
  @override
  _WordDetailScreenState createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  Dictionary wordDetail;
  bool loading = false;

  @override
  void setState(fn) {
    // TODO: implement setState
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setState(() {
      loading = true;
    });

    wordDetail = await Meaning().getMeaning(word: widget.word);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: loading,
        child: Scaffold(
          body: Center(
            child: (!loading)
                ? Text(wordDetail.definitions[0].definition)
                : Text("Loading"),
          ),
        ));
  }
}
