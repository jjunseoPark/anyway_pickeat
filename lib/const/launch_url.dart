import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url) async {

  Uri urlToUri = Uri.parse(url);

  if (await canLaunchUrl(urlToUri)) {
    await launchUrl(urlToUri);
  } else {
    throw 'Could not launch $url';
  }
}