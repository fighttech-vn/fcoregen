/// Replase with key
/// - <Generate|Name>
/// - <Generate|NameUpperFirst>

const templateViewsScreen = '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/base/base_statefull.dart';
import '../bloc/<Generate|Name>_bloc.dart';

part '<Generate|Name>.action.dart';
part '<Generate|Name>.children.dart';

class <Generate|NameUpperFirst>Screen extends StatefulWidget {
  const <Generate|NameUpperFirst>Screen({Key? key}) : super(key: key);
  @override
  _<Generate|NameUpperFirst>ScreenState createState() => _<Generate|NameUpperFirst>ScreenState();
}

class _<Generate|NameUpperFirst>ScreenState extends StatefulWidgetBase<<Generate|NameUpperFirst>Screen> {
  <Generate|NameUpperFirst>Bloc get <Generate|Name>Bloc => BlocProvider.of(context);

  @override
  void onViewModelDidBind() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocBuilder<<Generate|NameUpperFirst>Bloc, <Generate|NameUpperFirst>State>(
        builder: (context, state) {
          return const Center(child: Text('<Generate|NameUpperFirst> Screen'));
        },
      ),
    );
  }
}
''';
