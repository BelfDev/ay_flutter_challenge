import 'package:ay_flutter_challenge/mock_data.dart';
import 'package:ay_flutter_challenge/routes/contact_detail_route.dart';
import 'package:ay_flutter_challenge/widgets/tiles/grouped_list_item_tile.dart';
import 'package:ay_flutter_challenge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A [StatelessWidget] which encapsulates the contents of the
/// of the Contact Book screen.
class ContactBookRoute extends StatelessWidget {
  static const String id = '/contact-book';

  // TODO: Replace with challenge data
  final sectionList = MockData.getExampleSections();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
            body: GroupedListView<ExampleSection, String>(
          sliverAppBar: FlexibleSliverAppBar(
            title: 'Contacts',
          ),
          sectionList: sectionList,
          sectionBuilder: _buildSection,
          itemBuilder: _buildItem,
        )));
  }

  Widget _buildItem(
      BuildContext context, int sectionIndex, itemIndex, int index) {
    String item = sectionList[sectionIndex].items[itemIndex];
    return GroupedListItemTile(
      title: item,
      onTap: () => Navigator.of(context)
          .pushNamed(ContactDetailRoute.id, arguments: {'title': item}),
    );
  }

  Widget _buildSection(BuildContext context, int sectionIndex, int index) {
    ExampleSection section = sectionList[sectionIndex];
    return GroupedListSectionTile(
      title: section.header,
    );
  }
}
