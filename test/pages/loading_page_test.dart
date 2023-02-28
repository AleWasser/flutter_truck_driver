import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_truck_driver_app/bloc/bloc.dart';
import 'package:flutter_truck_driver_app/pages/pages.dart';
import 'package:flutter_truck_driver_app/screens/gps_screen.dart';
import 'loading_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GpsBloc>()])
void main() {
  late GpsBloc gpsBloc;

  setUp(() {
    gpsBloc = MockGpsBloc();
  });
  group('Loading Page', () {
    testWidgets('Loading page renders gps screen if gps access is not granted',
        (WidgetTester widgetTester) async {
      when(gpsBloc.state).thenReturn(
        const GpsState(
          isGpsEnabled: false,
          isGpsPermissionGranted: false,
        ),
      );

      await widgetTester.pumpWidget(
        BlocProvider.value(
          value: gpsBloc,
          child: const MaterialApp(
            home: LoadingPage(),
          ),
        ),
      );

      expect(
        find.byType(GpsScreen),
        findsOneWidget,
      );
    });

    testWidgets('Loading page renders map page if gps access is granted',
        (WidgetTester widgetTester) async {
      when(gpsBloc.state).thenReturn(
        const GpsState(
          isGpsEnabled: true,
          isGpsPermissionGranted: true,
        ),
      );

      await widgetTester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => gpsBloc),
            BlocProvider(create: (_) => MapBloc()),
            BlocProvider(create: (_) => LocationBloc(mapBloc: MapBloc())),
          ],
          child: const MaterialApp(
            home: LoadingPage(),
          ),
        ),
      );

      expect(
        find.byType(MapPage),
        findsOneWidget,
      );
    });
  });
}
