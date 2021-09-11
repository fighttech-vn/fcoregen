import 'templates/templates.dart';

enum GenerateFeatureType { screen, page }

class GenerateFeatureConstants {
  static const structureFolderScreen = [
    {
      'name': 'bloc',
      'files': [
        'bloc',
        'event',
        'state',
      ],
    },
    {
      'name': 'coordinator',
      'files': ['coordinator'],
    },
    {
      'name': 'interactor',
      'files': ['interactor', 'repository'],
      'subFolder': [
        {
          'name': 'impl',
          'files': ['interactor_impl']
        }
      ]
    },
    {
      'name': 'repository',
      'files': ['repository_impl'],
    },
    {
      'name': 'views',
      'files': ['screen', 'screen_action', 'screen_children'],
    }
  ];

  static const structureFolderPage = [
    {
      'name': 'bloc',
      'files': [
        'bloc',
        'event',
        'state',
      ],
    },
    {
      'name': 'interactor',
      'files': ['interactor', 'repository'],
      'subFolder': [
        {
          'name': 'impl',
          'files': ['interactor_impl']
        }
      ]
    },
    {
      'name': 'repository',
      'files': ['repository_impl'],
    },
    {
      'name': 'views',
      'files': ['page', 'page_action', 'page_children'],
    }
  ];

  static const defineContentsFile = <String, Map<String, dynamic>>{
    'bloc': {
      'content': templateBlocFile,
      'nameFile': '<Generate|Name>_bloc.dart',
    },
    'event': {
      'content': templateBlocEvent,
      'nameFile': '<Generate|Name>_event.dart',
    },
    'state': {
      'content': templateBlocState,
      'nameFile': '<Generate|Name>_state.dart',
    },
    'coordinator': {
      'content': templateCoordinator,
      'nameFile': '<Generate|Name>_coordinator.dart',
    },
    'interactor': {
      'content': templateInteractorFile,
      'nameFile': '<Generate|Name>_interactor.dart',
    },
    'repository': {
      'content': templateInteractorRepository,
      'nameFile': '<Generate|Name>_repository.dart',
    },
    'interactor_impl': {
      'content': templateInteractorImpl,
      'nameFile': '<Generate|Name>_interactor_impl.dart',
    },
    'repository_impl': {
      'content': templateRepositoryImpl,
      'nameFile': '<Generate|Name>_repository_impl.dart',
    },
    'screen': {
      'content': templateViewsScreen,
      'nameFile': '<Generate|Name>_screen.dart',
    },
    'screen_action': {
      'content': templateViewsActionScreen,
      'nameFile': '<Generate|Name>.action.dart',
    },
    'screen_children': {
      'content': templateViewsChildrenScreen,
      'nameFile': '<Generate|Name>.children.dart',
    },
    'page': {
      'content': templateViewsPage,
      'nameFile': '<Generate|Name>_page.dart',
    },
    'page_action': {
      'content': templateViewsActionPage,
      'nameFile': '<Generate|Name>.action.dart',
    },
    'page_children': {
      'content': templateViewsChildrenPage,
      'nameFile': '<Generate|Name>.children.dart',
    },
  };
}
