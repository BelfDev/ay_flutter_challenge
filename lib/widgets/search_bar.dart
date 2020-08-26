import 'package:ay_flutter_challenge/configs/app_localizations.dart';
import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SearchResult<T> = Function(BuildContext context, T result);

/// A customized [CupertinoTextField] used as a search bar.
/// This widget is typically part of a [FlexibleSliverAppBar].
class SearchBar<T> extends StatelessWidget {
  static const double _height = 40;

  const SearchBar(
      {Key key, this.searchDelegate, this.onResult, this.borderRadius})
      : assert(searchDelegate != null),
        super(key: key);

  final SearchDelegate<T> searchDelegate;
  final SearchResult<T> onResult;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    final styles = Styles.of(context);
    final radius = borderRadius ?? BorderRadius.circular(8.0);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
      child: Container(
        height: _height,
        width: double.infinity,
        child: Material(
          color: styles.searchBarColor,
          borderRadius: radius,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: radius,
            ),
            onTap: () {
              showSearch(context: context, delegate: searchDelegate)
                  .then((value) => onResult(context, value));
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.search,
                    color: styles.placeholderIconColor,
                  ),
                ),
                Text(
                  AppLocalizations.of(context).searchRoute.hint,
                  style: styles.texts.hint,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
