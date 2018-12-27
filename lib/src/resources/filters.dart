import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class Filters {
  static String date(DateTime date) {
    return DateFormat.yMMMd("es-ES").format(date);
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
