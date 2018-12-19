class Curso {
  String addressedTo;
  DateTime created;
  String creator;
  DateTime date;
  String description;
  List<DownloadableContent> downloadableContent;
  Duration duration;
  DateTime edited;
  String img;
  List<Instructor> instructors;
  String module;
  String name;
  String place;
  Postulation postulation;
  String schedule;
  String id;

  Curso.fromJSON({Map<String, dynamic> data, String id}) {
    this.id = id;
    this.addressedTo = data['addressedTo'];
    this.created = data['created'];
    this.creator = data['creator'];
    this.date = data['date'];
    this.description = data['description'];
    this.edited = data['edited'];
    this.img = data['img'];
    this.module = data['module'];
    this.name = data['name'];
    this.place = data['place'];
    this.schedule = data['schedule'];
    this.duration = Duration.fromJSON(data: data['duration']);
    this.downloadableContent = (data['downloadableContent'] as List<dynamic>)
        .map((item) => DownloadableContent.fromJSON(data: item))
        .toList();
    this.instructors = (data['instructors'] as List<dynamic>)
        .map((item) => Instructor.fromJSON(data: item))
        .toList();
    this.postulation = Postulation.fromJSON(data: data['postulation']);
  }
}

class DownloadableContent {
  String url;
  DownloadableContent.fromJSON({
    Map<dynamic, dynamic> data,
  }) {
    this.url = data['url'];
  }
}

class Duration {
  int days;
  int hours;
  int weeks;

  Duration.fromJSON({
    Map<dynamic, dynamic> data,
  }) {
    this.days = data['days'];
    this.hours = data['hours'];
    this.weeks = data['weeks'];
  }
}

class Instructor {
  String about;
  String name;

  Instructor.fromJSON({
    Map<dynamic, dynamic> data,
  }) {
    this.about = data['about'];
    this.name = data['name'];
  }
}

class Postulation {
  DateTime date;
  String link;
  String message;
  Postulation.fromJSON({
    Map<dynamic, dynamic> data,
  }) {
    this.date = data['date'];
    this.link = data['link'];
    this.message = data['message'];
  }
}
