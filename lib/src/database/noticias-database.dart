import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovaciondocente_app/src/database/database.dart';
import 'package:innovaciondocente_app/src/models/noticia.dart';

class NoticiasDatabase extends DB<Noticia> {
  @override
  Stream<List<Noticia>> getStream({int limit = 20}) {
    // create firebase stream and return stream
    return FirestoreStream<List<Noticia>>(
      parser: _NoticiasParser(),
      query: Firestore.instance
          .collection('observatorio/edutendencias/noticias')
          .orderBy('created', descending: true)
          .limit(limit),
    ).stream;
  }
}

/// class to tranform db data into objects
class _NoticiasParser extends FirestoreNodeParser<List<Noticia>> {
  @override
  List<Noticia> parse(QuerySnapshot querySnapshot) {
    // build list of objs based on snapshots from firebase
    return querySnapshot.documents
        .map((snapshot) => Noticia.fromJSON(
              id: snapshot.documentID,
              data: snapshot.data,
            ))
        .toList();
  }
}
