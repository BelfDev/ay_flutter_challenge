import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// A customized [ListTile] that displays information about the challenge author (me).
class MyContactTile extends StatelessWidget {
  static const String _avatarImageSrc =
      'https://avatars0.githubusercontent.com/u/11461969?s=460&u=357b347fb6e91bac8eb9f1dbb24131434a163dc1&v=4';
  static const String _linkedInUrl =
      'https://www.linkedin.com/in/pedrobelfort/';

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
      dense: false,
      leading: CircleAvatar(
        radius: 32.0,
        backgroundImage: NetworkImage(_avatarImageSrc),
        backgroundColor: Colors.transparent,
      ),
      title: Text(
        'Pedro Belfort',
        style: styles.texts.myCardTitle,
      ),
      subtitle: Text(
        'Author',
        style: styles.texts.myCardSubtitle,
      ),
      onTap: () => _launchURL(),
    );
  }

  _launchURL() async {
    const url = _linkedInUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}