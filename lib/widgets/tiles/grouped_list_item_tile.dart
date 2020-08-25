import 'package:ay_flutter_challenge/utils/extensions/string_operations_extension.dart';
import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:flutter/material.dart';

/// A single fixed-height row that displays a title as [RichText].
/// If [emphasis] is false, then the [title] text is displayed as [Text].
class GroupedListItemTile extends StatelessWidget {
  const GroupedListItemTile(
      {Key key, @required this.title, this.onTap, this.emphasis = true})
      : assert(title != null),
        super(key: key);

  final String title;
  final bool emphasis;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);
    return SafeArea(
        top: false,
        bottom: false,
        child: ListTile(dense: true, title: _buildTitle(styles), onTap: onTap));
  }

  Widget _buildTitle(Styles styles) {
    if (emphasis) {
      final richTitle = _RichTitle(title);
      return RichText(
        text: TextSpan(
          style: styles.texts.itemTile,
          children: <TextSpan>[
            TextSpan(text: richTitle.firstWord),
            TextSpan(
                text: richTitle.remainingWords,
                style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      );
    } else {
      return Text(title, style: styles.texts.itemTile);
    }
  }
}

class _RichTitle {
  String firstWord;
  String remainingWords;

  _RichTitle(String title) {
    final words = title.split(' ');
    firstWord = words.isNotEmpty ? words[0] : '';
    remainingWords = words.length > 1
        ? ' ' + words.sublist(1)?.join(" ")?.toCapitalCase()
        : '';
  }
}
