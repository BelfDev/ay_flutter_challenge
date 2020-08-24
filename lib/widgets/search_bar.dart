import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SearchResult<T> = Function(T result);

class SearchBar<T> extends StatelessWidget {
  const SearchBar({Key key, this.searchDelegate, this.onResult})
      : assert(searchDelegate != null),
        super(key: key);

  final SearchDelegate<T> searchDelegate;
  final SearchResult<T> onResult;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 120.0),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
          child: Container(
            height: 36.0,
            width: double.infinity,
            child: CupertinoTextField(
              onTap: () {
                showSearch(context: context, delegate: searchDelegate)
                    .then((value) => onResult(value));
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
        ),
      ],
    );
  }
}
