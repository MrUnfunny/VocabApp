import 'package:equatable/equatable.dart';
import 'package:my_vocab/services/model/wordnik/related_words.dart';

class WordNikResponse extends Equatable {
  final String id;
  final String partOfSpeech;
  final String attributionText;
  final String sourceDictionary;
  final String text;
  final String sequence;
  final int score;
  final String word;
  final List<RelatedWords> relatedWords;
  final List<String> exampleUses;
  final List<String> textProns;
  final List<String> notes;
  final String attributionUrl;
  final String wordnikUrl;

  WordNikResponse({
    this.id,
    this.partOfSpeech,
    this.attributionText,
    this.sourceDictionary,
    this.text,
    this.sequence,
    this.score,
    this.word,
    this.relatedWords,
    this.exampleUses,
    this.textProns,
    this.notes,
    this.attributionUrl,
    this.wordnikUrl,
  });

  List<Object> get props => [
        id,
        partOfSpeech,
        attributionText,
        sourceDictionary,
        text,
        sequence,
        score,
        word,
        relatedWords,
        exampleUses,
        textProns,
        notes,
        attributionUrl,
        wordnikUrl,
      ];

  factory WordNikResponse.fromJson(json) {
    return WordNikResponse(
      id: json['id'],
      partOfSpeech: json['partOfSpeech'],
      attributionText: json['attributionText'],
      sourceDictionary: json['sourceDictionary'],
      text: json['text'],
      sequence: json['sequence'],
      score: json['score'],
      word: json['word'],
      relatedWords: json['relatedWords'],
      exampleUses: json['exampleUses'],
      textProns: json['textProns'],
      notes: json['notes'],
      attributionUrl: json['attributionUrl'],
      wordnikUrl: json['wordnikUrl'],
    );
  }
}
