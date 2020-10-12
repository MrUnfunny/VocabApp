import 'package:flutter/cupertino.dart';
import 'package:my_vocab/services/Dictionary/get_word_of_the_day.dart';
import 'package:my_vocab/services/model/enum/api_request_status.dart';
import 'package:my_vocab/services/model/functions.dart';

class HomeProvider extends ChangeNotifier {
  Map<String, String> wordOfTheDay;
  ApiRequestStatus apiRequestStatus = ApiRequestStatus.loading;

  getWordOfTheDay() async {
    setApiRequestStatus(ApiRequestStatus.loading);
    try {
      wordOfTheDay = await WordOfTheDay().getMeaning();
    } catch (e) {
      checkError(e);
    }
  }

  void checkError(Exception e) {
    if (Functions.checkConnectionError(e))
      setApiRequestStatus(ApiRequestStatus.connectionError);
    setApiRequestStatus(ApiRequestStatus.error);
  }

  void setApiRequestStatus(ApiRequestStatus status) {
    apiRequestStatus = status;
    notifyListeners();
  }
}
