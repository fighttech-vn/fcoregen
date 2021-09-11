import 'dart:io';

import '../../contracts.dart';
import '../../helpers/helpers.dart';
import 'generate_feature_constants.dart';
import 'templates/templates.dart';

class GenerateFeature {
  final String name;
  final String folder;
  final GenerateFeatureType type;
  final bool createRoute;

  GenerateFeature({
    required this.name,
    required this.folder,
    this.type = GenerateFeatureType.screen,
    this.createRoute = true,
  }) {
    if (type == GenerateFeatureType.page) {
      _structureFolder = GenerateFeatureConstants.structureFolderPage;
    } else {
      _structureFolder = GenerateFeatureConstants.structureFolderScreen;
    }
  }

  String get folderFeature => '$folder/$name';

  var _keyDefine = [];
  late List<Map<String, Object>> _structureFolder;

  Future<void> create() async {
    _loadKey();
    final result = await FilesHelper.createFolder(folderFeature);
    if (!result) {
      return;
    }
    await handleListFolder(folderFeature, _structureFolder);
    if (type == GenerateFeatureType.screen && createRoute) {
      await _handleRoute();
    }
  }

  Future<void> handleListFolder(
      String pathFolder, List<dynamic> listFolder) async {
    for (var item in listFolder) {
      if ('${item['name']}'.isNotEmpty) {
        final folderCurrent = '$pathFolder/${item['name']}';
        final result = await FilesHelper.createFolder(folderCurrent);
        if (!result) {
          continue;
        }

        if (item['files'] != null && (item['files'] as List).isNotEmpty) {
          for (var fileItem in item['files']) {
            final infoFile =
                GenerateFeatureConstants.defineContentsFile[fileItem] ?? {};
            final pathFile =
                _handleString('$folderCurrent/${infoFile['nameFile']}');
            final content = _handleString(infoFile['content'] as String);
            FilesHelper.writeFile(pathFile: pathFile, content: content);
          }
        }

        if (item['subFolder'] != null &&
            (item['subFolder'] as List).isNotEmpty) {
          handleListFolder(
              '$pathFolder/${item['name']}', item['subFolder'] as List);
        }
      }
    }
  }

  void _loadKey() async {
    _keyDefine = [
      {
        'key': '<Generate|NameUpperFirst>',
        'value': name.capitalize,
      },
      {'key': '<Generate|Name>', 'value': name.toLowerCase()},
    ];
  }

  String _handleString(String content) {
    var data = content;

    for (var item in _keyDefine) {
      data = data.replaceAll(item['key'] as String, item['value'] as String);
    }
    return data;
  }

  Future<void> _handleRoute() async {
    final fileRoute = File(FCoreGenConstant.pathRoute);
    final routeIsExist = await fileRoute.exists();
    if (!routeIsExist) {
      return;
    }

    var dataOfRoute = '';
    final routeContent = await fileRoute.readAsString();
    if (routeContent.contains('RouteList.${name.toLowerCase()}') ||
        routeContent.contains('static const String ${name.toLowerCase()} =')) {
      return;
    }

    final indexLastImport = routeContent.indexOf('class');
    dataOfRoute =
        '${routeContent.substring(0, indexLastImport - 1)}$routeImport';

    final indexClassRouteList =
        routeContent.indexOf('class RouteList {') + 'class RouteList {'.length;
    dataOfRoute =
        '$dataOfRoute\n\n${routeContent.substring(indexLastImport, indexClassRouteList)}\n  $routeList';

    final indexFuncgetAll =
        routeContent.indexOf('_getAll(RouteSettings settings) => {') +
            '_getAll(RouteSettings settings) => {'.length;
    dataOfRoute =
        '$dataOfRoute${routeContent.substring(indexClassRouteList, indexFuncgetAll)}\n$routeClass';

    dataOfRoute =
        '$dataOfRoute${routeContent.substring(indexFuncgetAll, routeContent.length)}';

    dataOfRoute = _handleString(dataOfRoute);

    FilesHelper.writeFile(
        pathFile: FCoreGenConstant.pathRoute, content: dataOfRoute);
  }
}
