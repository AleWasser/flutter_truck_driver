import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_truck_driver_app/bloc/location/location_bloc.dart';
import 'package:flutter_truck_driver_app/bloc/map/map_bloc.dart';
import 'package:flutter_truck_driver_app/widgets/widgets.dart';
import 'map_widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocationBloc>(), MockSpec<MapBloc>()])
void main() {
  late LocationBloc locationBloc;
  late MapBloc mapBloc;
  final testLocation = LatLng(
    Random().nextDouble() * 90,
    Random().nextDouble() * 180,
  );

  setUp(() {
    locationBloc = MockLocationBloc();
    mapBloc = MockMapBloc();

    when(locationBloc.state).thenReturn(
      LocationState(lastKnownLocation: testLocation),
    );
  });
  group('Google map widget', () {
    testWidgets("It renders a GoogleMap widget",
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        BlocProvider.value(
          value: mapBloc,
          child: MaterialApp(
            home: MapWidget(initialLocation: testLocation),
          ),
        ),
      );

      expect(find.byType(GoogleMap), findsOneWidget);
    });

    testWidgets("It triggers an event when the user scroll the screen",
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        BlocProvider.value(
          value: mapBloc,
          child: MaterialApp(
            home: MapWidget(initialLocation: testLocation),
          ),
        ),
      );

      final TestGesture gesture = await widgetTester.startGesture(
        const Offset(0.0, 1.0),
        pointer: widgetTester.nextPointer,
      );
      await widgetTester.pump();
      await gesture.moveBy(const Offset(5.0, 20.0));
      await widgetTester.pump();
      await gesture.up();
      await widgetTester.pumpAndSettle();

      verify(mapBloc.add(const OnCenterCameraOnUserEvent(false))).called(1);
    });
  });
}
