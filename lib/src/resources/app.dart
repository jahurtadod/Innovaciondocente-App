import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:innovaciondocente_app/src/resources/routes.dart';
import 'package:innovaciondocente_app/src/resources/theme.dart';

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
    // TODO: create inherit widget to store data for all app
    return MaterialApp(
      title: 'Innovacion Docente',
      theme: IndevTheme.theme(),
      routes: Router.appRoutes(),
      onGenerateRoute: Router.onGenerateRoute,
      onUnknownRoute: Router.appOnUnknownRoute,
    );
  }
}
