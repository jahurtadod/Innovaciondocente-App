import 'package:flutter/material.dart';
import 'package:Ascendere_UTPL/src/models/curso.dart';
import 'package:Ascendere_UTPL/src/resources/colors.dart';
import 'package:Ascendere_UTPL/src/resources/courses-utils.dart';
import 'package:Ascendere_UTPL/src/resources/filters.dart';

class CursoDetailPage extends StatelessWidget {
  final Curso curso;

  const CursoDetailPage({
    Key key,
    this.curso,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Curso'),
            pinned: true,
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildHeader(context),
                _buildBody(context),
              ]),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          (this.isActive())
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: RaisedButton(
                    onPressed: () {
                      Filters.launchURL(curso.postulation.link);
                    },
                    child: Text(
                      'Postulaciones',
                      style: Theme.of(context).accentTextTheme.button,
                    ),
                    color: IndevColors.formacion,
                  ),
                )
              : Container(),
          BuildListTile(
            title: 'Descripción',
            content: curso.description,
          ),
          BuildListTile(
            title: 'Módulo',
            content: curso.module,
          ),
          BuildListTile(
            title: 'Fecha',
            content: Filters.date(curso.date),
          ),
          BuildListTile(
            title: 'Duración',
            content: _getDuration(),
          ),
          BuildListTile(
            title: 'Horario',
            content: curso.schedule,
          ),
          BuildListTile(
            title: 'Dirigido',
            content: curso.addressedTo,
          ),
          BuildInstructors(instructors: curso.instructors),
          BuildDownloadableContent(downloadableContent: curso.downloadableContent)
        ],
      ),
    );
  }

  String _getDuration() {
    String res = '';
    if (curso.duration.hours != null)
      res += '${res == '' ? '' : '\n'} - ${curso.duration.hours} Horas';
    if (curso.duration.days != null)
      res += '${res == '' ? '' : '\n'} - ${curso.duration.days} Días';
    if (curso.duration.weeks != null)
      res += '${res == '' ? '' : '\n'} - ${curso.duration.weeks} Semanas';
    return res;
  }

  Hero _buildHeader(BuildContext context) {
    return Hero(
      tag: curso.id,
      child: Container(
        padding: EdgeInsets.all(15),
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: CoursesUtils.getColors(curso.img),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              CoursesUtils.getNameType(curso.img),
              style: Theme.of(context).accentTextTheme.overline.copyWith(fontSize: 18),
            ),
            Expanded(child: Container()),
            Text(
              curso.name,
              style: Theme.of(context).accentTextTheme.title,
            ),
            SizedBox(height: 15),
            Text(
              Filters.date(curso.date),
              style: Theme.of(context).accentTextTheme.subtitle,
            ),
          ],
        ),
      ),
    );
  }

  bool isActive() {
    if (curso.postulation.date == null) return false;
    DateTime today = DateTime.now();
    print(curso.postulation.date);
    print(today);
    print(today.difference(curso.postulation.date).inDays);
    return today.difference(curso.postulation.date).inDays < 0;
  }
}

class BuildListTile extends StatelessWidget {
  const BuildListTile({
    Key key,
    this.title,
    this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: content == null
          ? Text(
              title,
              style: Theme.of(context).textTheme.title,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle,
                ),
                SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.only(left: 7.5),
                  child: Text(content),
                ),
              ],
            ),
    );
  }
}

class BuildInstructors extends StatelessWidget {
  const BuildInstructors({
    Key key,
    @required this.instructors,
  }) : super(key: key);

  final List<Instructor> instructors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BuildListTile(
          title: 'Instructores',
        )
      ]..addAll(
          instructors.map((instructor) => BuildListTile(
                title: instructor.name,
                content: instructor.about ?? 'Sin descripción',
              )),
        ),
    );
  }
}

class BuildDownloadableContent extends StatelessWidget {
  const BuildDownloadableContent({
    Key key,
    @required this.downloadableContent,
  }) : super(key: key);

  final List<DownloadableContent> downloadableContent;

  @override
  Widget build(BuildContext context) {
    return downloadableContent.length == 0
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BuildListTile(
                title: 'Contenido Descargable',
              )
            ]..addAll(downloadableContent.map(
                (data) => InkWell(
                      onTap: () {
                        Filters.launchURL(data.url);
                      },
                      child: BuildListTile(
                        title: 'Archivo',
                        content: 'Descargar',
                      ),
                    ),
              )),
          );
  }
}
