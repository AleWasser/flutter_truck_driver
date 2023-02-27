import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_truck_driver_app/bloc/bloc.dart';
import 'package:flutter_truck_driver_app/repositories/geo_location_repository.dart';
import 'package:flutter_truck_driver_app/routes/routes.dart';
import 'package:flutter_truck_driver_app/adapters/adapters.dart';

void main() => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => GpsBloc(
              permissionAdapter: PermissionAdapter(),
              geoLocatorAdapter: GeoLocatorAdapter(),
            ),
          ),
          BlocProvider(create: (_) => MapBloc()),
          BlocProvider(
            create: (BuildContext context) => LocationBloc(
              mapBloc: BlocProvider.of<MapBloc>(context),
            ),
          ),
          BlocProvider(
            create: (_) => SearchBloc(
              geoLocationRepository: GeoLocationRepository(),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Truck Driver',
      initialRoute: 'loading',
      routes: appRoutes,
    );
  }
}
