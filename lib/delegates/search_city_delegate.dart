import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_truck_driver_app/bloc/search/search_bloc.dart';

class SearchCityDelegate extends SearchDelegate {
  SearchCityDelegate() : super(searchFieldLabel: 'Search a city');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    searchBloc.searchCities();
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      final results = state.searchResults;
      return ListView.separated(
          itemBuilder: (context, index) {
            final result = results[index];
            return ListTile(
              title: Text(result.city),
              leading: const Icon(Icons.place_outlined, color: Colors.black),
              onTap: () {
                searchBloc.add(OnAddPlaceToHistory(result));
                close(context, result);
              },
            );
          },
          separatorBuilder: (_, __) => const Divider(),
          itemCount: results.length);
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const ListTile(
      title: Text('History'),
    );
  }
}
