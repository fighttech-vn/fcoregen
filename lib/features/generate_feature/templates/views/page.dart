/// Replase with key
/// - <Generate|Name>
/// - <Generate|NameUpperFirst>

const templateViewsPage = '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/base/base_statefull.dart';
import '../bloc/<Generate|Name>_bloc.dart';

part '<Generate|Name>.action.dart';
part '<Generate|Name>.children.dart';

class <Generate|NameUpperFirst>Page extends StatefulWidget {
  const <Generate|NameUpperFirst>Page({Key? key}) : super(key: key);
  @override
  _<Generate|NameUpperFirst>PageState createState() => _<Generate|NameUpperFirst>PageState();
}

class _<Generate|NameUpperFirst>PageState extends StatefulWidgetBase<<Generate|NameUpperFirst>Page> {
  <Generate|NameUpperFirst>Bloc get <Generate|Name>Bloc => BlocProvider.of(context);

  @override
  void onViewModelDidBind() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocBuilder<<Generate|NameUpperFirst>Bloc, <Generate|NameUpperFirst>State>(
        builder: (context, state) {
          return const Center(child: Text('<Generate|NameUpperFirst> Page'));
        },
      ),
    );
  }
}
''';
