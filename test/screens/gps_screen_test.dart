import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_truck_driver_app/bloc/gps/gps_bloc.dart';
import 'package:flutter_truck_driver_app/screens/gps_screen.dart';
import 'package:flutter_truck_driver_app/adapters/adapters.dart';

void main() {
  testWidgets('Gps screen asks for location services if gps is not enabled',
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      const MaterialApp(
        home: GpsScreen(
          isGpsEnabled: false,
        ),
      ),
    );

    expect(
      find.text('To continue you need to turn on your location services'),
      findsOneWidget,
    );
  });

  testWidgets('Gps screen asks for permission if gps is enabled',
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      BlocProvider.value(
        value: GpsBloc(
          permissionAdapter: PermissionAdapter(),
          geoLocatorAdapter: GeoLocatorAdapter(),
        ),
        child: const MaterialApp(
          home: GpsScreen(
            isGpsEnabled: true,
          ),
        ),
      ),
    );

    expect(
      find.text('To continue we need access to your location'),
      findsOneWidget,
    );
    expect(
      find.text('Grant Permission'),
      findsOneWidget,
    );
  });
}
