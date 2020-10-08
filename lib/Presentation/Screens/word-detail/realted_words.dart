import 'package:flutter/material.dart';
import 'package:my_vocab/constants.dart';
import 'package:my_vocab/services/model/dictionary.dart';

class RelatedWords extends StatelessWidget {
  final Dictionary wordDetail;

  const RelatedWords({Key key, this.wordDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (wordDetail.synonynms.isNotEmpty)
          WordCard(
            wordList: wordDetail.synonynms.join(' , '),
            wordType: "Synonyms",
          ),
        if (wordDetail.antonyms.isNotEmpty)
          WordCard(
            wordList: wordDetail.antonyms.join(' , '),
            wordType: "Antonyms",
          ),
        if (wordDetail.rhymes.isNotEmpty)
          WordCard(
            wordList: wordDetail.rhymes.join(' , '),
            wordType: "Rhyming Words",
          ),
      ],
    );
  }
}

class WordCard extends StatelessWidget {
  final String wordList;
  final String wordType;

  const WordCard({Key key, this.wordList, this.wordType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.0),
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
          SizedBox(
            height: 16.0,
          ),
          if (wordList.length > 0)
            Text(
              wordList,
              style: kMeaningTextStyle,
            ),
          SizedBox(
            height: 16.0,
          ),
          Divider(),
        ],
      ),
    );
  }
}
