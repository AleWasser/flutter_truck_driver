import 'package:flutter/material.dart';

import 'package:flutter_truck_driver_app/pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'loading': (_) => const LoadingPage(),
};
