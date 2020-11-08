import 'package:hive/hive.dart';
import 'package:my_vocab/constants/service_constants.dart';

part 'definition.g.dart';

@HiveType(typeId: kDefinitionHiveType)
class Definition extends HiveObject {
  @HiveField(0)
  final String type;
  @HiveField(1)
  final String definition;
  @HiveField(2)
  final String example;
  @HiveField(3)
  final String imageUrl;

  Definition({
    this.definition,
    this.example,
    this.imageUrl,
    this.type,
  });

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

  factory Definition.fromJson(json) {
    return Definition(
      definition: json['definition'],
      type: json['type'],
      example: json['example'],
      imageUrl: json['image_url'],
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Definition &&
        o.type == type &&
        o.definition == definition &&
        o.example == example &&
        o.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        definition.hashCode ^
        example.hashCode ^
        imageUrl.hashCode;
  }
}
