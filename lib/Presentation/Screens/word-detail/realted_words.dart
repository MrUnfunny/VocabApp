import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_vocab/constants.dart';
import 'package:my_vocab/services/api/datamuse_api.dart';

class RelatedWords extends StatefulWidget {
  final word;

  const RelatedWords({Key key, this.word}) : super(key: key);

  @override
  _RelatedWordsState createState() => _RelatedWordsState();
}

class _RelatedWordsState extends State<RelatedWords> {
  Future<RelatedWordList> relatedWordList;
  String synonyms;
  String antonyms;
  String rhymes;

  @override
  void initState() {
    super.initState();
    relatedWordList = init();
  }

  Future<RelatedWordList> init() async {
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

    rhymes = rhymeList.join(' , ');
    synonyms = synList.join(' , ');
    antonyms = antList.join(' , ');

    print(rhymeList);
    print(synList);
    print(antList);
    return RelatedWordList(
        rhymes: rhymeList, synonynms: synList, antonyms: antList);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: relatedWordList,
      builder: (BuildContext context, AsyncSnapshot<RelatedWordList> snapshot) {
        if (snapshot.hasData)
          return ListView(
            children: [
              if (snapshot.data.synonynms.isNotEmpty)
                WordCard(
                  wordList: synonyms,
                  wordType: "Synonyms",
                ),
              if (snapshot.data.antonyms.isNotEmpty)
                WordCard(
                  wordList: antonyms,
                  wordType: "Antonyms",
                ),
              if (snapshot.data.rhymes.isNotEmpty)
                WordCard(
                  wordList: rhymes,
                  wordType: "Rhyming Words",
                ),
              Container(),
            ],
          );
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class WordCard extends StatefulWidget {
  final String wordList;
  final String wordType;

  const WordCard({Key key, this.wordList, this.wordType}) : super(key: key);

  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  String requiredString;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.wordType,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 16.0,
          ),
          if (widget.wordList.length > 0)
            Text(
              widget.wordList,
              style: kMeaningTextStyle,
            ),
          Divider(),
        ],
      ),
    );
  }
}

class RelatedWordList {
  final List<String> rhymes;
  final List<String> synonynms;
  final List<String> antonyms;

  RelatedWordList({this.rhymes, this.synonynms, this.antonyms});

  List<Object> get props => [rhymes, synonynms, antonyms];
}
