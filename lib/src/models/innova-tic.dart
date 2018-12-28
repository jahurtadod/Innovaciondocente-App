class InnovaTic {
  String id;
  String addBy;
  DateTime added;
  String description;
  String name;
  String publishedAt;

  InnovaTic.fromJRON({
    this.id,
    Map<String, dynamic> data,
  }) {
    this.addBy = data['addBy'];
    this.added = data['added'];
    this.description = data['description'];
    this.name = data['name'];
    this.publishedAt = data['publishedAt'];
  }

  DateTime get date => added;
}
