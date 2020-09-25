import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_vocab/services/Models/definition.dart';

@immutable
class Dictionary extends Equatable {
  final String word;
  final String pronounciation;
  final List<Definition> definitions;

  Dictionary({
    this.word,
    this.pronounciation,
    this.definitions,
  });

  List<Object> get props => [word, pronounciation, definitions];

  factory Dictionary.fromJson(json) {
    return Dictionary(
      word: json['word'],
      pronounciation: json['pronounciation'],
      definitions: List<Definition>.from(
        json['definitions'].map(
          (definition) => Definition.fromJson(definition),
        ),
      ),
    );
  }
}
