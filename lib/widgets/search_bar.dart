import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SearchResult<T> = Function(BuildContext context, T result);

/// A customized [CupertinoTextField] used as a search bar.
/// This widget is typically part of a [FlexibleSliverAppBar].
class SearchBar<T> extends StatelessWidget {
  static const double height = 36;

  const SearchBar({Key key, this.searchDelegate, this.onResult, this.padding})
      : assert(searchDelegate != null),
        super(key: key);

  final SearchDelegate<T> searchDelegate;
  final SearchResult<T> onResult;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Container(
        height: height,
        width: double.infinity,
        child: CupertinoTextField(
          onTap: () {
            showSearch(context: context, delegate: searchDelegate)
                .then((value) => onResult(context, value));
          },
          keyboardType: TextInputType.text,
          placeholder: 'Filtrar por nombre o nombre corto',
          placeholderStyle: TextStyle(
            color: Color(0xffC4C6CC),
            fontSize: 14.0,
            fontFamily: 'Brutal',
          ),
          prefix: Padding(
            padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
            child: Icon(
              Icons.search,
              color: Color(0xffC4C6CC),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color(0xffF0F1F5),
          ),
        ),
      ),
    );
  }
}
