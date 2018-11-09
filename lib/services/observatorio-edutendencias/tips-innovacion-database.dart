import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion.dart';

/// basic database functions
abstract class Database {
  Stream<List<TipInnovacion>> tipsStream();
}

/// Cloud Firestore
class AppFirestore implements Database {
  /// Tips stream
  Stream<List<TipInnovacion>> tipsStream() {
    return _FirestoreStream<List<TipInnovacion>>(
      apiPath: rootPath,
      parser: FirestoreTipsParser(),
    ).stream;
  }

  /// Tip document
  DocumentReference _documentReference(TipInnovacion tip) {
    return Firestore.instance.collection(rootPath).document(tip.id);
  }

  static final String rootPath = '/observatorio/edutendencias/tips';
}

// abstract class for parsing docs
abstract class FirestoreNodeParser<T> {
  T parse(QuerySnapshot querySnapshot);
}

class FirestoreTipsParser extends FirestoreNodeParser<List<TipInnovacion>> {
  List<TipInnovacion> parse(QuerySnapshot querySnapshot) {
    List<TipInnovacion> tips = querySnapshot.documents.map((documentSnapshot) {
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
    tips.sort((a, b) => b.id.compareTo(a.id));
    return tips;
  }
}

/// stream from firestore
class _FirestoreStream<T> {
  _FirestoreStream({String apiPath, FirestoreNodeParser<T> parser}) {
    Stream<QuerySnapshot> snapshots =   Firestore.instance.collection(apiPath)
        .orderBy('created', descending: true)
        .limit(20)
        .snapshots();
    stream = snapshots.map((snapshot) => parser.parse(snapshot));
  }

  Stream<T> stream;
}
