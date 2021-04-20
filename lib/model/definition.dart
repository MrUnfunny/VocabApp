import 'package:hive/hive.dart';
import 'package:my_vocab/constants/service_constants.dart';

part 'definition.g.dart';

@HiveType(typeId: kDefinitionHiveType)
class Definition extends HiveObject {
  Definition({
    this.definition,
    this.example,
    this.imageUrl,
    this.type,
  });

  factory Definition.fromJson(json) {
    return Definition(
      definition: json['definition'] as String,
      type: json['type'] as String,
      example: json['example'] as String,
      imageUrl: json['image_url'] as String,
    );
  }

  @HiveField(0)
  final String type;
  @HiveField(1)
  final String definition;
  @HiveField(2)
  final String example;
  @HiveField(3)
  final String imageUrl;

  List<Object> get props => [
        type,
        definition,
        example,
        imageUrl,
      ];

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'definition': definition,
      'example': example,
      'imageUrl': imageUrl,
    };
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Definition &&
        o.type == type &&
        o.definition == definition &&
        o.example == example &&
        o.imageUrl == imageUrl;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode {
    return type.hashCode ^
        definition.hashCode ^
        example.hashCode ^
        imageUrl.hashCode;
  }
}
