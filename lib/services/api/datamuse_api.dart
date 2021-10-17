import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

//This file handles interaction with DataMuse Api.
class _DataMuseApi {
  Future<http.Response> get({String word, Map<String, dynamic> params}) async {
    final url = _getUrl(path: 'words', params: params);
    return http.get(
      url,
    );
  }

  Uri _getUrl({path, Map<String, dynamic> params = const {}}) {
    var url = """
${env['DATAMUSE_API_URL']}$path?${_paramsToQueryString(params: params)}""";

    return Uri.parse(url);
  }

  String _paramsToQueryString(
      {Map<String, dynamic> params, String prefix = ''}) {
    var segments = <String>[];
    if (params == null) return prefix;

    params.forEach((String key, dynamic value) {
      var queryKey = prefix.isNotEmpty ? '$prefix[$key]' : key;
      if (value is String || value is num || value is DateTime) {
        segments.add('$queryKey=$value');
      }
      if (value is Map) {
        segments.add(
          _paramsToQueryString(
            params: value as Map<String, dynamic>,
            prefix: queryKey,
          ),
        );
      }
    });
    return segments.join('&');
  }
}

final datamuseApi = _DataMuseApi();
