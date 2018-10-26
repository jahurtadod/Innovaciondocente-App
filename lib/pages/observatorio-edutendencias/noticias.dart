import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:innovaciondocente_app/layouts/default.dart';

class Noticias extends StatefulWidget {
  @override
  _NoticiasState createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: SafeArea(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('observatorio')
              .document('edutendencias')
              .collection('tips')
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("Loading...");
            }
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data.documents[index]['name']),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
