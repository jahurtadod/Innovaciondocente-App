import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/models/encuentro.dart';
import 'package:innovaciondocente_app/src/resources/filters.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/cafe-cientifico/_id/encuentro-detail-page.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/cafe-cientifico/home/encuentro-card.dart';

class EncuentrosView extends StatelessWidget {
  const EncuentrosView({
    Key key,
    @required List<Encuentro> encuentros,
  })  : encuentros = encuentros,
        super(key: key);

  final List<Encuentro> encuentros;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        /// background
        _buildBackground(),
        _buildGradiente(),

        /// body
        Column(
          children: <Widget>[
            _lastEncuentroBody(context),
            _buildEncuentrosList(),
          ],
        ),
      ],
    );
  }

  Widget _buildEncuentrosList() {
    return Flexible(
      flex: 3,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 7.5),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              EncuentroCard(encuentro: encuentros[index + 1]),
          itemCount: encuentros.length - 1,
        ),
      ),
    );
  }

  Widget _lastEncuentroBody(BuildContext context) {
    Encuentro encuentro = getLastEncuentro();
    return Flexible(
      flex: 6,
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 15),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  encuentro.name,
                  style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: Filters.date(encuentro.date),
                      ),
                      TextSpan(
                        text: ' - ',
                      ),
                      TextSpan(
                        text: '${encuentro.guests.length} Invitados',
                      ),
                    ],
                    style: Theme.of(context).textTheme.overline.copyWith(color: Colors.white),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  encuentro.description,
                  style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                SizedBox(height: 3),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                      return EncuentroDetailPage(
                        encuentro: encuentro,
                      );
                    }));
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Ver más',
                        style: Theme.of(context).textTheme.overline.copyWith(color: Colors.white),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Hero(
        tag: getLastEncuentro().id,
        child: FadeInImage(
          image: NetworkImage(getLastEncuentro().img),
          placeholder: AssetImage('assets/images/default.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Container _buildGradiente() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.clamp,
          stops: [0, 0.3, 0.8],
          colors: <Color>[
            Colors.transparent,
            Colors.transparent,
            Colors.black,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Encuentro getLastEncuentro() {
    if (encuentros.length <= 0) return null;
    return encuentros[0];
  }
}
