/// Replase with key
/// - <Generate|Name>
/// - <Generate|NameUpperFirst>

const templateRepositoryImpl =
    '''import '../interactor/<Generate|Name>_repository.dart';

class <Generate|NameUpperFirst>RepositoryImpl extends <Generate|NameUpperFirst>Repository {
  <Generate|NameUpperFirst>RepositoryImpl();
}
''';
