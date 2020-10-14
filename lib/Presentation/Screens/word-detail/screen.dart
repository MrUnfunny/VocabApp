import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_vocab/Presentation/AssetWidgets/detail_screen_app_bar.dart';
import 'package:my_vocab/Presentation/Screens/word-detail/realted_words.dart';
import 'package:my_vocab/constants.dart';
import 'package:my_vocab/services/Dictionary/get_meaning.dart';
import 'package:my_vocab/services/api/datamuse_api.dart';
import 'package:my_vocab/services/local_databases/history.dart';
import 'package:my_vocab/services/model/dictionary.dart';
import 'package:my_vocab/viewmodels/home_provider.dart';
import 'package:provider/provider.dart';

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
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    wordDetailsFuture = init();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<Dictionary> init() async {
    var a = await HistoryDB().listAll();
    print(a);
    print(a.length);
    setState(() {
      loading = true;
    });

    final Dictionary wordDetail = await Meaning().getMeaning(word: widget.word);
    if (wordDetail == null) return null;

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
    await _addToHistory(wordDetail);
    return wordDetail.copyWith(
      rhymes: rhymeList,
      synonynms: synList,
      antonyms: antList,
    );
  }

  _addToHistory(Dictionary wordDetail) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    Map res = {
      ...wordDetail.toMap(),
      ...{'date': '${formatter.format(DateTime.now())}'}
    };
    await HistoryDB().add(res);
    Provider.of<HomeProvider>(context, listen: false).getHistory();

    print("done");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 16.0),
        color: (loading) ? Colors.white : Theme.of(context).primaryColor,
        child: SafeArea(
          child: FutureBuilder<Dictionary>(
            future: wordDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data == null) {
                return Center(
                  child: Text(
                    "MEANING NOT FOUND",
                    style: kLargeTextStyle,
                  ),
                );
              }
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
                                // Tab(
                                //   text: "PHRASES",
                                // ),
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
                                        // Container(
                                        //   margin: EdgeInsets.only(top: 16.0),
                                        //   decoration: BoxDecoration(
                                        //     borderRadius:
                                        //         BorderRadius.circular(8.0),
                                        //     color: Colors.greenAccent,
                                        //   ),
                                        // ),
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
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
