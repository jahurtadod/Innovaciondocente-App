import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/models/encuentro.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/cafe-cientifico/home/encuentro-card.dart';

class EncuentrosList extends StatefulWidget {
  final List<Encuentro> encuentros;

  const EncuentrosList({
    Key key,
    @required this.encuentros,
  }) : super(key: key);

  @override
  _EncuentrosListState createState() => _EncuentrosListState();
}

class _EncuentrosListState extends State<EncuentrosList> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: (expanded)
          ? MediaQuery.of(context).size.height * .3
          : MediaQuery.of(context).size.height * .1,
      width: double.infinity,
      child: PageView(
        onPageChanged: (int n) {
          setState(() {
            expanded = n != 0;
          });
        },
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.keyboard_arrow_up,
                color: Theme.of(context).accentIconTheme.color,
              ),
              Text(
                'Portafolio de Encuentros',
                style: Theme.of(context).accentTextTheme.subtitle,
              ),
            ],
          ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 7.5),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) =>
                EncuentroCard(encuentro: widget.encuentros[index]),
            itemCount: widget.encuentros.length,
          ),
        ],
      ),
    );
  }
}
