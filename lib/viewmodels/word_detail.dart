import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:my_vocab/services/model/dictionary.dart';
import 'package:my_vocab/services/api/owl_bot_api.dart';

class WordDetailProvider extends ChangeNotifier {
  bool loading = true;
  Dictionary wordDetail;

  getDetail(word) async {
    setLoading(true);
    try {
      final res = await owlbotApi.get(word: word);
      wordDetail = Dictionary.fromJson(jsonDecode(res.body));
      setLoading(false);
    } catch (e) {
      print("@Owlbot meaning fetch failed in WordDetailProvider: $e");
    }
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  setDetail() {}
}
