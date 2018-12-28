import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/database/cursos.database.dart';
import 'package:innovaciondocente_app/src/database/encuentros.database.dart';
import 'package:innovaciondocente_app/src/database/innova-tic.database.dart';
import 'package:innovaciondocente_app/src/database/noticias-database.dart';
import 'package:innovaciondocente_app/src/database/tips-innovacion-database.dart';
import 'package:innovaciondocente_app/src/models/curso.dart';
import 'package:innovaciondocente_app/src/models/encuentro.dart';
import 'package:innovaciondocente_app/src/models/innova-tic.dart';
import 'package:innovaciondocente_app/src/models/noticia.dart';
import 'package:innovaciondocente_app/src/models/tip-innovacion.dart';

/// abstract class to create instances of databases
abstract class DB<T> {
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

/// Class to keep track of all connections to firestore database
/// TODO: add bloc pattern if necesary
class DBData {
  final TipsInnovacionDatabase _tipsInnovacionDatabase = TipsInnovacionDatabase();
  Stream<List<TipInnovacion>> get tipsStream => this._tipsInnovacionDatabase.getStream();

  final NoticiasDatabase _noticiasDatabase = NoticiasDatabase();
  Stream<List<Noticia>> get noticiasStream => this._noticiasDatabase.getStream();
  final UltimasNoticiasDatabase _ultimasNoticiasDatabase = UltimasNoticiasDatabase();
  Stream<List<Noticia>> get ultimasNoticiasStream => this._ultimasNoticiasDatabase.getStream();

  final CursosDatabase _cursosDatabase = CursosDatabase();
  Stream<List<Curso>> get cursosStream => _cursosDatabase.getStream();

  final ProximosCursosDatabase _proximosCursosDatabase = ProximosCursosDatabase();
  Stream<List<Curso>> get proximosCursosStream => _proximosCursosDatabase.getStream();

  final InnovaTicsDatabase _innovaTicsDatabase = InnovaTicsDatabase();
  Stream<List<InnovaTic>> get innovaTicsStream => _innovaTicsDatabase.getStream();

  final EncuentrosDatabase _encuentrosDatabase = EncuentrosDatabase();
  Stream<List<Encuentro>> get encuentrosStream => _encuentrosDatabase.getStream();

  final ProximoEncuentrosDatabase _proximoEncuentrosDatabase = ProximoEncuentrosDatabase();
  Stream<List<Encuentro>> get proximosEncuentrosStream => _proximoEncuentrosDatabase.getStream();
}

class DBProvider extends InheritedWidget {
  DBProvider({
    Key key,
    Widget child,
  }) : super(
          child: child,
          key: key,
        );

  final DBData dbData = DBData();

  static DBProvider of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(DBProvider) as DBProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
