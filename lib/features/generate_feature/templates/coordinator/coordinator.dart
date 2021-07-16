/// Replase with key
/// - <Generate|Name>
/// - <Generate|NameUpperFirst>

const templateCoordinator = '''import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

abstract class <Generate|NameUpperFirst>Coordinator extends Coordinator {}

class <Generate|NameUpperFirst>CoordinatorImpl extends <Generate|NameUpperFirst>Coordinator {
  @override
  Future<T?> start<T>() async {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(RouteList.<Generate|Name>, (route) => false);
  }
}
''';
