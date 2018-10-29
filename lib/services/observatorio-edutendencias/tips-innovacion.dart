import 'package:cloud_firestore/cloud_firestore.dart';

class TipInnovacion {
  Timestamp created;
  String creator;
  String description;
  Timestamp edited;
  String editor;
  String img;
  String link;
  String name;
  String tag;
  String id;

  TipInnovacion({
    this.created,
    this.creator,
    this.description,
    this.edited,
    this.editor,
    this.img,
    this.link,
    this.name,
    this.tag,
    this.id,
  });
}
