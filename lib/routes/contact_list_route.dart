import 'package:ay_flutter_challenge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A [StatelessWidget] which encapsulates the contents of the
/// of the Contact List screen.
class ContactListRoute extends StatelessWidget {
  static const String id = '/contact-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: FlexibleSliverAppBar(
                    title: 'Contacts', innerBoxIsScrolled: innerBoxIsScrolled),
              )
            ];
          },
          body: GroupedListView()),
    ));
  }
}
