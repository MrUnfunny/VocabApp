import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:my_vocab/hive/hive_db.dart';
import 'package:my_vocab/model/dictionary.dart';
import 'package:my_vocab/model/enum/api_request_status.dart';
import 'package:my_vocab/model/functions.dart' as utils;
import 'package:my_vocab/services/Dictionary/get_meaning.dart';
import 'package:my_vocab/services/api/datamuse_api.dart';
import 'package:my_vocab/services/firestore_data.dart';

class WordDetailProvider extends ChangeNotifier {
  Dictionary wordDetail;
  ApiRequestStatus apiRequestStatus = ApiRequestStatus.loading;
  List<String> rhymeList = [], synList = [], antList = [];

  Future<void> getDetail(String word) async {
    setApiStatus(ApiRequestStatus.loading);
    try {
      wordDetail = await Meaning().getMeaning(word: word);

      final rhymeRes = await datamuseApi.get(params: {
        'rel_rhy': wordDetail.word,
        'max': 10,
      });

      final synRes = await datamuseApi.get(
        params: {
          'rel_syn': wordDetail.word,
          'max': 10,
        },
      );

      final antRes = await datamuseApi.get(
        params: {
          'rel_ant': wordDetail.word,
          'max': 10,
        },
      );

      final rhymeJson = jsonDecode(rhymeRes.body);
      final synJson = jsonDecode(synRes.body);
      final antJson = jsonDecode(antRes.body);

      rhymeList.clear();
      synList.clear();
      antList.clear();

      for (var value in rhymeJson) {
        rhymeList.add(value['word'] as String);
      }
      for (var value in synJson) {
        synList.add(value['word'] as String);
      }
      for (var value in antJson) {
        antList.add(value['word'] as String);
      }

      wordDetail = wordDetail.copyWith(
        rhymes: rhymeList,
        synonynms: synList,
        antonyms: antList,
      );

      await addToHistory(wordDetail);

      await FirestoreInterface().addHistoryWords(wordDetail);

      setApiStatus(ApiRequestStatus.loaded);
    } on Exception catch (e) {
      log('@Owlbot meaning fetch failed in WordDetailProvider: $e');
      checkError(e);
    }
  }

  Future<void> addToHistory(Dictionary wordDetail) async {
    final formatter = DateFormat('yyyy-MM-dd');
    var res = {
      ...wordDetail.toMap(),
      ...{'date': '${formatter.format(DateTime.now())}'}
    };
    HiveDB.instance.put(wordDetail.word, res);
  }

  void checkError(Exception e) {
    if (utils.checkConnectionError(e)) {
      setApiStatus(ApiRequestStatus.connectionError);
    }
    setApiStatus(ApiRequestStatus.error);
  }

  void setApiStatus(ApiRequestStatus status) {
    apiRequestStatus = status;
    notifyListeners();
  }
}
