import 'package:data/datasource/local/data_manager/data_manager.dart';

import '../interactor/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final DataManager dataManager;

  HomeRepositoryImpl({
    required this.dataManager,
  });
}
