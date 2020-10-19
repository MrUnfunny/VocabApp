import 'package:flutter/cupertino.dart';
import 'package:my_vocab/services/Dictionary/get_word_of_the_day.dart';
import 'package:my_vocab/services/local_databases/history.dart';
import 'package:my_vocab/services/model/enum/api_request_status.dart';
import 'package:my_vocab/services/model/functions.dart';

class HomeProvider extends ChangeNotifier {
  Map<String, String> wordOfTheDay;
  ApiRequestStatus apiRequestStatus = ApiRequestStatus.loading;
  List<Map> historyWords;

  getWordOfTheDayAndHistory() async {
    setApiRequestStatus(ApiRequestStatus.loading);
    try {
      historyWords = await HistoryDB().listAll();
      wordOfTheDay = await WordOfTheDay().getMeaning();
      setApiRequestStatus(ApiRequestStatus.loaded);
    } catch (e) {
      print("@word of the day fetch failed: $e");
      checkError(e);
    }
  }

  getHistory() async {
    historyWords = (await HistoryDB().listAll()).reversed.toList();
    notifyListeners();
  }

  void checkError(e) {
    if (Functions.checkConnectionError(e))
      setApiRequestStatus(ApiRequestStatus.connectionError);
    setApiRequestStatus(ApiRequestStatus.error);
  }

  void setApiRequestStatus(ApiRequestStatus status) {
    apiRequestStatus = status;
    notifyListeners();
  }
}
