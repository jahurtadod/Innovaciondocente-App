import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovaciondocente_app/services/formacion-docente/programa-formacion/curso.dart';
import 'package:innovaciondocente_app/services/service.dart';

class CursosProgramaFormacionDatabase extends Database<Curso> {
  @override
  Stream<List<Curso>> getStream({int limit = 20}) {
    return FirestoreStream<List<Curso>>(
      parser: _CursosParser(),
      query: Firestore.instance
          .collection('formacion-docente/programa-formacion/cursos')
          .orderBy('date', descending: true)
          .limit(limit),
    ).stream;
  }
}

class _CursosParser extends FirestoreNodeParser<List<Curso>> {
  @override
  List<Curso> parse(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((snapshot) => Curso.fromJSON(
              id: snapshot.documentID,
              data: snapshot.data,
            ))
        .toList();
  }
}
