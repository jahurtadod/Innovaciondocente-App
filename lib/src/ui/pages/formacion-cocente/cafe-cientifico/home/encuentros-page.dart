import 'package:flutter/material.dart';
import 'package:Ascendere_UTPL/src/database/database.dart';
import 'package:Ascendere_UTPL/src/ui/pages/formacion-cocente/cafe-cientifico/home/encuentros-view.dart';
import 'package:Ascendere_UTPL/src/ui/widgets/indev-loader.dart';
import 'package:Ascendere_UTPL/src/ui/widgets/main-menu.dart';

class EncuentrosPage extends StatelessWidget {
  const EncuentrosPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainMenu(
          actualPath: '/formacion-docente/cafe-cientifico/encuentros',
        ),
        appBar: AppBar(
          title: Text('Café Científico'),
        ),
        body: StreamBuilder(
          stream: DBProvider.of(context).dbData.encuentrosStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) =>
              snapshot == null || snapshot.data == null
                  ? IndevLoader()
                  : EncuentrosView(encuentros: snapshot.data),
        ));
  }
}
