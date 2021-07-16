/// Replase with key
/// - <Generate|Name>
/// - <Generate|NameUpperFirst>

const routeImport =
    '''import '<Generate|Name>/interactor/impl/<Generate|Name>_interactor_impl.dart';
import '<Generate|Name>/repository/<Generate|Name>_repository_impl.dart';
import '<Generate|Name>/bloc/<Generate|Name>_bloc.dart';
import '<Generate|Name>/views/<Generate|Name>_screen.dart';''';

const routeList =
    '''static const String <Generate|Name> = '<Generate|Name>';''';

const routeClass = '''
        RouteList.<Generate|Name>: (context) {
          return BlocProvider<<Generate|NameUpperFirst>Bloc>(
            create: (context) => <Generate|NameUpperFirst>Bloc(<Generate|NameUpperFirst>InteractorImpl(
                repository: <Generate|NameUpperFirst>RepositoryImpl(), dataManager: DataManager())),
            child: const <Generate|NameUpperFirst>Screen(),
          );
        },''';
