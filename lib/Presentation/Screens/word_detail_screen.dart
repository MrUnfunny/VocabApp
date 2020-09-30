import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_vocab/constants.dart';
import 'package:my_vocab/services/Dictionary/get_meaning.dart';
import 'package:my_vocab/services/model/dictionary.dart';

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
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    // init();
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
    final sliverList = <Widget>[
      SliverToBoxAdapter(
        child: Container(
          height: 200,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: BackButton(color: Colors.white)),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Abstract",
                        style: kAppBarStyle,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.bookmark_border),
                        )),
                    Icon(Icons.volume_up),
                    Icon(Icons.content_copy)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(child: Text('i')),
        ),
      ),
    ];

    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        body: SafeArea(
            child: CustomScrollView(
          slivers: sliverList,
        )),
      ),
    );
  }
}
