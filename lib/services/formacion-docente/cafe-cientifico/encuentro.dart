class Encuentro {
  DateTime created;
  String creator;
  DateTime edited;
  String editor;
  DateTime date;
  String description;
  List<Guest> guests;
  String img;
  String name;
  DateTime postulations;
  String id;

  Encuentro({
    this.created,
    this.creator,
    this.edited,
    this.editor,
    this.date,
    this.description,
    this.guests,
    this.img,
    this.name,
    this.postulations,
    this.id,
  });
}

class Guest {
  String description;
  String name;
  Guest({
    this.description,
    this.name,
  });
}
