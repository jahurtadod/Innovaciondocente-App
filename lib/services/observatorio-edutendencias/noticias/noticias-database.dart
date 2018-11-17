import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/noticias/noticia.dart';
import 'package:innovaciondocente_app/services/service.dart';

class NoticiasDatabase extends Database<Noticia> {
  @override
  Stream<List<Noticia>> getStream() {
    // create firebase stream and return stream
    return FirestoreStream<List<Noticia>>(
      parser: _NoticiasParser(),
      query: Firestore.instance
          .collection('observatorio/edutendencias/noticias')
          .orderBy('created', descending: true)
          .limit(20),
    ).stream;
  }
}

/// class to tranform db data into objects
class _NoticiasParser extends FirestoreNodeParser<List<Noticia>> {
  @override
  List<Noticia> parse(QuerySnapshot querySnapshot) {
    // build list of objs based on snapshots from firebase
    return querySnapshot.documents
        .map((snapshot) => Noticia(
              id: snapshot.documentID,
              name: snapshot['name'],
              img: snapshot['img'],
              created: snapshot['created'],
              description: snapshot['description'],
              creator: snapshot['creator'],
              edited: snapshot['edited'],
              editor: snapshot['editor'],
              html: snapshot['html'],
            ))
        .toList();
  }
}
