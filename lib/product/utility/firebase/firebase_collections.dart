import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  news,
  tags,
  recommended,
  version,
  category;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
