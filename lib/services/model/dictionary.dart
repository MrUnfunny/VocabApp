import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_vocab/services/model/definition.dart';

@immutable
class Dictionary extends Equatable {
  final String word;
  final String pronunciation;
  final List<Definition> definitions;

  Dictionary({
    this.word,
    this.pronunciation,
    this.definitions,
  });

  List<Object> get props => [word, pronunciation, definitions];

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
}
