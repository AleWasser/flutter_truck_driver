import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_truck_driver_app/bloc/bloc.dart';
import 'package:flutter_truck_driver_app/routes/routes.dart';

void main() => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => GpsBloc()),
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
