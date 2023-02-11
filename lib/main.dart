import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_truck_driver_app/bloc/bloc.dart';
import 'package:flutter_truck_driver_app/routes/routes.dart';
import 'package:flutter_truck_driver_app/services/services.dart';

void main() => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => GpsBloc(
              permissionService: PermissionService(),
              geoLocatorService: GeoLocatorService(),
            ),
          ),
          BlocProvider(create: (_) => LocationBloc()),
          BlocProvider(
            create: (BuildContext context) => MapBloc(
              locationBloc: BlocProvider.of<LocationBloc>(context),
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
