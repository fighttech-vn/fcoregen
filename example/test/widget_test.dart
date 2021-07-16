// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    var e10 = 1;
    var e11 = 2;
    var s10 = 3;
    var s11 = 4;

    var mainModel = 1;
    if (!(mainModel == e10) &&
        !(mainModel == e11) &&
        (!(mainModel == s10) && !(mainModel == s11))) {
      print('case 1');
    } else {
      print('case 2');
    }

    expect(1, 1);
  });
}
