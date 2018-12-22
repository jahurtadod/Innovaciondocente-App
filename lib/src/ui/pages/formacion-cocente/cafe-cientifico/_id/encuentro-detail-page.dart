import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/services/formacion-docente/cafe-cientifico/encuentro.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/cafe-cientifico/_id/description.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/cafe-cientifico/_id/guests-detail.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/cafe-cientifico/_id/title-encuentro-detail.dart';

class EncuentroDetailPage extends StatelessWidget {
  final Encuentro encuentro;
  EncuentroDetailPage({
    Key key,
    this.encuentro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildInscriptionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildBody(context),
        ],
      ),
    );
  }

  FloatingActionButton _buildInscriptionButton() {
    return (isActive())
        ? FloatingActionButton.extended(
            icon: Icon(Icons.event_note),
            label: Text('Inscribete'),
            onPressed: () {
              Filters.launchURL(
                  'https://innovaciondocente-utpl.firebaseapp.com/formacion-docente/cafe-cientifico/inscripcion?id=${encuentro.id}');
            },
          )
        : null;
  }

  SliverList _buildBody(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        TitleEncuentroDetail(name: encuentro.name),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            Filters.date(encuentro.date),
            style: Theme.of(context).textTheme.overline,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          // TODO: MAKE this description global
          child: EncuentroDescription(
            description: encuentro.description,
          ),
        ),
        GuestsDetails(guests: encuentro.guests),
        isActive() ? SizedBox(height: 65) : Container(),
      ]),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      expandedHeight: 280,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Hero(
          tag: encuentro.id,
          child: FadeInImage(
            image: NetworkImage(
              encuentro.img,
            ),
            placeholder: AssetImage('assets/images/default.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  bool isActive() {
    if (encuentro.postulations == null) return false;
    DateTime today = DateTime.now();
    return today.difference(encuentro.postulations).inDays <= 0;
  }
}
