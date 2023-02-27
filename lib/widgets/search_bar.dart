import 'package:flutter/material.dart';
import 'package:flutter_truck_driver_app/helpers/search_delegate_helper.dart';

class SearchBar extends StatelessWidget {
  final SearchDelegate searchDelegate;
  final SearchDelegateHelper searchDelegateHelper;
  const SearchBar({
    super.key,
    required this.searchDelegate,
    required this.searchDelegateHelper,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
              context: context,
              delegate: searchDelegate,
            );
            if (result == null) return;
            searchDelegateHelper.handleCitySearchResult(result.coordinates);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                )
              ],
            ),
            child: const Text(
              'Where is your next destination?',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}
