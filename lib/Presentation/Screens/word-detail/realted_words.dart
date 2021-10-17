import 'package:flutter/material.dart';
import 'package:my_vocab/constants/configs.dart';
import 'package:my_vocab/model/dictionary.dart';

class RelatedWords extends StatelessWidget {
  const RelatedWords({Key key, this.wordDetail}) : super(key: key);

  final Dictionary wordDetail;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (wordDetail.synonynms.isNotEmpty)
          WordCard(
            wordList: wordDetail.synonynms.join(' , '),
            wordType: 'Synonyms',
          ),
        if (wordDetail.antonyms.isNotEmpty)
          WordCard(
            wordList: wordDetail.antonyms.join(' , '),
            wordType: 'Antonyms',
          ),
        if (wordDetail.rhymes.isNotEmpty)
          WordCard(
            wordList: wordDetail.rhymes.join(' , '),
            wordType: 'Rhyming Words',
          ),
      ],
    );
  }
}

class WordCard extends StatelessWidget {
  const WordCard({Key key, this.wordList, this.wordType}) : super(key: key);

  final String wordList;
  final String wordType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            wordType,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor),
          ),
          const SizedBox(
            height: 16.0,
          ),
          if (wordList.isNotEmpty)
            Text(
              wordList,
              style: kMeaningTextStyle,
            ),
          const SizedBox(
            height: 16.0,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
