import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovaciondocente_app/services/formacion-docente/cafe-cientifico/encuentro.dart';
import 'package:innovaciondocente_app/services/service.dart';

class EncuentrosCafeCientificoDatabase extends Database<Encuentro> {
  @override
  Stream<List<Encuentro>> getStream() {
    return FirestoreStream<List<Encuentro>>(
      parser: _EncuentrosParser(),
      query: Firestore.instance
          .collection('formacion-docente/cafe-cientifico/encuentros')
          .orderBy('date', descending: true)
          .limit(20),
    ).stream;
  }
}

class _EncuentrosParser extends FirestoreNodeParser<List<Encuentro>> {
  @override
  List<Encuentro> parse(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((snapshot) => Encuentro(
              id: snapshot.documentID,
              name: snapshot['name'],
              img: snapshot['img'],
              created: snapshot['created'],
              description: snapshot['description'],
              creator: snapshot['creator'],
              edited: snapshot['edited'],
              date: snapshot['date'],
              editor: snapshot['editor'],
              guests: snapshot['guests']
                  .map<Guest>((data) => Guest(
                        name: snapshot['name'],
                        description: snapshot['description'],
                      ))
                  .toList(),
              postulations: snapshot['postulations'],
            ))
        .toList();
  }
}
