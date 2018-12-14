import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/cafe-cientifico/description.dart';
import 'package:innovaciondocente_app/services/formacion-docente/cafe-cientifico/encuentro.dart';

class EncuentroDetailPage extends StatelessWidget {
  final Encuentro encuentro;
  EncuentroDetailPage({
    Key key,
    this.encuentro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.access_alarm),
        label: Text('Inscribete'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildBody(context),
        ],
      ),
    );
  }

  SliverList _buildBody(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
          child: Text(
            encuentro.name,
            style: Theme.of(context).primaryTextTheme.title,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            Filters.date(encuentro.date),
            style: Theme.of(context).textTheme.overline,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: EncuentroDescription(
            description: encuentro.description,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
          child: Row(
            children: <Widget>[
              Icon(Icons.people),
              SizedBox(width: 15),
              Text(
                'Invitados',
                style: Theme.of(context).primaryTextTheme.subtitle,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: encuentro.guests
              .map((guest) => ExpansionTile(
                    title: Text(guest.name),
                    leading: Icon(Icons.person),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                        child: Text(guest.description),
                      ),
                    ],
                  ))
              .toList(),
        ),
        SizedBox(height: 65),
      ]),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      expandedHeight: 280,
      actions: <Widget>[
        CloseButton(),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: FadeInImage(
          image: NetworkImage(
            encuentro.img,
          ),
          placeholder: AssetImage('assets/images/default.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
