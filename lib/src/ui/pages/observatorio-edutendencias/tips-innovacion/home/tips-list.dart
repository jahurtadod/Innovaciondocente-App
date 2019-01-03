import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/models/tip-innovacion.dart';
import 'package:innovaciondocente_app/src/resources/colors.dart';
import 'package:innovaciondocente_app/src/resources/filters.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/tips-innovacion/home/medium-card.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/tips-innovacion/home/small-card.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/tips-innovacion/tip-detail.dart';

class TipsList extends StatefulWidget {
  TipsList({
    
    Key key,
    this.tips,
  }) : super(key: key);

  final List<TipInnovacion> tips;

  @override
  _TipsListState createState() {
    return new _TipsListState();
  }
}

class _TipsListState extends State<TipsList> {
  String _tag = 'todos';

  @override
  Widget build(BuildContext context) {
    List<TipInnovacion> tips =
        this.widget.tips.where((tip) => tip.tag == _tag || _tag == 'todos').toList();
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('Tips Innovación'),
          pinned: true,
          actions: <Widget>[
            _buildOptions(context),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: IndevColors.observatorio),
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: (index % 4 == 0)
                            ? MediumCard(
                                tip: tips[index],
                              )
                            : SmallCard(
                                tip: tips[index],
                              ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) {
                            return TipDetail(
                              tip: tips[index],
                            );
                          }));
                        },
                      ),
                    ),
                  ),
              childCount: tips.length,
            ),
          ),
        )
      ],
    );
  }

  IconButton _buildOptions(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildOptionsTitle(context),
                _listTile(
                  context: context,
                  text: 'Todos',
                  tag: 'todos',
                ),
                _listTile(
                  context: context,
                  text: 'Aula Divertida',
                  tag: 'aula-divertida',
                ),
                _listTile(
                  context: context,
                  text: 'Docentes del Futuro',
                  tag: 'docentes-futuro',
                ),
                _listTile(
                  context: context,
                  text: 'Videos',
                  tag: 'videos',
                ),
                // other options
                ListTile(
                  trailing: Icon(Icons.open_in_browser),
                  title: Text("Ver todos los Tips"),
                  onTap: () {
                    Filters.launchURL(
                        'https://innovaciondocente-utpl.firebaseapp.com/observatorio-edutendencias/tips-innovacion');
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Container _buildOptionsTitle(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
        "Categorias",
        style: Theme.of(context).textTheme.overline.copyWith(
              color: IndevColors.observatorio,
              fontSize: 15.0,
            ),
      ),
    );
  }

  Widget _listTile({
    @required BuildContext context,
    @required String text,
    @required String tag,
  }) {
    return this._tag.contains(tag)
        // this is selected tile
        ? _ListTile(
            text,
            active: true,
          )
        // normal tile
        : Material(
            child: InkWell(
              onTap: () {
                setState(() {
                  this._tag = tag;
                });
                Navigator.pop(context);
              },
              child: _ListTile(text),
            ),
          );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile(
    this.text, {
    Key key,
    this.active: false,
  }) : super(key: key);

  final bool active;
  final String text;

  @override
  Widget build(BuildContext context) {
    // filled tile
    if (active)
      return Container(
        decoration: BoxDecoration(
          color: IndevColors.observatorio,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(3.0),
            bottomRight: Radius.circular(3.0),
          ),
        ),
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        padding: EdgeInsets.all(10.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.overline.copyWith(
                color: Colors.white,
                fontSize: 15.0,
              ),
        ),
      );

    // build outline tile
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: IndevColors.observatorio,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
      ),
      width: double.infinity,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.overline.copyWith(
              fontSize: 15.0,
            ),
      ),
    );
  }
}
