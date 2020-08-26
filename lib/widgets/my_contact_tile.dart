import 'package:ay_flutter_challenge/configs/app_localization.dart';
import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// A customized [ListTile] that displays information about the challenge author (me).
class MyContactTile extends StatefulWidget {
  static const String _avatarImageSrc =
      'https://avatars0.githubusercontent.com/u/11461969?s=460&u=357b347fb6e91bac8eb9f1dbb24131434a163dc1&v=4';
  static const String _linkedInUrl =
      'https://www.linkedin.com/in/pedrobelfort/';
  static const String _trackedGithubUrl = 'https://grabify.link/L9GDWZ';

  @override
  _MyContactTileState createState() => _MyContactTileState();
}

class _MyContactTileState extends State<MyContactTile> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
      dense: false,
      leading: ClipOval(
        child: FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          image: MyContactTile._avatarImageSrc,
          placeholder: 'assets/images/avatar_placeholder.png',
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: styles.placeholderIconColor,
          size: 32,
        ),
        onPressed: () {
          setState(() {
            isLiked = !isLiked;
            // I'll know you liked me!
            _launchURL(MyContactTile._trackedGithubUrl);
          });
        },
      ),
      title: Text(
        'Pedro Belfort',
        style: styles.texts.myCardTitle,
      ),
      subtitle: Text(
        AppLocalizations.of(context).contactRoute.author,
        style: styles.texts.myCardSubtitle,
      ),
      onTap: () => _launchURL(MyContactTile._linkedInUrl),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
