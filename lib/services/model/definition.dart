import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Definition extends Equatable {
  final String type;
  final String definition;
  final String example;
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
}
