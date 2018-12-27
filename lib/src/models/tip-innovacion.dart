class TipInnovacion {
  DateTime created;
  String creator;
  String description;
  String id;
  DateTime edited;
  String editor;
  String img;
  String link;
  String name;
  String tag;

  TipInnovacion.fromJSON({
    String id,
    Map<String, dynamic> data,
  })  : this.id = id,
        this.created = data['created'],
        this.creator = data['creator'],
        this.description = data['description'],
        this.edited = data['edited'],
        this.editor = data['editor'],
        this.img = data['img'],
        this.link = data['link'],
        this.name = data['name'],
        this.tag = data['tag'];
}
