import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/cafe-cientifico/encuentro-detail/encuentro-detail-page.dart';
import 'package:innovaciondocente_app/services/formacion-docente/cafe-cientifico/encuentro.dart';

class EncuentroCard extends StatelessWidget {
  const EncuentroCard({
    Key key,
    @required this.encuentro,
  }) : super(key: key);

  final Encuentro encuentro;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 20),
      height: double.infinity,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Stack(
            children: <Widget>[
              _buildImage(),
              _buildGradient(),
              _buildSplash(context),
              _buildText(context),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _buildText(BuildContext context) {
    return Positioned(
      bottom: 15,
      left: 15,
      right: 15,
      child: Text(
        encuentro.name,
        style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
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
              encuentro: encuentro,
            );
          }));
        },
      ),
    );
  }

  Container _buildGradient() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.clamp,
          stops: [0, 0.4, 1],
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

  Widget _buildImage() {
    return Hero(
      tag: encuentro.id,
      child: FadeInImage(
        width: double.infinity,
        height: double.infinity,
        image: NetworkImage(encuentro.img),
        placeholder: AssetImage('assets/images/default.png'),
        fit: BoxFit.cover,
      ),
    );
  }
}
