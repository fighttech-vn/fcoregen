/// Replase with key
/// - <Generate|Name>
/// - <Generate|NameUpperFirst>
const templateInteractorImpl =
    '''import 'package:data/datasource/local/data_manager/data_manager.dart';

import '../<Generate|Name>_interactor.dart';
import '../<Generate|Name>_repository.dart';

class <Generate|NameUpperFirst>InteractorImpl extends <Generate|NameUpperFirst>Interactor {
  late final <Generate|NameUpperFirst>Repository _<Generate|Name>Repository;
  late final DataManager _dataManager;

  <Generate|NameUpperFirst>InteractorImpl({
    required <Generate|NameUpperFirst>Repository repository,
    required DataManager dataManager,
  }) {
    _<Generate|Name>Repository = repository;
    _dataManager = dataManager;
  }
}
''';
