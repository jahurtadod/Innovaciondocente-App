import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class Filters {
  static String slice(
    int start,
    int end,
    String text, {
    String endString = '...',
  }) {
    if (end > text.length) return text;
    return text.substring(start, end) + endString;
  }

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
