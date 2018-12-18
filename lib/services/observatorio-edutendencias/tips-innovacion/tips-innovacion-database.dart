import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovaciondocente_app/classes/tips-innovacion.dart';
import 'package:innovaciondocente_app/services/service.dart';

class TipsDatabase implements Database<TipInnovacion> {
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
    return querySnapshot.documents.map((documentSnapshot) {
      return TipInnovacion(
        id: documentSnapshot.documentID,
        name: documentSnapshot['name'],
        img: documentSnapshot['img'],
        created: documentSnapshot['created'],
        description: documentSnapshot['description'],
        creator: documentSnapshot['creator'],
        edited: documentSnapshot['edited'],
        editor: documentSnapshot['editor'],
        link: documentSnapshot['link'],
        tag: documentSnapshot['tag'],
      );
    }).toList();
  }
}
