import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/base/base_statefull.dart';
import '../bloc/home_bloc.dart';

part 'home.action.dart';
part 'home.children.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StatefulWidgetBase<HomePage> {
  HomeBloc get homeBloc => BlocProvider.of(context);

  @override
  void onViewModelDidBind() {
    homeBloc.add(HomeInitialEvent());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return const Center(
            child: Text('Home Page'),
          );
        },
      ),
    );
  }
}
