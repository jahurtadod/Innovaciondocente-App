import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Ascendere_UTPL/src/database/database.dart';
import 'package:Ascendere_UTPL/src/models/encuentro.dart';

class EncuentrosDatabase extends DB<Encuentro> {
  @override
  Stream<List<Encuentro>> getStream({int limit = 20}) {
    return FirestoreStream<List<Encuentro>>(
      parser: _EncuentrosParser(),
      query: Firestore.instance
          .collection('formacion-docente/cafe-cientifico/encuentros')
          .orderBy('date', descending: true)
          .limit(limit),
    ).stream;
  }
}

class ProximoEncuentrosDatabase extends DB<Encuentro> {
  @override
  Stream<List<Encuentro>> getStream({int limit = 20}) {
    return FirestoreStream<List<Encuentro>>(
      parser: _EncuentrosParser(),
      query: Firestore.instance
          .collection('formacion-docente/cafe-cientifico/encuentros')
          .where('date', isGreaterThanOrEqualTo: DateTime.now())
          .orderBy('date', descending: true)
          .limit(limit),
    ).stream;
  }
}

class _EncuentrosParser extends FirestoreNodeParser<List<Encuentro>> {
  @override
  List<Encuentro> parse(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((snapshot) => Encuentro.fromJSON(
              id: snapshot.documentID,
              data: snapshot.data,
            ))
        .toList();
  }
}
