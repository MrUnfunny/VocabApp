import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:my_vocab/model/dictionary.dart';

class FirestoreInterface {
  FirestoreInterface._() {
    firestoreInstance = FirebaseFirestore.instance;
  }
  factory FirestoreInterface() => _instance;

  FirebaseFirestore firestoreInstance;
  static final FirestoreInterface _instance = FirestoreInterface._();

  void addUser() {
    firestoreInstance
        .collection(FirebaseAuth.instance.currentUser.uid)
        .doc('username')
        .set(
      {
        'username': FirebaseAuth.instance.currentUser.displayName,
      },
    );
  }

  Future<void> addHistoryWords(Dictionary word) async {
    final formatter = DateFormat('yyyy-MM-dd');
    var wordDetail = <String, dynamic>{
      ...word.toMap(),
      ...{'date': '${formatter.format(DateTime.now())}'}
    };
    await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser.uid)
        .doc('words')
        .collection('historyWords')
        .add(wordDetail)
        .then((value) => log('history word added'));
  }

  Future<void> addLikedWords(Dictionary word) async {
    final formatter = DateFormat('yyyy-MM-dd');
    var wordDetail = {
      ...word.toMap(),
      ...{'date': '${formatter.format(DateTime.now())}'}
    };
    await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser.uid)
        .doc('words')
        .collection('likedWords')
        .add(wordDetail)
        .then((value) => log('Liked word added'));
  }

  Future<void> addFavoriteWords(Dictionary word) async {
    final formatter = DateFormat('yyyy-MM-dd');
    var wordDetail = {
      ...word.toMap(),
      ...{'date': '${formatter.format(DateTime.now())}'}
    };
    await firestoreInstance
        .collection(FirebaseAuth.instance.currentUser.uid)
        .doc('words')
        .collection('favWords')
        .add(wordDetail)
        .then((value) => log('Fav word added'));
  }

  void deleteHistoryWord(String word) {
    firestoreInstance
        .collection(FirebaseAuth.instance.currentUser.uid)
        .doc('words')
        .collection('historyWords')
        .where(word);
  }
}
