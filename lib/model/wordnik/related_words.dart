import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class RelatedWords extends Equatable {
  RelatedWords({
    this.relationType,
    this.words,
  });

  factory RelatedWords.fromJson(json) {
    return RelatedWords(
      relationType: json['relationType'] as String,
      words: List.from(json['words'].map((word) => word) as List<String>),
    );
  }

  final String relationType;
  final List<String> words;

  List<Object> get props => [
        relationType,
        words,
      ];
}
