import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_vocab/Presentation/AssetWidgets/detail_screen_app_bar.dart';
import 'package:my_vocab/services/Dictionary/get_meaning.dart';
import 'package:my_vocab/services/model/definition.dart';
import 'package:my_vocab/services/model/dictionary.dart';

class WordDetailScreen extends StatefulWidget {
  static String id = "WordDetail_Screen";
  final String word;

  const WordDetailScreen({Key key, this.word});
  @override
  _WordDetailScreenState createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen>
    with TickerProviderStateMixin {
  Dictionary wordDetail;
  bool loading = false;
  TabController _tabController;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    init();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DetailScreenAppBar(
                  word: this?.wordDetail?.word,
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
                              text: "EXAMPLE",
                            ),
                            Tab(
                              text: "TRANSLATION",
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: ListView.builder(
                                        itemCount:
                                            wordDetail?.definitions?.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final Definition wordDefinition =
                                              wordDetail.definitions[index];

                                          return Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 20.0,
                                                        right: 30.0,
                                                      ),
                                                      child: Text((index + 1)
                                                          .toString()),
                                                    ),
                                                    Expanded(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  wordDefinition
                                                                      .type,
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: wordDefinition
                                                                  .definition,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.blueGrey,
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
            ),
          ),
        ),
      ),
    );
  }
}
