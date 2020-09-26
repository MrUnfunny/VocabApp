import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class _OwlBotApi {
  Future<http.Response> get({@required word}) {
    final url = _getUrl(word);
    final headers = _getHeaders();
    print("url is : $url, $word, headers is $headers");

    return http.get(url, headers: headers);
  }

  _getUrl(path) {
    String url = "${DotEnv().env['API_URL']}$path";
    return Uri.parse(url);
  }

  _getHeaders() {
    final headers = {"Authorization": "Token ${DotEnv().env['API_TOKEN']}"};
    return headers;
  }
}

final owlbotApi = _OwlBotApi();
