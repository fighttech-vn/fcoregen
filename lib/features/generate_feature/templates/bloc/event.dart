/// Replase with key
/// - <Generate|Name>
/// - <Generate|NameUpperFirst>

const templateBlocEvent = '''part of '<Generate|Name>_bloc.dart';

@immutable
abstract class <Generate|NameUpperFirst>Event {}

class <Generate|NameUpperFirst>InitialEvent extends <Generate|NameUpperFirst>Event {}''';
