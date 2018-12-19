import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/noticia.dart';
import 'package:innovaciondocente_app/classes/tips-innovacion.dart';
import 'package:innovaciondocente_app/config/colors.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/cafe-cientifico/encuentro-detail/encuentro-detail-page.dart';
import 'package:innovaciondocente_app/pages/share/loader.dart';
import 'package:innovaciondocente_app/services/formacion-docente/cafe-cientifico/encuentro.dart';
import 'package:innovaciondocente_app/services/formacion-docente/programa-formacion/curso.dart';

class StartPage extends StatefulWidget {
  final List<Stream<List>> stream;

  StartPage({this.stream});

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<StartPage> {
  List<TipInnovacion> _tips;
  List<Noticia> _noticias;
  Encuentro _encuentros;
  List<Curso> _cursos;
  StreamSubscription<List<TipInnovacion>> _subsT;
  StreamSubscription<List<Noticia>> _subsN;
  StreamSubscription<List<Encuentro>> _subsE;
  StreamSubscription<List<Curso>> _subsC;

  @override
  void initState() {
    super.initState();

    this._subsT = widget.stream[0].listen((tips) {
      setState(() {
        this._tips = tips;
      });
    });
    this._subsN = widget.stream[1].listen((noticias) {
      setState(() {
        this._noticias = noticias;
      });
    });
    this._subsE = widget.stream[2].listen((encuentros) {
      setState(() {
        this._encuentros = encuentros[0];
      });
    });
    this._subsC = widget.stream[3].listen((cursos) {
      setState(() {
        this._cursos = cursos;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    this._subsT.cancel();
    this._subsN.cancel();
    this._subsE.cancel();
    this._subsC.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          children: <Widget>[
            Text(
              'Ascendere',
              style: TextStyle(fontSize: 20.0, color: Colors.grey.shade500),
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Image.asset('assets/icon.png'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.grey.shade500,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.grey.shade500,
            onPressed: () {},
          ),
        ],
      ),
      body: (this._tips == null ||
              this._cursos == null ||
              this._encuentros == null ||
              this._noticias == null)
          ? Loader()
          : ListView(
              children: <Widget>[
                _subMenu(),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'ASCENDERE IN',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                fontFamily: 'Montserrat'),
                          ),
                          Text(
                            'Conoce nuestras novedades',
                            style: TextStyle(
                                color: Colors.grey, fontSize: 15.0, fontFamily: 'Montserrat'),
                          ),
                        ],
                      ),
                      Text(
                        'Todos',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            fontFamily: 'Montserrat'),
                      )
                    ],
                  ),
                ),
                _cardCafe(_encuentros),
                _cardNoticia(_noticias),
                _cardCurso(_cursos),
                _cardTip(_tips),
              ],
            ),
    );
  }

  Widget _subMenu() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _iconMenu('assets/formacion.png', '/formacion-docente', IndevColors.formacion),
          _iconMenu('assets/inovacion.png', '/', IndevColors.innovacion),
          _iconMenu(
              'assets/observatorio.png', '/observatorio-edutendencias', IndevColors.observatorio),
        ],
      ),
    );
  }

  Widget _iconMenu(String imagen, String route, Color color) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      height: 80.0,
      width: 80.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: color),
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5.0),
                child: Image(
                  image: AssetImage(imagen),
                  colorBlendMode: BlendMode.srcIn,
                  color: Colors.grey.shade200,
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, route);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardCafe(Encuentro encuentro) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 12.0),
        height: 220.0,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(encuentro.img),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        encuentro.name.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey.shade200,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                _buildSplash(context),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'CAFE CIENTIFICO',
                          style: TextStyle(
                              color: Colors.grey.shade200,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        _iconMenu('assets/encuentro.png', '/cafe-cientifico/encuentros',
                            const Color(0xFFDA8D5E)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Material _buildSplash(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return EncuentroDetailPage(
              encuentro: _encuentros,
            );
          }));
        },
      ),
    );
  }

  Widget _cardNoticia(List<Noticia> noticia) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 5.0),
      child: Row(children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                ),
                image: DecorationImage(image: NetworkImage(noticia[0].img), fit: BoxFit.cover)),
            height: 150.0,
          ),
        ),
        Container(
          height: 150.0,
          width: 5.0,
          color: Color(0xffff0266),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 15.0, 3.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
              ),
            ),
            height: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  noticia[0].name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Expanded(
                  child: Text(
                    noticia[0].description,
                    style: TextStyle(fontSize: 12.0),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Chip(
                  label: Text('Noticias'),
                  labelStyle: TextStyle(
                    color: Color(0xffff0266),
                    fontSize: 12.0,
                  ),
                  backgroundColor: Colors.grey.shade200,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _cardCurso(List<Curso> curso) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 5.0),
      child: Row(children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                ),
                image: DecorationImage(image: NetworkImage(curso[0].img), fit: BoxFit.cover)),
            height: 150.0,
          ),
        ),
        Container(
          height: 150.0,
          width: 5.0,
          color: Color(0xFF1A2377),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 15.0, 3.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
              ),
            ),
            height: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  curso[0].name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Expanded(
                  child: Text(
                    curso[0].description,
                    style: TextStyle(fontSize: 12.0),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Chip(
                  label: Text('Cursos'),
                  labelStyle: TextStyle(
                    color: Color(0xFF1A2377),
                    fontSize: 12.0,
                  ),
                  backgroundColor: Colors.grey.shade200,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _cardTip(List<TipInnovacion> tip) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 5.0),
      child: Row(children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                ),
                image: DecorationImage(image: NetworkImage(tip[0].img), fit: BoxFit.cover)),
            height: 150.0,
          ),
        ),
        Container(
          height: 150.0,
          width: 5.0,
          color: Color(0xffff0266),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 15.0, 3.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
              ),
            ),
            height: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tip[0].name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Expanded(
                  child: Text(
                    tip[0].description,
                    style: TextStyle(fontSize: 12.0),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Chip(
                  label: Text('Tips'),
                  labelStyle: TextStyle(
                    color: Color(0xffff0266),
                    fontSize: 12.0,
                  ),
                  backgroundColor: Colors.grey.shade200,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
