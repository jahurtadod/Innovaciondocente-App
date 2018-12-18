import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/services/formacion-docente/programa-formacion/curso.dart';

class CourseSection extends StatelessWidget {
  const CourseSection({
    Key key,
    @required List<Curso> cursos,
  })  : _cursos = cursos,
        super(key: key);

  final List<Curso> _cursos;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Últimos Cursos",
                style: Theme.of(context).textTheme.headline,
              ),
              // TODO: change color
              Text(
                "Ver Todos",
                style: Theme.of(context).textTheme.body1,
              ),
            ],
          ),
        ),
        Container(
          height: 150,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 7.5),
            itemCount: _cursos.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => CourseCard(curso: _cursos[index]),
          ),
        )
      ],
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key key,
    @required this.curso,
  }) : super(key: key);

  final Curso curso;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .6,
      height: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 7.5),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        child: Stack(
          children: <Widget>[
            _buildGradient(),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(),
                  child: _buildBody(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          getNameType(curso.img),
          style: Theme.of(context).textTheme.overline.copyWith(color: Colors.white),
        ),
        Expanded(
          child: Container(),
        ),
        Text(
          curso.name,
          style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 7),
        Text(
          Filters.date(curso.date),
          style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
        )
      ],
    );
  }

  Container _buildGradient() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: getColors(curso.img),
          // stops: [],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  List<Color> getColors(String txt) {
    if (txt.contains('gestion'))
      return <Color>[
        Color(0xff364d9d),
        Color(0xff1ea3de),
      ];
    if (txt.contains('gestion-proyectos'))
      return <Color>[
        Color(0xff2aa9dc),
        Color(0xff2bb4e2),
      ];
    if (txt.contains('identidad'))
      return <Color>[
        Color(0xffd6332e),
        Color(0xfff0706f),
      ];
    if (txt.contains('pedagogia'))
      return <Color>[
        Color(0xff1d9e97),
        Color(0xff41b8c0),
      ];
    if (txt.contains('investigacion'))
      return <Color>[
        Color(0xfff36a22),
        Color(0xfff89a1c),
      ];
    if (txt.contains('tic'))
      return <Color>[
        Color(0xff1291c6),
        Color(0xff44b0de),
      ];
    return <Color>[
      Colors.purple,
      Colors.purpleAccent,
    ];
  }

  String getNameType(String txt) {
    if (txt.contains('gestion')) return "Gestión académica";
    if (txt.contains('gestion-proyectos')) return "Gestión de proyectos";
    if (txt.contains('identidad')) return "Identidad UTPL";
    if (txt.contains('pedagogia')) return "Pedagogía";
    if (txt.contains('investigacion')) return "Investigación";
    if (txt.contains('tic')) return "Tic's";
  }
}
