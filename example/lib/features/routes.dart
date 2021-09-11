import 'package:flutter/material.dart';

class RouteList {}

class Routes {
  static Map<String, WidgetBuilder> _getAll(RouteSettings settings) => {};

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final _builder = _getAll(settings)[settings.name!];
    if ([
      // RouteList.account,
    ].contains(settings.name)) {
      return pageRouteBuilder(_builder);
    }

    // default
    return MaterialPageRoute(
      builder: _builder!,
      settings: settings,
      fullscreenDialog: false,
    );
  }

  static PageRouteBuilder pageRouteBuilder(WidgetBuilder? _builder) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return _builder!(context);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween =
            Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(
          CurveTween(curve: Curves.easeIn),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
