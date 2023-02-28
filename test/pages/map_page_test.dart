import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_truck_driver_app/bloc/bloc.dart';
import 'package:flutter_truck_driver_app/pages/map_page.dart';
import 'package:flutter_truck_driver_app/widgets/widgets.dart';
import 'map_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocationBloc>(), MockSpec<MapBloc>()])
void main() {
  late LocationBloc locationBloc;
  late MapBloc mapBloc;

  setUp(() {
    locationBloc = MockLocationBloc();
    mapBloc = MockMapBloc();

    when(locationBloc.state).thenReturn(
      LocationState(
        lastKnownLocation: LatLng(
          Random().nextDouble() * 90,
          Random().nextDouble() * 180,
        ),
      ),
    );
    when(mapBloc.state).thenReturn(const MapState(polygons: {}));
  });

  group('Map Page', () {
    testWidgets(
      'Map page shows a loading text if location is unknown',
      (WidgetTester widgetTester) async {
        when(locationBloc.state).thenReturn(const LocationState());

        await widgetTester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => locationBloc),
              BlocProvider(create: (_) => mapBloc),
            ],
            child: const MaterialApp(
              home: MapPage(),
            ),
          ),
        );

        expect(
          find.text('Please wait...'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'Map page shows a map if the location is known',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => locationBloc),
              BlocProvider(create: (_) => mapBloc),
            ],
            child: const MaterialApp(
              home: MapPage(),
            ),
          ),
        );

        expect(
          find.byType(MapWidget),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'Map page shows a floating action button which triggers a bloc event on click',
      (WidgetTester widgetTester) async {
        await widgetTester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => locationBloc),
              BlocProvider(create: (_) => mapBloc),
            ],
            child: const MaterialApp(
              home: MapPage(),
            ),
          ),
        );

        var floatingActionButton = find.byType(FloatingActionButton);
        await widgetTester.tap(floatingActionButton);
        expect(
          floatingActionButton,
          findsOneWidget,
        );

        verify(locationBloc.add(OnStartFollowingUser())).called(1);
      },
    );
  });
}
