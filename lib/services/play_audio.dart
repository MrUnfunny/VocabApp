import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_vocab/services/Dictionary/get_word_audio.dart';

//for pronunciation of a word

class WordAudio {
  Future<bool> playWordAudio(String url) async {
    final audioPlayer = AudioPlayer();

    try {
      if (url == null) {
        return false;
      }
      var res = await audioPlayer.play(url);

      if (res == 1) {
        return true;
      }
      return false;
    } on Exception catch (e) {
      log('@Error occured while playing audio : $e');
      return false;
    }
  }

  Future<void> playAudio(String word) async {
    var url = await GetWordAudio().getAudio(word: word);
    bool res;
    if (url != null) {
      res = await playWordAudio(url);
      if (res) return;
    }
    await Fluttertoast.showToast(msg: 'Cannot play this audio');
  }
}
