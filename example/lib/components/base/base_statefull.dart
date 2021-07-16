import 'package:flutter/material.dart';

abstract class ViewModelBaseInterface {
  void onViewModelDidBind();
}

abstract class StatefulWidgetBase<T extends StatefulWidget> extends State<T>
    implements ViewModelBaseInterface {}
