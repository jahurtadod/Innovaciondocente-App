import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovaciondocente_app/classes/noticia.dart';
import 'package:innovaciondocente_app/services/service.dart';

class NoticiasDatabase extends Database<Noticia> {
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
