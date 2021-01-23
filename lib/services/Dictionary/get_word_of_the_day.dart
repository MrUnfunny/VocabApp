import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:my_vocab/services/api/wordnik.dart';

///gets Word Of the Day from WordNik Api.

class WordOfTheDay {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  static final String today = formatter.format(now);

  getMeaning() async {
    Map<String, String> wordOfTheDay = {};
    log("@getting meaning for $today");
    final meaningResponse = await wordNikApi
        .get(word: 'words.json/wordOfTheDay', params: {'date': today});
    final meaningBody = jsonDecode(meaningResponse.body);

    if (meaningResponse.statusCode == 200) {
      wordOfTheDay['word'] = meaningBody["word"];
      wordOfTheDay['meaning'] = meaningBody['definitions'][0]['text'];
    } else {
      throw Exception;
    }

    return wordOfTheDay;
  }
}
