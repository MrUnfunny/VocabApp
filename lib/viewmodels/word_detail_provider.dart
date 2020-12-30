import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:my_vocab/hive/hiveDb.dart';
import 'package:my_vocab/model/dictionary.dart';
import 'package:my_vocab/model/enum/api_request_status.dart';
import 'package:my_vocab/model/functions.dart';
import 'package:my_vocab/services/Dictionary/get_meaning.dart';
import 'package:my_vocab/services/api/datamuse_api.dart';

class WordDetailProvider extends ChangeNotifier {
  Dictionary wordDetail;
  ApiRequestStatus apiRequestStatus = ApiRequestStatus.loading;
  List<String> rhymeList = [], synList = [], antList = [];

  getDetail(word) async {
    setApiStatus(ApiRequestStatus.loading);
    try {
      wordDetail = await Meaning().getMeaning(word: word);

      final rhymeRes = await datamuseApi
          .get(params: {'rel_rhy': wordDetail.word, "max": 10});
      final synRes = await datamuseApi
          .get(params: {'rel_syn': wordDetail.word, "max": 10});
      final antRes = await datamuseApi
          .get(params: {'rel_ant': wordDetail.word, "max": 10});

      final rhymeJson = jsonDecode(rhymeRes.body);
      final synJson = jsonDecode(synRes.body);
      final antJson = jsonDecode(antRes.body);

      rhymeList.clear();
      synList.clear();
      antList.clear();

      for (var value in rhymeJson) {
        rhymeList.add(value['word']);
      }
      for (var value in synJson) {
        synList.add(value['word']);
      }
      for (var value in antJson) {
        antList.add(value['word']);
      }

      await addToHistory(wordDetail);

      setApiStatus(ApiRequestStatus.loaded);
    } catch (e) {
      print("@Owlbot meaning fetch failed in WordDetailProvider: $e");
      checkError(e);
    }
  }

  addToHistory(Dictionary wordDetail) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    Map res = {
      ...wordDetail.toMap(),
      ...{'date': '${formatter.format(DateTime.now())}'}
    };
    HiveDB.instance.put(wordDetail.word, res);
  }

  void checkError(e) {
    if (Functions.checkConnectionError(e))
      setApiStatus(ApiRequestStatus.connectionError);
    setApiStatus(ApiRequestStatus.error);
  }

  void setApiStatus(ApiRequestStatus status) {
    apiRequestStatus = status;
    notifyListeners();
  }
}
