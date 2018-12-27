import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovaciondocente_app/src/database/database.dart';
import 'package:innovaciondocente_app/src/models/tip-innovacion.dart';

class TipsInnovacionDatabase implements DB<TipInnovacion> {
  Stream<List<TipInnovacion>> getStream({int limit = 20}) {
    return FirestoreStream<List<TipInnovacion>>(
      parser: FirestoreTipsParser(),
      query: Firestore.instance
          .collection('/observatorio/edutendencias/tips')
          .orderBy('edited', descending: true)
          .limit(limit),
    ).stream;
  }
}

class FirestoreTipsParser extends FirestoreNodeParser<List<TipInnovacion>> {
  List<TipInnovacion> parse(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((snapshot) {
      return TipInnovacion.fromJSON(
        data: snapshot.data,
        id: snapshot.documentID,
      );
    }).toList();
  }
}
