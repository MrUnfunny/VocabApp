import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_vocab/services/Models/dictionary.dart';
import 'package:my_vocab/services/api/owlBotApi.dart';

class Meaning {
  getMeaning({@required word}) async {
    final meaningResponse = await owlbotApi.get(word: word);
    final meaning = Dictionary.fromJson(jsonDecode(meaningResponse.body));
    print(meaning.props);
    for (var val in meaning.definitions) {
      print(val.props);
    }
  }
}
