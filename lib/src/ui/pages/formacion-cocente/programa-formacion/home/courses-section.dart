import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/models/curso.dart';
import 'package:innovaciondocente_app/src/resources/courses-utils.dart';
import 'package:innovaciondocente_app/src/resources/filters.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/programa-formacion/_id/curso-detail-page.dart';

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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                "Últimos Cursos",
                style: Theme.of(context).textTheme.headline,
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Filters.launchURL(
                      'https://innovaciondocente-utpl.firebaseapp.com/formacion-docente/programa-formacion/cursos');
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      "Portafolio",
                      style: Theme.of(context).textTheme.overline,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 18,
                    )
                  ],
                ),
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
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return CursoDetailPage(
                      curso: curso,
                    );
                  }));
                },
                child: Hero(
                  tag: curso.id,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(),
                    child: _buildBody(context),
                  ),
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
          CoursesUtils.getNameType(curso.img),
          style: Theme.of(context).accentTextTheme.overline,
        ),
        Expanded(
          child: Container(),
        ),
        Text(
          curso.name,
          style: Theme.of(context).accentTextTheme.subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 7),
        Text(
          Filters.date(curso.date),
          style: Theme.of(context).accentTextTheme.body1,
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
          colors: CoursesUtils.getColors(curso.img),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
