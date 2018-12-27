import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovaciondocente_app/src/database/database.dart';
import 'package:innovaciondocente_app/src/models/innova-tip.dart';

class InnovaTipsProgramaFormacionDatabase extends Database<InnovaTip> {
  @override
  Stream<List<InnovaTip>> getStream({int limit = 6}) {
    return FirestoreStream<List<InnovaTip>>(
      parser: _InnovaTipsParser(),
      query: Firestore.instance
          .collection('formacion-docente/programa-formacion/tips')
          .orderBy('added', descending: true)
          .limit(limit),
    ).stream;
  }
}

class _InnovaTipsParser extends FirestoreNodeParser<List<InnovaTip>> {
  @override
  List<InnovaTip> parse(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((snapshot) => InnovaTip.fromJRON(
              id: snapshot.documentID,
              data: snapshot.data,
            ))
        .toList();
  }
}
