import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class RelatedWords extends Equatable {
  final String relationType;
  final List<String> words;

  RelatedWords({
    this.relationType,
    this.words,
  });

  List<Object> get props => [
        relationType,
        words,
      ];

  factory RelatedWords.fromJson(json) {
    return RelatedWords(
      relationType: json['relationType'],
      words: List.from(json['words'].map((word) => word)),
    );
  }
}
