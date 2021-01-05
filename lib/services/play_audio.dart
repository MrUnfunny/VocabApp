import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_vocab/services/Dictionary/get_word_audio.dart';

//for pronunciation of a word

class WordAudio {
  Future<bool> playWordAudio(url) async {
    final AudioPlayer audioPlayer = AudioPlayer();

    try {
      if (url == null) {
        return false;
      }
      int res = await audioPlayer.play(url);

      if (res == 1) {
        return true;
      }
      return false;
    } catch (e) {
      log("@Error occured while playing audio : $e");
      return false;
    }
  }

  playAudio(String word) async {
    String url = await GetWordAudio().getAudio(word: word);
    bool res;
    if (url != null) {
      res = await playWordAudio(url);
      if (res) return;
    }
    Fluttertoast.showToast(msg: "Cannot play this audio");
  }
}
