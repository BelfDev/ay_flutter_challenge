import 'package:ay_flutter_challenge/blocs/blocs.dart';
import 'package:ay_flutter_challenge/blocs/state_status.dart';
import 'package:ay_flutter_challenge/data/models/models.dart';
import 'package:ay_flutter_challenge/data/repositories/contact_repository.dart';
import 'package:ay_flutter_challenge/routes/contact_detail_route.dart';
import 'package:ay_flutter_challenge/services/contact_search.dart';
import 'package:ay_flutter_challenge/utils/styles.dart';
import 'package:ay_flutter_challenge/widgets/placeholders/error_placeholder.dart';
import 'package:ay_flutter_challenge/widgets/search_bar.dart';
import 'package:ay_flutter_challenge/widgets/tiles/grouped_list_item_tile.dart';
import 'package:ay_flutter_challenge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:with_bloc/with_bloc.dart';

/// A [StatelessWidget] which encapsulates the contents of the
/// of the Contact Book screen.
class ContactBookRoute extends StatelessWidget {
  static const String id = '/contact-book';
  static const double _barExpandedHeight = 142;
  static const String _routeTitle = 'Contacts';

  ContactBookRoute({Key key, @required this.contactRepository})
      : assert(contactRepository != null),
        super(key: key);

  final ContactRepository contactRepository;
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  /// Callback for when the search page closes with a successful result.
  /// [contact] is the result selected in the search page.
  void _onSearchResult(BuildContext context, Contact contact) {
    if (contact != null)
      Navigator.of(context).pushNamed(ContactDetailRoute.id,
          arguments: {'title': contact.fullName});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: _buildHeaderSliver,
            body: _buildBody(context)));
  }

  List<Widget> _buildHeaderSliver(
          BuildContext context, bool innerBoxIsScrolled) =>
      <Widget>[
        SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: FlexibleSliverAppBar(
              title: _routeTitle,
              forceElevated: innerBoxIsScrolled,
              expandedHeight: _barExpandedHeight,
              searchBar: _buildSearchBar()),
        ),
      ];

  Widget _buildSearchBar() => SearchBar<Contact>(
      padding:
          const EdgeInsets.fromLTRB(16.0, _barExpandedHeight - 8, 16.0, 0.0),
      searchDelegate: ContactSearchDelegate(contactRepository),
      onResult: _onSearchResult);

  Widget _buildBody(BuildContext context) =>
      WithBloc<ContactBloc, ContactState>(
          createBloc: (context) =>
              ContactBloc(contactRepository)..requestContactSections(),
          builder: (context, bloc, state, _) {
            final sectionList = state.results;

            return RefreshIndicator(
              key: refreshKey,
              onRefresh: () async => bloc.requestContactSections(),
              displacement:
                  MediaQuery.of(context).padding.top + kToolbarHeight + 24,
              child: Builder(builder: (BuildContext context) {
                switch (state.status) {
                  case StateStatus.initial:
                    return Center(child: CircularProgressIndicator());
                  case StateStatus.failure:
                    return ErrorPlaceholder();
                  default:
                    if (sectionList.isEmpty)
                      return Center(child: CircularProgressIndicator());

                    return _buildGroupedListView(context, sectionList);
                }
              }),
            );
          });

  Widget _buildGroupedListView(
      BuildContext context, List<Section<Contact>> sectionList) {
    final styles = Styles.of(context);
    return GroupedListView<Section<Contact>, Contact>(
        nested: true,
        header: _buildGroupedListViewHeader(context),
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
        footer: _buildGroupedListViewFooter());
  }

  /// Builds a dummy header for demonstration purposes.
  Widget _buildGroupedListViewHeader(BuildContext context) {
    final styles = Styles.of(context);
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        height: 64,
        child: Text('Pedro Belfort\n= Made in Brazil =',
            textAlign: TextAlign.center, style: styles.texts.sectionTile),
      ),
    );
  }

  /// Builds a dummy footer for demonstration purposes.
  Widget _buildGroupedListViewFooter() => SliverFixedExtentList(
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
      );
}
