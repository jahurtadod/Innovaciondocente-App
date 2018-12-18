class InnovaTip {
  String id;
  String addBy;
  DateTime added;
  String description;
  String name;
  String publishedAt;

  InnovaTip.fromJRON({
    String id,
    Map<String, dynamic> data,
  }) {
    this.id = id;
    this.addBy = data['addBy'];
    this.added = data['added'];
    this.description = data['description'];
    this.name = data['name'];
    this.publishedAt = data['publishedAt'];
  }
}
