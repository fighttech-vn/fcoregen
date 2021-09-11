import 'dart:io';

import 'package:yaml/yaml.dart';

import '../contracts.dart';

class ConfigYamlHelper {
  static void checkConfig(Map<String, dynamic> config, FCoreGenType type) {
    switch (type) {
      case FCoreGenType.copyright:
        if (!config.containsKey('copyright')) {
          printLog('Your `fcoregen` section does not contain a `copyright` or '
              '`copyright`.');
          exit(1);
        }

        if (!config.containsKey('extensions')) {
          printLog('Your `fcoregen` section does not contain a `extensions` or '
              '`extensions`.');
          exit(1);
        }
        break;
      case FCoreGenType.localization:
        if (!config.containsKey('folderLocalization')) {
          printLog(
              'Your `fcoregen` section does not contain a `folderLocalization` or '
              '`folderLocalization`.');
          exit(1);
        }

        if (!config.containsKey('fileCSV') &&
            !(config.containsKey('fileGoogleSheet') &&
                (config['fileGoogleSheet'] as YamlMap).containsKey('docsId') &&
                (config['fileGoogleSheet'] as YamlMap)
                    .containsKey('sheetId'))) {
          printLog('Your `fcoregen` section does not contain a `fileCSV` or '
              '`fileGoogleSheet`. Please provide fileCSV if you use CSV file to generate language, or provide correct docsId and sheetId information of fileGoogleSheet field if you use Google Sheet to generate language.');
          exit(1);
        }
        break;
      default:
    }
  }

  static Map<String, dynamic> getConfig({String? configFile}) {
    // if `fcoregen.yaml` exists use it as config file, otherwise use `pubspec.yaml`
    String filePath;
    if (configFile != null && File(configFile).existsSync()) {
      filePath = configFile;
    } else if (File('fcoregen.yaml').existsSync()) {
      filePath = 'fcoregen.yaml';
    } else {
      filePath = 'pubspec.yaml';
    }

    final yamlMap = loadYaml(File(filePath).readAsStringSync()) as Map;

    if (yamlMap['fcoregen'] is! Map) {
      throw Exception('Your `$filePath` file does not contain a '
          '`fcoregen` section.');
    }

    // yamlMap has the type YamlMap, which has several unwanted side effects
    final config = <String, dynamic>{};
    for (MapEntry<dynamic, dynamic> entry in yamlMap['fcoregen'].entries) {
      if (entry.value is YamlList) {
        var list = <String>[];
        for (var value in (entry.value as YamlList)) {
          if (value is String) {
            list.add(value);
          }
        }
        config[entry.key as String] = list;
      } else {
        config[entry.key as String] = entry.value;
      }
    }
    return config;
  }
}
