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

  Encuentro.fromJSON({
    String id,
    Map<String, dynamic> data,
  }) {
    this.id = id;
    this.name = data['name'];
    this.img = data['img'];
    this.created = data['created'];
    this.description = data['description'];
    this.creator = data['creator'];
    this.edited = data['edited'];
    this.date = data['date'];
    this.editor = data['editor'];
    this.postulations = data['postulations'];
    this.guests = (data['guests'] as List<dynamic>)
        .map<Guest>((guest) => Guest.fromJSON(data: guest))
        .toList();
  }
}

class Guest {
  String description;
  String name;
  Guest({
    this.description,
    this.name,
  });

  Guest.fromJSON({Map<dynamic, dynamic> data}) {
    this.name = data['name'];
    this.description = data['description'];
  }
}
