import 'package:cloud_firestore/cloud_firestore.dart';

/// abstract class to create instances of databases
abstract class Database<T> {
  Stream<List<T>> getStream();
}

/// abstract class to provide parse types for objects from snapshots
abstract class FirestoreNodeParser<T> {
  T parse(QuerySnapshot querySnapshot);
}

/// Class to return data from firebase streams,
/// by providing queries, and parser for objects on contructor.
/// stream available before initialized
class FirestoreStream<T> {
  FirestoreStream({Query query, FirestoreNodeParser<T> parser}) {
    stream = query.snapshots().map((snapshot) => parser.parse(snapshot));
  }

  Stream<T> stream;
}
