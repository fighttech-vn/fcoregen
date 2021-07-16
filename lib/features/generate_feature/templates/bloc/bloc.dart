/// Replase with key
/// - <Generate|Name>
/// - <Generate|NameUpperFirst>

const templateBlocFile = '''import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../interactor/<Generate|Name>_interactor.dart';

part '<Generate|Name>_event.dart';
part '<Generate|Name>_state.dart';

class <Generate|NameUpperFirst>Bloc extends Bloc<<Generate|NameUpperFirst>Event, <Generate|NameUpperFirst>State> {
  final <Generate|NameUpperFirst>Interactor _interactor;

  <Generate|NameUpperFirst>Bloc(this._interactor) : super(<Generate|NameUpperFirst>Initial());

  @override
  Stream<<Generate|NameUpperFirst>State> mapEventToState(
    <Generate|NameUpperFirst>Event event,
  ) async* {
    switch (event.runtimeType) {
      case <Generate|NameUpperFirst>InitialEvent:
        yield* _map<Generate|NameUpperFirst>InitialEvent(event as <Generate|NameUpperFirst>InitialEvent);
        break;
    }
  }

  Stream<<Generate|NameUpperFirst>State> _map<Generate|NameUpperFirst>InitialEvent(<Generate|NameUpperFirst>InitialEvent event) async* {
    yield <Generate|NameUpperFirst>Initial();
  }
}
''';
