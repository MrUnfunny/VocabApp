import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_vocab/services/api/wordnik.dart';

/// gets url for audio file for pronunciation of a word from WordNik Api
class GetWordAudio {
  Future<String> getAudio({@required String word}) async {
    final meaningResponse =
        await wordNikApi.get(word: 'word.json/${word.trim()}/audio');
    final meaningBody = jsonDecode(meaningResponse.body);

    if (meaningResponse.statusCode == 200) {
      return meaningBody[0]['fileUrl'];
    } else {
      return null;
    }
  }
}
