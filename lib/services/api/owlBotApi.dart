import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class _OwlBotApi {
  Future<http.Response> get({@required word}) {
    final url = _getUrl(word);
    return http.get(url, headers: _getHeaders());
  }

  _getUrl(path) async {
    String url = "${DotEnv().env['API_URL']}$path)}";
    return Uri.parse(url);
  }

  _getHeaders() {
    Map<String, dynamic> headers = {
      "Authorization": "Token ${DotEnv().env['API_TOKEN']}"
    };
    return headers;
  }
}

final owlbotApi = _OwlBotApi();
