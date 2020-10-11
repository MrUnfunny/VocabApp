import 'dart:io';

import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';

class HistoryDB {
  getPath() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = documentDirectory.path + '/history.db';
    return path;
  }

  add(Map item) async {
    final db = ObjectDB(await getPath());
    db.open();
    int update = await db.update({'word': item['word']}, item);
    if (update == 0) db.insert(item);
    db.tidy();
    await db.close();
  }

  Future<int> remove(Map item) async {
    final db = ObjectDB(await getPath());
    db.open();
    int val = await db.remove(item);
    db.tidy();
    await db.close();
    return val;
  }

  Future<List> listAll() async {
    final db = ObjectDB(await getPath());
    db.open();
    List val = await db.find({});
    db.tidy();
    await db.close();
    return val;
  }

  Future<List> check(Map item) async {
    final db = ObjectDB(await getPath());
    db.open();
    List val = await db.find(item);
    db.tidy();
    await db.close();
    return val;
  }

  clear() async {
    final db = ObjectDB(await getPath());
    db.open();
    db.remove({});
  }
}
