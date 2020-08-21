import 'package:ay_flutter_challenge/configs/configs.dart';
import 'package:flutter/material.dart';

class GroupedListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Builder(builder: (BuildContext context) {
      return CustomScrollView(
        // The "controller" and "primary" members should be left
        // unset, so that the NestedScrollView can control this
        // inner scroll view.
        // If the "controller" property is set, then this scroll
        // view will not be associated with the NestedScrollView.
        slivers: <Widget>[
          SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          SliverFixedExtentList(
            itemExtent: 48.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => ListTile(
                  title: Text(
                'Item $index',
                style: theme.textTheme.headline1,
              )),
              childCount: 30,
            ),
          ),
        ],
      );
    });
  }
}
