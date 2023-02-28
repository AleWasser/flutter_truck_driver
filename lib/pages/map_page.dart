import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_truck_driver_app/bloc/bloc.dart';
import 'package:flutter_truck_driver_app/delegates/search_city_delegate.dart';
import 'package:flutter_truck_driver_app/helpers/search_delegate_helper.dart';
import 'package:flutter_truck_driver_app/widgets/widgets.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late LocationBloc locationBloc;
  late MapBloc mapBloc;

  @override
  void initState() {
    locationBloc = BlocProvider.of<LocationBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);
    locationBloc.followUser();
    super.initState();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state.lastKnownLocation == null) {
            return const Center(
              child: Text('Please wait...'),
            );
          }

          return Stack(
            children: [
              MapWidget(
                initialLocation: state.lastKnownLocation!,
                polygons: mapBloc.state.polygons.values.toSet(),
              ),
              SearchBar(
                searchDelegate: SearchCityDelegate(),
                searchDelegateHelper: SearchDelegateHelper(
                  mapBloc: mapBloc,
                  locationBloc: locationBloc,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          locationBloc.add(OnStartFollowingUser());
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
