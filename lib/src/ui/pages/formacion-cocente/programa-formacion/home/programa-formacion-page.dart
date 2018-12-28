import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/database/database.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/programa-formacion/home/courses-section.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/programa-formacion/home/header-section.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/programa-formacion/home/tips-section.dart';
import 'package:innovaciondocente_app/src/ui/widgets/main-menu.dart';

class ProgramaFormacionPage extends StatelessWidget {
  const ProgramaFormacionPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainMenu(
        actualPath: '/formacion-docente/programa-formacion',
      ),

      /// TODO: add loading screen
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: Text("Formación Docente"),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              HeaderSection(),
              StreamBuilder(
                stream: DBProvider.of(context).dbData.cursosStream,
                initialData: null,
                builder: (BuildContext context, AsyncSnapshot snapshot) =>
                    (snapshot == null || snapshot.data == null)
                        ? Center(child: CircularProgressIndicator())
                        : CourseSection(cursos: snapshot.data),
              ),
              StreamBuilder(
                stream: DBProvider.of(context).dbData.innovaTicsStream,
                initialData: null,
                builder: (BuildContext context, AsyncSnapshot snapshot) =>
                    (snapshot == null || snapshot.data == null)
                        ? Center(child: CircularProgressIndicator())
                        : TipsSection(innovaTips: snapshot.data),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
