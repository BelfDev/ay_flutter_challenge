import 'package:ay_flutter_challenge/blocs/blocs.dart';
import 'package:ay_flutter_challenge/blocs/contact/contact_state.dart';
import 'package:ay_flutter_challenge/data/models/contact.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:ay_flutter_challenge/routes/contact_detail_route.dart';
import 'package:ay_flutter_challenge/services/contact_search.dart';
import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:ay_flutter_challenge/widgets/search_bar.dart';
import 'package:ay_flutter_challenge/widgets/tiles/grouped_list_item_tile.dart';
import 'package:ay_flutter_challenge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:with_bloc/with_bloc.dart';

/// A [StatelessWidget] which encapsulates the contents of the
/// of the Contact Book screen.
class ContactBookRoute extends StatelessWidget {
  static const String id = '/contact-book';
  static const double barExpandedHeight = 142;

  final refreshKey = GlobalKey<RefreshIndicatorState>();

  final repo = ContactRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            floatHeaderSlivers: false,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: FlexibleSliverAppBar(
                      title: 'Contacts',
                      forceElevated: innerBoxIsScrolled,
                      expandedHeight: barExpandedHeight,
                      searchBar: SearchBar<Contact>(
                        padding: const EdgeInsets.fromLTRB(
                            16.0, barExpandedHeight - 8, 16.0, 0.0),
                        searchDelegate: ContactSearch(repo),
                        onResult: (Contact contact) {
                          if (contact != null)
                            Navigator.of(context).pushNamed(
                                ContactDetailRoute.id,
                                arguments: {'title': contact.fullName});
                        },
                      )),
                ),
              ];
            },
            body: _buildGroupedListView(context)));
  }

  Widget _buildGroupedListView(BuildContext context) {
    final styles = Styles.of(context);

    return WithBloc<ContactBloc, ContactState>(
        createBloc: (context) => ContactBloc(repo)..requestContactSections(),
        builder: (context, bloc, state, _) {
          final sectionList = state.results ?? [];

          return RefreshIndicator(
            key: refreshKey,
            onRefresh: () async => bloc.requestContactSections(),
            displacement:
                MediaQuery.of(context).padding.top + kToolbarHeight + 24,
            child: Builder(builder: (BuildContext context) {
              if (sectionList.isEmpty)
                return Center(child: CircularProgressIndicator());

              return GroupedListView<Section<Contact>, Contact>(
                  nested: true,
                  header: SliverToBoxAdapter(
                    child: Container(
                      alignment: Alignment.center,
                      height: 64,
                      child: Text('Pedro Belfort\n= Made in Brazil =',
                          textAlign: TextAlign.center,
                          style: styles.texts.sectionTile),
                    ),
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
                      onTap: () => Navigator.of(context).pushNamed(
                          ContactDetailRoute.id,
                          arguments: {'title': contact.fullName}),
                    );
                  },
                  footer: SliverFixedExtentList(
                    itemExtent: 50.0,
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          alignment: Alignment.center,
                          color: Colors.lightBlue[100 * (index % 9)],
                          child: Text('list item $index'),
                        );
                      },
                    ),
                  ));
            }),
          );
        });
  }
}
