import 'package:ay_flutter_challenge/data/models/contact.dart';
import 'package:ay_flutter_challenge/data/models/contact_book.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:ay_flutter_challenge/routes/contact_detail_route.dart';
import 'package:ay_flutter_challenge/widgets/tiles/grouped_list_item_tile.dart';
import 'package:ay_flutter_challenge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A [StatelessWidget] which encapsulates the contents of the
/// of the Contact Book screen.
class ContactBookRoute extends StatelessWidget {
  static const String id = '/contact-book';

  final repo = ContactRepository();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
            body: FutureBuilder<ContactBook>(
          future: repo.fetchContacts(),
          builder: _buildGroupedListView,
        )));
  }

  // TODO: Take the AppBar out of the future.
  Widget _buildGroupedListView(
      BuildContext context, AsyncSnapshot<ContactBook> snapshot) {
    final sectionList = snapshot.data.sections;

    return GroupedListView<Section<Contact>, Contact>(
      sliverAppBar: FlexibleSliverAppBar(
        title: 'Contacts',
      ),
      sectionList: sectionList,
      sectionBuilder: (context, sectionIndex, _) {
        final section = sectionList[sectionIndex];
        return GroupedListSectionTile(
          title: section.title,
        );
      },
      itemBuilder: (context, sectionIndex, itemIndex, int index) {
        final contact = sectionList[sectionIndex].items[itemIndex];
        return GroupedListItemTile(
          title: contact.fullName,
          onTap: () => Navigator.of(context).pushNamed(ContactDetailRoute.id,
              arguments: {'title': contact.fullName}),
        );
      },
    );
  }
}
