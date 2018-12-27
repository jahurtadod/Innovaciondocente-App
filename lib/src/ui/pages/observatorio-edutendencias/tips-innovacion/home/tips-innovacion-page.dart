import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/database/database.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/tips-innovacion/home/tips-list.dart';
import 'package:innovaciondocente_app/src/ui/widgets/loader.dart';
import 'package:innovaciondocente_app/src/ui/widgets/main-menu.dart';

class TipsInnovacionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainMenu(
          actualPath: '/observatorio-edutendencias/tips',
        ),
        body: StreamBuilder(
          stream: DBProvider.of(context).dbData.tipsStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) =>
              (snapshot == null || snapshot.data == null)
                  ? Loader()
                  : TipsList(
                      tips: snapshot.data,
                    ),
        ));
  }
}
