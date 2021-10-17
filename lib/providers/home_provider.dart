import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:my_vocab/hive/hive_db.dart';
import 'package:my_vocab/model/enum/api_request_status.dart';
import 'package:my_vocab/model/functions.dart' as utils;
import 'package:my_vocab/services/Dictionary/get_word_of_the_day.dart';

class HomeProvider extends ChangeNotifier {
  Map<String, String> wordOfTheDay;
  ApiRequestStatus apiRequestStatus = ApiRequestStatus.loading;
  List<Map> historyWords;
  List<Map> favWords = [];
  List<String> likedWords = [];

  void getWordOfTheDayAndHistory() async {
    setApiRequestStatus(ApiRequestStatus.loading);
    try {
      historyWords = HiveDB.instance.getAll().values.toList() as List<Map>;

      favWords =
          historyWords.where((element) => element['isFav'] == true).toList();
      wordOfTheDay = await WordOfTheDay().getMeaning();
      likedWords = HiveDB.instance.getLiked().values.toList() as List<String>;
      setApiRequestStatus(ApiRequestStatus.loaded);
    } on Exception catch (e) {
      log('@word of the day fetch failed: $e');
      checkError(e);
    }
  }

  void getLiked() {
    likedWords = HiveDB.instance.getLiked().values.toList() as List<String>;
    notifyListeners();
  }

  void addtoLiked(String word) {
    HiveDB.instance.addtoLiked(word, word);
    getLiked();
  }

  void removeFromLiked(String word) {
    HiveDB.instance.removefromLiked(word);
    getLiked();
  }

  void getFavorites() {
    favWords =
        historyWords.where((element) => element['isFav'] == true).toList();
    notifyListeners();
  }

  void addtoFavorites(Map<String, dynamic> word) {
    final _word = word;
    _word['isFav'] = true;
    HiveDB.instance.put(_word['word'] as String, _word);
    getHistory();
  }

  void removeFromFav(Map word) {
    final _word = word;
    _word['isFav'] = false;
    HiveDB.instance.put(_word['word'] as String, _word);
    getHistory();
  }

  void getHistory() {
    historyWords = HiveDB.instance.getAll().values.toList() as List<Map>;
    historyWords.sort((a, b) => a['date'].compareTo(b['date']) as int);
    favWords =
        historyWords.where((element) => element['isFav'] == true).toList();
    notifyListeners();
  }

  void checkError(Exception e) {
    if (utils.checkConnectionError(e)) {
      setApiRequestStatus(ApiRequestStatus.connectionError);
    }
    setApiRequestStatus(ApiRequestStatus.error);
  }

  void setApiRequestStatus(ApiRequestStatus status) {
    apiRequestStatus = status;
    notifyListeners();
  }
}
