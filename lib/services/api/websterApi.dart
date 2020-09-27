import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class _WebsterApi {
  Future<http.Response> get({@required word}) {
    final url = _getUrl(word);
    return http.get(
      url,
    );
  }

  _getUrl(path) {
    String url =
        "${DotEnv().env['THESAURUS_API_URL']}$path?key=${DotEnv().env['THESAURUS_API_KEY']}";
    return Uri.parse(url);
  }
}

final websterApi = _WebsterApi();
