class Noticia {
  String name;
  String img;
  String html;
  DateTime created;
  String creator;
  String description;
  String id;
  DateTime edited;
  String editor;

  Noticia.fromJSON({
    String id,
    Map<String, dynamic> data,
  })  : this.id = id,
        this.name = data['name'],
        this.img = data['img'],
        this.html = data['html'],
        this.created = data['created'],
        this.creator = data['creator'],
        this.description = data['description'],
        this.edited = data['edited'],
        this.editor = data['editor'];
}
