import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_vocab/model/dictionary.dart';
import 'package:my_vocab/services/api/owl_bot_api.dart';

class Meaning {
  getMeaning({@required word}) async {
    print("@getting meaning for $word");
    final meaningResponse = await owlbotApi.get(word: word);
    try {
      final meaning = Dictionary.fromJson(jsonDecode(meaningResponse.body));
      print(meaning.props);
      for (var val in meaning.definitions) {
        print(val.props);
      }
      return meaning;
    } catch (e) {
      print('@Error in getting meaning: $e');
      return null;
    }
  }
}
