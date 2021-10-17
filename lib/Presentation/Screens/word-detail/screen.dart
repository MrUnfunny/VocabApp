import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_vocab/Presentation/AssetWidgets/detail_screen_app_bar.dart';
import 'package:my_vocab/Presentation/AssetWidgets/error_widget.dart';
import 'package:my_vocab/Presentation/AssetWidgets/loading_widget.dart';
import 'package:my_vocab/Presentation/Screens/word-detail/realted_words.dart';
import 'package:my_vocab/model/enum/api_request_status.dart';
import 'package:my_vocab/providers/home_provider.dart';
import 'package:my_vocab/providers/word_detail_provider.dart';
import 'package:provider/provider.dart';

import 'meaning_list.dart';

class WordDetailScreen extends StatefulWidget {
  const WordDetailScreen({Key key, this.word});

  static String id = 'WordDetail_Screen';
  final String word;

  @override
  _WordDetailScreenState createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void setState(void Function() fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Provider.of<WordDetailProvider>(context, listen: false)
            .getDetail(widget.word);
        if (mounted) {
          Provider.of<HomeProvider>(context, listen: false).getHistory();
        }
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (
          BuildContext context,
          WordDetailProvider wordDetailProvider,
          Widget child,
        ) =>
            Container(
          padding: const EdgeInsets.only(top: 16.0),
          color:
              (wordDetailProvider.apiRequestStatus == ApiRequestStatus.loaded)
                  ? Theme.of(context).primaryColor
                  : Colors.white,
          child: SafeArea(
            child: (wordDetailProvider.apiRequestStatus ==
                    ApiRequestStatus.loaded)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DetailScreenAppBar(
                        word: wordDetailProvider.wordDetail.word,
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 32),
                          child: Column(
                            children: [
                              TabBar(
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelColor: Theme.of(context).primaryColor,
                                unselectedLabelColor: Colors.grey,
                                indicatorColor: const Color(0xddF54A16),
                                indicatorWeight: 2.0,
                                controller: _tabController,
                                tabs: const [
                                  Tab(
                                    text: 'MEANING',
                                  ),
                                  Tab(
                                    text: 'RELATED',
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 16.0),
                                        child: MeaningList(
                                          wordDetail:
                                              wordDetailProvider.wordDetail,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 16.0),
                                        child: RelatedWords(
                                          wordDetail:
                                              wordDetailProvider.wordDetail,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : (wordDetailProvider.apiRequestStatus ==
                        ApiRequestStatus.loading)
                    ? LoadingWidget()
                    : ErrorLoadedWidget(),
          ),
        ),
      ),
    );
  }
}
