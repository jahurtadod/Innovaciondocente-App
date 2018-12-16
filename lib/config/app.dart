import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/config/routes.dart';
import 'package:innovaciondocente_app/config/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
    return MaterialApp(
      // debug config
      debugShowCheckedModeBanner: false,

      title: 'Innovacion Docente',
      theme: Theme2(),
      // theme: ID_buildTheme(),
      routes: Router.appRoutes(),
      onGenerateRoute: Router.onGenerateRoute,
      onUnknownRoute: Router.appOnUnknownRoute,
    );
  }
}
