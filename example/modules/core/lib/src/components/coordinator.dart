import 'package:flutter/material.dart';

abstract class Coordinator {
  Future<T?> start<T>();

  BuildContext get context =>
      NavigationService.navigationKey.currentState!.context;

  void onBack<T extends Object?>([T? result]) {
    Navigator.of(context).pop<T>(result);
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
}
