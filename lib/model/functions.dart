import 'dart:io';
import 'package:http/http.dart';

class Functions {
  static bool checkConnectionError(Exception e) {
    if (e is SocketException ||
        e is ClientException ||
        e is HandshakeException) {
      return true;
    }
    return false;
  }
}
