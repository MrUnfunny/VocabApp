import 'package:flutter/material.dart';
import 'package:my_vocab/constants/configs.dart';
import 'package:my_vocab/model/dictionary.dart';
import 'package:my_vocab/services/utils.dart';

class MeaningList extends StatelessWidget {
  const MeaningList({Key key, this.wordDetail}) : super(key: key);

  final Dictionary wordDetail;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: wordDetail.definitions.length,
      itemBuilder: (context, index) {
        final wordDefinition = wordDetail.definitions[index];

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 30.0,
                    ),
                    child: Text(
                      (index + 1).toString(),
                      style: kMeaningTextStyle,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${wordDefinition.type} ',
                                  style: kMeaningTextStyle.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                                TextSpan(
                                  text: capitalize(wordDefinition.definition),
                                  style: kMeaningTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (wordDefinition.example != null &&
                            wordDefinition.example != '')
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              capitalize(wordDefinition.example),
                              style: kMeaningTextStyle.copyWith(
                                  color: Colors.grey),
                            ),
                          ),
                        if (wordDefinition.imageUrl != null)
                          Image.network(wordDefinition.imageUrl),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
          ],
        );
      },
    );
  }
}
