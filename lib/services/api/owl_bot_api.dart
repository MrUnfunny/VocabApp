import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// This file gets meaning of word from OwlBotApi
class _OwlBotApi {
  Future<http.Response> get({@required String word}) async {
    final url = _getUrl(word);
    final headers = _getHeaders();

    return http.get(url, headers: headers);
  }

  Uri _getUrl(path) {
    var url = "${dotenv.env['API_URL']}$path";
    return Uri.parse(url);
  }

  Map<String, String> _getHeaders() {
    final headers = {'Authorization': "Token ${dotenv.env['API_TOKEN']}"};
    return headers;
  }
}

final owlbotApi = _OwlBotApi();
