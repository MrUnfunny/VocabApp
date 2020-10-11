import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:my_vocab/services/model/definition.dart';

@immutable
class Dictionary extends Equatable {
  final String word;
  final String pronunciation;
  final List<Definition> definitions;
  final List<String> rhymes;
  final List<String> synonynms;
  final List<String> antonyms;

  Dictionary({
    this.word,
    this.pronunciation,
    this.definitions,
    this.rhymes,
    this.synonynms,
    this.antonyms,
  });

  List<Object> get props =>
      [word, pronunciation, definitions, rhymes, synonynms, antonyms];

  factory Dictionary.fromJson(json) {
    return Dictionary(
      word: json['word'],
      pronunciation: json['pronunciation'],
      definitions: List<Definition>.from(
        json['definitions'].map(
          (definition) => Definition.fromJson(definition),
        ),
      ),
    );
  }

  Dictionary copyWith({
    String word,
    String pronunciation,
    List<Definition> definitions,
    List<String> rhymes,
    List<String> synonynms,
    List<String> antonyms,
  }) {
    return Dictionary(
      word: word ?? this.word,
      pronunciation: pronunciation ?? this.pronunciation,
      definitions: definitions ?? this.definitions,
      rhymes: rhymes ?? this.rhymes,
      synonynms: synonynms ?? this.synonynms,
      antonyms: antonyms ?? this.antonyms,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'pronunciation': pronunciation,
      'definitions': definitions?.map((x) => x?.toMap())?.toList(),
      'rhymes': rhymes,
      'synonynms': synonynms,
      'antonyms': antonyms,
    };
  }
}
