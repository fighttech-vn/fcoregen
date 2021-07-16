import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../interactor/home_interactor.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeInteractor interactor;

  HomeBloc(this.interactor) : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    switch (event.runtimeType) {
      case HomeInitialEvent:
        yield* _mapHomeInitialEvent(event as HomeInitialEvent);
        break;
    }
  }

  Stream<HomeState> _mapHomeInitialEvent(HomeInitialEvent event) async* {
    yield HomeInitial();
  }
}
