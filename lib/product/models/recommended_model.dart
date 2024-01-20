import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_news_app/product/utility/base/base_firebase_model.dart';

@immutable
class Recommended with EquatableMixin, IdModel, BaseFirebaseModel<Recommended> {
  const Recommended({
    this.id,
    this.image,
    this.description,
    this.title,
  });

  final String? image;
  final String? description;
  final String? title;
  @override
  final String? id;

  @override
  List<Object?> get props => [image, description, title, id];

  Recommended copyWith({
    String? id,
    String? image,
    String? description,
    String? title,
  }) {
    return Recommended(
      id: id ?? this.id,
      image: image ?? this.image,
      description: description ?? this.description,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'description': description,
      'title': title,
    };
  }

  @override
  Recommended fromJson(Map<String, dynamic> json) {
    return Recommended(
      image: json['image'] as String?,
      description: json['description'] as String?,
      title: json['title'] as String?,
    );
  }
}
