import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:Ascendere_UTPL/src/database/database.dart';
import 'package:Ascendere_UTPL/src/resources/routes.dart';
import 'package:Ascendere_UTPL/src/resources/theme.dart';

class InnovaciondocenteApp extends StatefulWidget {
  @override
  InnovaciondocenteAppState createState() {
    return new InnovaciondocenteAppState();
  }
}

class InnovaciondocenteAppState extends State<InnovaciondocenteApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    this._firebaseMessaging.getToken().then(print);
  }

  @override
  Widget build(BuildContext context) {
    return DBProvider(
      child: MaterialApp(
        title: 'Innovacion Docente',
        theme: IndevTheme.theme(),
        routes: Router.appRoutes(),
        onGenerateRoute: Router.onGenerateRoute,
        onUnknownRoute: Router.appOnUnknownRoute,
      ),
    );
  }
}
