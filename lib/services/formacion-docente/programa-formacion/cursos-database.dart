import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovaciondocente_app/services/formacion-docente/programa-formacion/curso.dart';
import 'package:innovaciondocente_app/services/service.dart';

class CursoProgramaFormacionDatabase extends Database<Curso> {
  @override
  Stream<List<Curso>> getStream() {
    return FirestoreStream<List<Curso>>(
      parser: _CursosParser(),
      query: Firestore.instance
          .collection('formacion-docente/programa-formacion/cursos')
          .orderBy('date', descending: true)
          .limit(20),
    ).stream;
  }
}

class _CursosParser extends FirestoreNodeParser<List<Curso>> {
  @override
  List<Curso> parse(QuerySnapshot querySnapshot) {
    return querySnapshot.documents
        .map((snapshot) => Curso(
              id: snapshot.documentID,
              name: snapshot['name'],
              img: snapshot['img'],
              created: snapshot['created'],
              description: snapshot['description'],
              creator: snapshot['creator'],
              edited: snapshot['edited'],
              date: snapshot['date'],
              addressedTo: snapshot['addressedTo'],
              downloadableContent: snapshot['downloadableContent']
                  .map<DownloadableContent>((data) => DownloadableContent(
                        url: snapshot['url'],
                      ))
                  .toList(),
              duration: Duration(
                days: snapshot['duration']['days'],
                hours: snapshot['duration']['hours'],
                weeks: snapshot['duration']['weeks'],
              ),
              instructors: snapshot['instructors']
                  .map<Instructor>((data) => Instructor(
                        about: snapshot['about'],
                        name: snapshot['name'],
                      ))
                  .toList(),
              module: snapshot['module'],
              place: snapshot['place'],
              postulation: Postulation(
                date: snapshot['postulation']['date'],
                link: snapshot['postulation']['link'],
              ),
              schedule: snapshot['schedule'],
            ))
        .toList();
  }
}
