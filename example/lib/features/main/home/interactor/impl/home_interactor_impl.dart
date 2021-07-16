import 'package:data/datasource/local/data_manager/data_manager.dart';

import '../home_interactor.dart';
import '../home_repository.dart';

class HomeInteractorImpl implements HomeInteractor {
  final HomeRepository repository;
  final DataManager dataManager;

  HomeInteractorImpl({
    required this.repository,
    required this.dataManager,
  });
}
