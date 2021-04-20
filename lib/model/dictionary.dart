import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:my_vocab/constants/service_constants.dart';
import 'package:my_vocab/model/definition.dart';

part 'dictionary.g.dart';

@HiveType(typeId: kDictionaryHiveType)
class Dictionary extends HiveObject {
  Dictionary({
    this.word,
    this.pronunciation,
    this.definitions,
    this.rhymes,
    this.synonynms,
    this.antonyms,
    this.isFav = false,
    this.isLiked = false,
  });

  factory Dictionary.fromJson(json) {
    return Dictionary(
      word: json['word'] as String,
      pronunciation: json['pronunciation'] as String,
      definitions: List<Definition>.from(
        (json['definitions'] as List<String>).map(
          (definition) => Definition.fromJson(definition),
        ),
      ),
    );
  }

  @HiveField(0)
  final String word;
  @HiveField(1)
  final String pronunciation;
  @HiveField(2)
  final List<Definition> definitions;
  @HiveField(3)
  final List<String> rhymes;
  @HiveField(4)
  final List<String> synonynms;
  @HiveField(5)
  final List<String> antonyms;
  @HiveField(6)
  final bool isFav;
  @HiveField(7)
  final bool isLiked;

  List<Object> get props {
    return [
      word,
      pronunciation,
      definitions,
      rhymes,
      synonynms,
      antonyms,
    ];
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

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Dictionary &&
        o.word == word &&
        o.pronunciation == pronunciation &&
        listEquals(o.definitions, definitions) &&
        listEquals(o.rhymes, rhymes) &&
        listEquals(o.synonynms, synonynms) &&
        listEquals(o.antonyms, antonyms);
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode {
    return word.hashCode ^
        pronunciation.hashCode ^
        definitions.hashCode ^
        rhymes.hashCode ^
        synonynms.hashCode ^
        antonyms.hashCode;
  }

  @override
  String toString() {
    return '''
Dictionary(word: $word, pronunciation: $pronunciation, definitions: $definitions, rhymes: $rhymes, synonynms: $synonynms, antonyms: $antonyms, isFav: $isFav, isLiked: $isLiked)''';
  }
}
