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

  Curso({
    this.addressedTo,
    this.created,
    this.creator,
    this.date,
    this.description,
    this.downloadableContent,
    this.duration,
    this.edited,
    this.img,
    this.instructors,
    this.module,
    this.name,
    this.place,
    this.postulation,
    this.schedule,
    this.id,
  });
}

class DownloadableContent {
  String url;
  DownloadableContent({
    this.url,
  });
}

class Duration {
  int days;
  int hours;
  int weeks;

  Duration({
    this.days,
    this.hours,
    this.weeks,
  });
}

class Instructor {
  String about;
  String name;

  Instructor({
    this.name,
    this.about,
  });
}

class Postulation {
  DateTime date;
  String link;
  String message;
  Postulation({
    this.date,
    this.link,
    this.message
  });
}
