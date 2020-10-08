import 'package:flutter/material.dart';
import 'package:my_vocab/constants.dart';
import 'package:my_vocab/services/model/definition.dart';
import 'package:my_vocab/services/model/dictionary.dart';

class MeaningList extends StatelessWidget {
  final Dictionary wordDetail;

  const MeaningList({Key key, this.wordDetail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: wordDetail.definitions.length,
      itemBuilder: (context, index) {
        final Definition wordDefinition = wordDetail.definitions[index];

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
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
                                  text: wordDefinition.type,
                                  style: kMeaningTextStyle.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                                TextSpan(
                                  text:
                                      "  ${wordDefinition.definition[0].toUpperCase()}${wordDefinition.definition.substring(1)}",
                                  style: kMeaningTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                        if (wordDefinition.example != null)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              '"${wordDefinition.example[0].toUpperCase()}${wordDefinition.example.substring(1)}"',
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
            Divider(
              thickness: 1,
            ),
          ],
        );
      },
    );
  }
}
