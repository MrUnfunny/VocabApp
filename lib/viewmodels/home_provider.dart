import 'package:flutter/cupertino.dart';
import 'package:my_vocab/hive/hiveDb.dart';
import 'package:my_vocab/services/Dictionary/get_word_of_the_day.dart';
import 'package:my_vocab/model/enum/api_request_status.dart';
import 'package:my_vocab/model/functions.dart';

class HomeProvider extends ChangeNotifier {
  Map<String, String> wordOfTheDay;
  ApiRequestStatus apiRequestStatus = ApiRequestStatus.loading;
  List<Map> historyWords;
  List<Map> favWords = [];

  void getWordOfTheDayAndHistory() async {
    setApiRequestStatus(ApiRequestStatus.loading);
    try {
      historyWords = HiveDB.instance.getAll().values.toList();
      historyWords.sort((a, b) => a['date'].compareTo(b['date']));
      print('\n\n\n');
      print(HiveDB.instance.getAll());
      print('\n\n\n');

      favWords =
          historyWords.where((element) => element['isFav'] == true).toList();
      wordOfTheDay = await WordOfTheDay().getMeaning();
      setApiRequestStatus(ApiRequestStatus.loaded);
    } catch (e) {
      print("@word of the day fetch failed: $e");
      checkError(e);
    }
  }

  void getFavorites() {
    favWords =
        historyWords.where((element) => element['isFav'] == true).toList();
    notifyListeners();
  }

  void addtoFavorites(Map word) {
    final _word = word;
    _word['isFav'] = true;
    HiveDB.instance.put(_word['word'], _word);
    getHistory();
  }

  void removeFromFav(Map word) {
    final _word = word;
    _word['isFav'] = false;
    HiveDB.instance.put(_word['word'], _word);
    getHistory();
  }

  void getHistory() async {
    historyWords = HiveDB.instance.getAll().values.toList();
    historyWords.sort((a, b) => a['date'].compareTo(b['date']));
    favWords =
        historyWords.where((element) => element['isFav'] == true).toList();
    print('\n\n\n');
    print(historyWords);
    print('\n\n\n');
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
