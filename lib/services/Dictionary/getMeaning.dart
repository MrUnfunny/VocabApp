import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_vocab/services/api/api.dart';

class Dictionary {
  getMeaning({@required word}) async {
    final meaningResponse = await api.get(word: word);
    final meaningJson = jsonDecode(meaningResponse.body);
    print(meaningJson);
  }
}
