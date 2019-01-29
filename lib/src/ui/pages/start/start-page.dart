import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/database/database.dart';
import 'package:innovaciondocente_app/src/models/curso.dart';
import 'package:innovaciondocente_app/src/models/encuentro.dart';
import 'package:innovaciondocente_app/src/models/innova-tic.dart';
import 'package:innovaciondocente_app/src/models/noticia.dart';
import 'package:innovaciondocente_app/src/resources/colors.dart';
import 'package:innovaciondocente_app/src/resources/filters.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/cafe-cientifico/_id/encuentro-detail-page.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/programa-formacion/_id/curso-detail-page.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/noticias/_id/noticia-detail-page.dart';
import 'package:innovaciondocente_app/src/ui/widgets/loader.dart';
import 'package:innovaciondocente_app/src/ui/widgets/main-menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage extends StatefulWidget {
  @override
  StartPageState createState() {
    return new StartPageState();
  }
}

class StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getBool('wellcome') == null || !prefs.getBool('wellcome')) {
        Navigator.pushNamed(context, '/presentation');
        prefs.setBool('wellcome', false);
      }
    }).catchError((e) {
      Navigator.pushNamed(context, '/presentation');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainMenu(
        actualPath: '/',
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            titleSpacing: 15,
            title: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Image.asset(
                    'assets/icon2.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(width: 15),
                Text('Ascendere'),
              ],
            ),
            pinned: true,
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _Section(
                  label: "Próximos Cursos",
                  stream: DBProvider.of(context).dbData.proximosCursosStream,
                  errorMessage: 'No se encontraron próximos cursos.',
                  color: IndevColors.formacion,
                ),
                _Section(
                  label: "Próximos Encuentros",
                  stream:
                      DBProvider.of(context).dbData.proximosEncuentrosStream,
                  errorMessage: "No hay encuentros próximos",
                  color: IndevColors.formacion,
                ),
                _Section(
                  label: "Noticias del Mes",
                  stream: DBProvider.of(context).dbData.ultimasNoticiasStream,
                  errorMessage: "No se encontraron noticas",
                  color: IndevColors.observatorio,
                ),
                _Section(
                  label: "Ultimos InnovaTip's",
                  stream: DBProvider.of(context).dbData.innovaTicsStream,
                  errorMessage: "No se encontraron InnovaTic's",
                  color: IndevColors.formacion,
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String label;
  final String errorMessage;
  final Stream stream;
  final Color color;

  const _Section({
    Key key,
    this.label,
    this.stream,
    this.errorMessage,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// section header
        Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 7.5),
          child: Text(
            label,
            style: Theme.of(context).textTheme.overline.copyWith(color: color),
          ),
        ),

        /// section list
        StreamBuilder(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot == null || snapshot.data == null) return Loader();
              List data = snapshot.data as List;
              if (data.length == 0) return Center(child: Text(errorMessage));
              return Column(
                children: (snapshot.data as List).map((d) {
                  Function onTap;
                  if (d.runtimeType == InnovaTic) {
                    onTap = () {
                      Filters.launchURL('https://youtu.be/${d.id}');
                    };
                  } else if (d.runtimeType == Curso) {
                    onTap = () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return CursoDetailPage(
                          curso: d,
                        );
                      }));
                    };
                  } else if (d.runtimeType == Encuentro) {
                    onTap = () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return EncuentroDetailPage(
                          encuentro: d,
                        );
                      }));
                    };
                  } else if (d.runtimeType == Noticia) {
                    onTap = () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return NoticiaDetailPage(
                          noticia: d,
                        );
                      }));
                    };
                  }
                  return _NotificationTile(
                    data: d,
                    color: color,
                    onTap: onTap,
                  );
                }).toList(),
              );
            }),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final dynamic data;
  final Color color;
  final Function onTap;

  const _NotificationTile({
    Key key,
    this.data,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: this.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.radio_button_checked,
                size: 15,
                color: color,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.name,
                      style: Theme.of(context).textTheme.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      Filters.date(data.date),
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
