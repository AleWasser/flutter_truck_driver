import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_truck_driver_app/bloc/location/location_bloc.dart';
import 'package:flutter_truck_driver_app/bloc/map/map_bloc.dart';
import 'package:flutter_truck_driver_app/bloc/search/search_bloc.dart';
import 'package:flutter_truck_driver_app/delegates/search_city_delegate.dart';
import 'package:flutter_truck_driver_app/helpers/search_delegate_helper.dart';
import 'package:flutter_truck_driver_app/repositories/geo_location_repository.dart';
import 'package:flutter_truck_driver_app/widgets/widgets.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_bar_widget_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LocationBloc>(),
  MockSpec<MapBloc>(),
  MockSpec<SearchDelegateHelper>()
])
void main() {
  late LocationBloc locationBloc;
  late MapBloc mapBloc;
  final searchDelegateHelper = MockSearchDelegateHelper();

  setUp(() {
    mapBloc = MockMapBloc();
    locationBloc = MockLocationBloc();
  });
  testWidgets(
    "it shows a text",
    (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => MapBloc()),
            BlocProvider(
              create: (BuildContext context) => LocationBloc(
                mapBloc: BlocProvider.of<MapBloc>(context),
              ),
            ),
          ],
          child: MaterialApp(
            home: SearchBar(
              searchDelegate: SearchCityDelegate(),
              searchDelegateHelper: searchDelegateHelper,
            ),
          ),
        ),
      );
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('Where is your next destination?'), findsOneWidget);
    },
  );

  group("Search Delegate", () {
    testWidgets("It open and close search delegate",
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => MapBloc()),
            BlocProvider(
              create: (BuildContext context) => LocationBloc(
                mapBloc: BlocProvider.of<MapBloc>(context),
              ),
            ),
          ],
          child: MaterialApp(
            home: SearchBar(
              searchDelegate: SearchCityDelegate(),
              searchDelegateHelper: searchDelegateHelper,
            ),
          ),
        ),
      );
      await widgetTester.tap(find.byType(Container).first);
      await widgetTester.pumpAndSettle();

      expect(find.text('Where is your next destination?'), findsNothing);
      expect(find.text('Search a city'), findsOneWidget);

      await widgetTester.tap(find.byIcon(Icons.arrow_back_ios));
      await widgetTester.pumpAndSettle();

      expect(find.text('Where is your next destination?'), findsOneWidget);
      expect(find.text('Search a city'), findsNothing);
    });

    testWidgets(
        "After searching it shows a list of results and returns coordinates of the selected item",
        (WidgetTester widgetTester) async {
      final searchDelegate = SearchCityDelegate();
      final geoLocationRepository = GeoLocationRepository();
      final chicagoCoordinates = geoLocationRepository
          .getGeo()
          .where((element) => element.city == 'Chicago')
          .first
          .coordinates;

      await widgetTester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => mapBloc),
            BlocProvider(create: (_) => locationBloc),
            BlocProvider(
              create: (_) => SearchBloc(
                geoLocationRepository: geoLocationRepository,
              ),
            )
          ],
          child: MaterialApp(
            home: SearchBar(
              searchDelegate: searchDelegate,
              searchDelegateHelper: searchDelegateHelper,
            ),
          ),
        ),
      );
      await widgetTester.tap(find.byType(Container).first);
      await widgetTester.pumpAndSettle();

      expect(find.text('Where is your next destination?'), findsNothing);
      expect(find.text('Search a city'), findsOneWidget);

      await widgetTester.enterText(find.byType(TextField), 'Chicago');
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);
      await widgetTester.pumpAndSettle();

      expect(searchDelegate.query, 'Chicago');
      expect(find.byType(ListTile), findsWidgets);

      await widgetTester.tap(find.byType(ListTile).first);
      await widgetTester.pumpAndSettle();

      expect(find.text('Where is your next destination?'), findsOneWidget);
      expect(find.text('Search a city'), findsNothing);
      verify(
        searchDelegateHelper.handleCitySearchResult(chicagoCoordinates),
      ).called(1);
    });

    test("SearchDelegateHelper handles new coordinates properly", () {
      final searchDelegateHelper = SearchDelegateHelper(
        mapBloc: mapBloc,
        locationBloc: locationBloc,
      );
      final geoLocationRepository = GeoLocationRepository();
      final chicagoCoordinates = geoLocationRepository
          .getGeo()
          .where((element) => element.city == 'Chicago')
          .first
          .coordinates;

      searchDelegateHelper.handleCitySearchResult(chicagoCoordinates);
      verify(locationBloc.add(OnStopFollowingUser())).called(1);
      verify(
        mapBloc.add(OnMoveCameraToCoordinatesEvent(chicagoCoordinates)),
      ).called(1);
    });
  });
}
