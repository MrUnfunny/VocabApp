import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_vocab/Presentation/AssetWidgets/detail_screen_app_bar.dart';
import 'package:my_vocab/Presentation/Screens/word-detail/realted_words.dart';
import 'package:my_vocab/services/Dictionary/get_meaning.dart';
import 'package:my_vocab/services/api/datamuse_api.dart';
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

  String synonyms;
  String antonyms;
  String rhymes;

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

    List<String> rhymeList = [], synList = [], antList = [];

    final rhymeRes =
        await datamuseApi.get(params: {'rel_rhy': widget.word, "max": 10});
    final synRes =
        await datamuseApi.get(params: {'rel_syn': widget.word, "max": 10});
    final antRes =
        await datamuseApi.get(params: {'rel_ant': widget.word, "max": 10});

    final rhymeJson = jsonDecode(rhymeRes.body);
    final synJson = jsonDecode(synRes.body);
    final antJson = jsonDecode(antRes.body);

    for (var value in rhymeJson) {
      rhymeList.add(value['word']);
    }
    for (var value in synJson) {
      synList.add(value['word']);
    }
    for (var value in antJson) {
      antList.add(value['word']);
    }

    setState(() {
      loading = false;
    });
    return wordDetail.copyWith(
      rhymes: rhymeList,
      synonynms: synList,
      antonyms: antList,
    );
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
                              indicatorSize: TabBarIndicatorSize.tab,
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
                                          margin: EdgeInsets.only(top: 16.0),
                                          child: MeaningList(
                                            wordDetail: snapshot.data,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 16.0),
                                          child: RelatedWords(
                                            wordDetail: snapshot.data,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 16.0),
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
