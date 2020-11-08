import 'package:hive/hive.dart';
import 'package:my_vocab/constants/service_constants.dart';

class HiveDB {
  static Box<Map> _box;
  static HiveDB _instance;

  static HiveDB get instance {
    if (_instance == null) {
      _instance = HiveDB();
    }
    ;
    return _instance;
  }

  static Future<void> init() async {
    _box = await Hive.openBox(kHistoryWordHiveDb);
  }

  void put(key, Map value) {
    _box.put(key, value);
  }

  void remove(String key) {
    _box.delete(key);
  }

  dynamic get(String key) {
    return _box.get(key);
  }

  dynamic containsKey(String key) {
    return _box.containsKey(key);
  }

  Map getAll() {
    return _box.toMap();
  }
}
