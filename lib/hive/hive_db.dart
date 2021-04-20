import 'package:my_vocab/constants/service_constants.dart';
import 'package:hive/hive.dart';

class HiveDB {
  static Box<Map> _box;
  static Box<String> _likedBox;
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
    _likedBox = await Hive.openBox(kLikedWordHiveDb);
  }

  Map getLiked() {
    return _likedBox.toMap();
  }

  void addtoLiked(String key, String value) {
    _likedBox.put(key, value);
  }

  void removefromLiked(String key) {
    _likedBox.delete(key);
  }

  void put(String key, Map value) {
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
