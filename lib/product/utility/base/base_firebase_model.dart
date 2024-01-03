import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_news_app/product/utility/exceptions/custom_exception.dart';

abstract mixin class IdModel {
  String? get id;
}

abstract mixin class BaseFirebaseModel<T extends IdModel> {
  T fromJson(Map<String, dynamic> json);

  T fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final value = snapshot.data();
    if (value == null) {
      throw FirebaseCustomException('$snapshot data is null');
    }
    // fixme
    value.addEntries([MapEntry('id', snapshot.id)]);
    return fromJson(value);
  }
}
