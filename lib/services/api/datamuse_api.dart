import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

//This file handles interaction with DataMuse Api.
class _DataMuseApi {
  Future<http.Response> get({word, Map<String, dynamic> params}) {
    final url = _getUrl(path: 'words', params: params);
    return http.get(
      url,
    );
  }

  _getUrl({path, Map<String, dynamic> params = const {}}) {
    String url =
        "${env['DATAMUSE_API_URL']}$path?${_paramsToQueryString(params: params)}";

    return Uri.parse(url);
  }

  _paramsToQueryString({Map<String, dynamic> params, String prefix = ""}) {
    List<String> segments = [];
    if (params == null) return prefix;

    params.forEach((String key, dynamic value) {
      String queryKey = prefix.length > 0 ? "$prefix[$key]" : key;
      if (value is String || value is num || value is DateTime) {
        segments.add("$queryKey=$value");
      }
      if (value is Map) {
        segments.add(_paramsToQueryString(params: value, prefix: queryKey));
      }
    });
    return segments.join("&");
  }
}

final datamuseApi = _DataMuseApi();
