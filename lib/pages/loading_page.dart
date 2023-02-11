import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_truck_driver_app/bloc/gps/gps_bloc.dart';
import 'package:flutter_truck_driver_app/screens/gps_screen.dart';
import 'package:flutter_truck_driver_app/pages/map_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) => state.isAllGranted
            ? const MapPage()
            : GpsScreen(isGpsEnabled: state.isGpsEnabled),
      ),
    );
  }
}
