import 'package:flutter/material.dart';
import 'package:Ascendere_UTPL/src/database/database.dart';
import 'package:Ascendere_UTPL/src/ui/pages/observatorio-edutendencias/tips-innovacion/home/tips-list.dart';
import 'package:Ascendere_UTPL/src/ui/widgets/indev-loader.dart';
import 'package:Ascendere_UTPL/src/ui/widgets/main-menu.dart';

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
                  ? IndevLoader()
                  : TipsList(
                      tips: snapshot.data,
                    ),
        ));
  }
}
