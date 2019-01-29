import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Ascendere_UTPL/src/database/database.dart';
import 'package:Ascendere_UTPL/src/models/innova-tic.dart';

class InnovaTicsDatabase extends DB<InnovaTic> {
  @override
  Stream<List<InnovaTic>> getStream({int limit = 4}) {
    return FirestoreStream<List<InnovaTic>>(
      parser: _InnovaTicsParser(),
      query: Firestore.instance
          .collection('formacion-docente/programa-formacion/tips')
          .orderBy('added', descending: true)
          .limit(limit),
    ).stream;
  }
}

class _InnovaTicsParser extends FirestoreNodeParser<List<InnovaTic>> {
  @override
  List<InnovaTic> parse(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((snapshot) => InnovaTic.fromJRON(
              id: snapshot.documentID,
              data: snapshot.data,
            ))
        .toList();
  }
}
