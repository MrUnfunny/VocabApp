import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/AssetWidgets/detail_screen_app_bar.dart';
import 'package:my_vocab/Presentation/Screens/word-detail/realted_words.dart';
import 'package:my_vocab/services/Dictionary/get_meaning.dart';
import 'package:my_vocab/services/model/dictionary.dart';

import 'meaning_list.dart';

class WordDetailScreen extends StatefulWidget {
  static String id = "WordDetail_Screen";
  final String word;

  const WordDetailScreen({Key key, this.word});
  @override
  _WordDetailScreenState createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen>
    with TickerProviderStateMixin {
  bool loading = false;
  TabController _tabController;
  Future<Dictionary> wordDetailsFuture;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    wordDetailsFuture = init();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<Dictionary> init() async {
    setState(() {
      loading = true;
    });

    final Dictionary wordDetail = await Meaning().getMeaning(word: widget.word);

    setState(() {
      loading = false;
    });
    return wordDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SafeArea(
          child: FutureBuilder<Dictionary>(
            future: wordDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DetailScreenAppBar(
                      word: snapshot.data.word,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            TabBar(
                              labelColor: Theme.of(context).primaryColor,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Color(0xddF54A16),
                              indicatorWeight: 2.0,
                              controller: _tabController,
                              tabs: [
                                Tab(
                                  text: "MEANING",
                                ),
                                Tab(
                                  text: "RELATED",
                                ),
                                Tab(
                                  text: "PHRASES",
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                        Container(
                                          child: MeaningList(
                                            wordDetail: snapshot.data,
                                          ),
                                        ),
                                        Container(
                                          child: RelatedWords(
                                            word: widget.word,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: Colors.greenAccent,
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        margin: EdgeInsets.only(top: 32),
                      ),
                    )
                  ],
                );
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
