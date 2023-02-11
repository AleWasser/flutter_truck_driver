import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_truck_driver_app/bloc/gps/gps_bloc.dart';

class GpsScreen extends StatelessWidget {
  final bool isGpsEnabled;

  const GpsScreen({super.key, required this.isGpsEnabled});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isGpsEnabled ? _GpsAccess() : _GpsEnable(),
      ),
    );
  }
}

class _GpsEnable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('To continue you need to turn on your location services');
  }
}

class _GpsAccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gpsBloc = BlocProvider.of<GpsBloc>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('To continue we need access to your location'),
        Platform.isAndroid
            ? ElevatedButton(
                onPressed: () async => await gpsBloc.askGpsAccess(),
                child: const Text('Grant Permission'),
              )
            : CupertinoButton(
                onPressed: () async => await gpsBloc.askGpsAccess(),
                child: const Text('Grant Permission'),
              ),
      ],
    );
  }
}
