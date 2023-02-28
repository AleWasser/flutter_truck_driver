// Mocks generated by Mockito 5.3.2 from annotations
// in flutter_truck_driver_app/test/widget/search_bar_widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:bloc/bloc.dart' as _i6;
import 'package:flutter_truck_driver_app/bloc/location/location_bloc.dart'
    as _i3;
import 'package:flutter_truck_driver_app/bloc/map/map_bloc.dart' as _i2;
import 'package:flutter_truck_driver_app/helpers/search_delegate_helper.dart'
    as _i8;
import 'package:geolocator/geolocator.dart' as _i5;
import 'package:google_maps_flutter/google_maps_flutter.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeMapBloc_0 extends _i1.SmartFake implements _i2.MapBloc {
  _FakeMapBloc_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLocationState_1 extends _i1.SmartFake implements _i3.LocationState {
  _FakeLocationState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMapState_2 extends _i1.SmartFake implements _i2.MapState {
  _FakeMapState_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLocationBloc_3 extends _i1.SmartFake implements _i3.LocationBloc {
  _FakeLocationBloc_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LocationBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocationBloc extends _i1.Mock implements _i3.LocationBloc {
  @override
  set positionStream(_i4.StreamSubscription<_i5.Position>? _positionStream) =>
      super.noSuchMethod(
        Invocation.setter(
          #positionStream,
          _positionStream,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i2.MapBloc get mapBloc => (super.noSuchMethod(
        Invocation.getter(#mapBloc),
        returnValue: _FakeMapBloc_0(
          this,
          Invocation.getter(#mapBloc),
        ),
        returnValueForMissingStub: _FakeMapBloc_0(
          this,
          Invocation.getter(#mapBloc),
        ),
      ) as _i2.MapBloc);
  @override
  _i3.LocationState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeLocationState_1(
          this,
          Invocation.getter(#state),
        ),
        returnValueForMissingStub: _FakeLocationState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.LocationState);
  @override
  _i4.Stream<_i3.LocationState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<_i3.LocationState>.empty(),
        returnValueForMissingStub: _i4.Stream<_i3.LocationState>.empty(),
      ) as _i4.Stream<_i3.LocationState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i4.Future<void> getCurrentPosition() => (super.noSuchMethod(
        Invocation.method(
          #getCurrentPosition,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  void followUser() => super.noSuchMethod(
        Invocation.method(
          #followUser,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void stopFollowingUser() => super.noSuchMethod(
        Invocation.method(
          #stopFollowingUser,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  void add(_i3.LocationEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onEvent(_i3.LocationEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void emit(_i3.LocationState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void on<E extends _i3.LocationEvent>(
    _i6.EventHandler<E, _i3.LocationState>? handler, {
    _i6.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onTransition(
          _i6.Transition<_i3.LocationEvent, _i3.LocationState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onChange(_i6.Change<_i3.LocationState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [MapBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMapBloc extends _i1.Mock implements _i2.MapBloc {
  @override
  set locationStateSubscription(
          _i4.StreamSubscription<_i3.LocationState>?
              _locationStateSubscription) =>
      super.noSuchMethod(
        Invocation.setter(
          #locationStateSubscription,
          _locationStateSubscription,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i2.MapState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeMapState_2(
          this,
          Invocation.getter(#state),
        ),
        returnValueForMissingStub: _FakeMapState_2(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.MapState);
  @override
  _i4.Stream<_i2.MapState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<_i2.MapState>.empty(),
        returnValueForMissingStub: _i4.Stream<_i2.MapState>.empty(),
      ) as _i4.Stream<_i2.MapState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  void moveCamera(_i7.LatLng? coordinates) => super.noSuchMethod(
        Invocation.method(
          #moveCamera,
          [coordinates],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void createArea(List<_i7.LatLng>? coordinates) => super.noSuchMethod(
        Invocation.method(
          #createArea,
          [coordinates],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void add(_i2.MapEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onEvent(_i2.MapEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void emit(_i2.MapState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void on<E extends _i2.MapEvent>(
    _i6.EventHandler<E, _i2.MapState>? handler, {
    _i6.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onTransition(_i6.Transition<_i2.MapEvent, _i2.MapState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  void onChange(_i6.Change<_i2.MapState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [SearchDelegateHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchDelegateHelper extends _i1.Mock
    implements _i8.SearchDelegateHelper {
  @override
  _i2.MapBloc get mapBloc => (super.noSuchMethod(
        Invocation.getter(#mapBloc),
        returnValue: _FakeMapBloc_0(
          this,
          Invocation.getter(#mapBloc),
        ),
        returnValueForMissingStub: _FakeMapBloc_0(
          this,
          Invocation.getter(#mapBloc),
        ),
      ) as _i2.MapBloc);
  @override
  _i3.LocationBloc get locationBloc => (super.noSuchMethod(
        Invocation.getter(#locationBloc),
        returnValue: _FakeLocationBloc_3(
          this,
          Invocation.getter(#locationBloc),
        ),
        returnValueForMissingStub: _FakeLocationBloc_3(
          this,
          Invocation.getter(#locationBloc),
        ),
      ) as _i3.LocationBloc);
  @override
  set result(dynamic _result) => super.noSuchMethod(
        Invocation.setter(
          #result,
          _result,
        ),
        returnValueForMissingStub: null,
      );
  @override
  void handleSearchResult(dynamic result) => super.noSuchMethod(
        Invocation.method(
          #handleSearchResult,
          [result],
        ),
        returnValueForMissingStub: null,
      );
}
