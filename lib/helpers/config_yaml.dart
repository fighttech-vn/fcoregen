import 'dart:io';
import 'package:yaml/yaml.dart';

import '../contracts.dart';
import '../features/generate_fastlane/generate_fastlane_constants.dart';

class ConfigYamlHelper {
  static void checkConfig(Map<String, dynamic> config, FCoreGenType type,
      [String platform = 'all']) {
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

      case FCoreGenType.fastlane:
        final isExistIOSConfig =
            config.containsKey('fastlaneIOS') && config['fastlaneIOS'] != null;
        final isExistAndroidConfig = config.containsKey('fastlaneAndroid') &&
            config['fastlaneAndroid'] != null;

        if (!isExistIOSConfig && platform == 'ios') {
          printLog(
              'Your `fcoregen` section does not contain a `fastlaneIOS` .');
          exit(1);
        } else if (!isExistAndroidConfig && platform == 'android') {
          printLog(
              'Your `fcoregen` section does not contain a `fastlaneAndroid`.');
          exit(1);
        } else if (!isExistIOSConfig && !isExistAndroidConfig) {
          printLog(
              'Your `fcoregen` section does not contain a `fastlaneIOS` and '
              '`fastlaneAndroid`.');
          exit(1);
        }

        var messageError = '';
        var countError = 0;

        // validate android
        if (config.containsKey('fastlaneAndroid')) {
          final configAndroid = config['fastlaneAndroid'] as YamlMap;
          if (!configAndroid.containsKey('firebaseAppId') ||
              (configAndroid['firebaseAppId'] as String).isEmpty) {
            countError++;
            messageError +=
                '\n $countError. [fastlaneAndroid] > [firebaseAppId]';
          }

          if (!configAndroid.containsKey('emailTester') ||
              (configAndroid['emailTester'] as String).isEmpty) {
            countError++;
            messageError += '\n $countError. [fastlaneAndroid] > [emailTester]';
          }

          if (!configAndroid.containsKey('bundleId') ||
              (configAndroid['bundleId'] as String).isEmpty) {
            countError++;
            messageError += '\n $countError. [fastlaneAndroid] > [bundleId]';
          }
        }

        // validate ios
        if (config.containsKey('fastlaneIOS') &&
            config['fastlaneIOS'] != null) {
          final configIOS = config['fastlaneIOS'] as YamlMap;
          if (!configIOS.containsKey('firebaseAppId') ||
              (configIOS['firebaseAppId'] as String).isEmpty) {
            countError++;
            messageError += '\n $countError. [fastlaneIOS] > [firebaseAppId]';
          }
          if (!configIOS.containsKey('emailTester') ||
              (configIOS['emailTester'] as List<String>).isEmpty) {
            countError++;
            messageError += '\n $countError. [fastlaneIOS] > [emailTester]';
          }
          if (!configIOS.containsKey('bundleId') ||
              (configIOS['bundleId'] as String).isEmpty) {
            countError++;
            messageError += '\n $countError. [fastlaneIOS] > [bundleId]';
          }
          if (!configIOS.containsKey('teamId') ||
              (configIOS['teamId'] as String).isEmpty) {
            countError++;
            messageError += '\n $countError. [fastlaneIOS] > [teamId]';
          }
          if (!configIOS.containsKey('emailAppleDevelop') ||
              (configIOS['emailAppleDevelop'] as String).isEmpty) {
            countError++;
            messageError +=
                '\n $countError. [fastlaneIOS] > [emailAppleDevelop]';
          }
          if (!configIOS.containsKey('pathIPA') ||
              (configIOS['pathIPA'] as String).isEmpty) {
            countError++;
            messageError += '\n $countError. [fastlaneIOS] > [pathIPA]';
          }
          if (!configIOS.containsKey('provisioningAdhoc') ||
              (configIOS['provisioningAdhoc'] as String).isEmpty) {
            countError++;
            messageError +=
                '\n $countError. [fastlaneIOS] > [provisioningAdhoc]';
          }
          if (!configIOS.containsKey('codeSignIdentifyDistribute') ||
              (configIOS['codeSignIdentifyDistribute'] as String).isEmpty) {
            countError++;
            messageError +=
                '\n $countError. [fastlaneIOS] > [codeSignIdentifyDistribute]';
          }
          if (!configIOS.containsKey('buildConfiguration') ||
              (configIOS['buildConfiguration'] as String).isEmpty) {
            countError++;
            messageError +=
                '\n $countError. [fastlaneIOS] > [buildConfiguration]';
          }
          if (!configIOS.containsKey('pathFileExportOption') ||
              (configIOS['pathFileExportOption'] as String).isEmpty) {
            countError++;
            messageError +=
                '\n $countError. [fastlaneIOS] > [pathFileExportOption]';
          }
        }

        if (messageError.isNotEmpty) {
          printLog('######## List of missing data ########');
          printLog(messageError);
          printLog('######################################');
          printLog(GenerateFastlaneConstants.exampleDocs);
          exit(1);
        }
        break;
      default:
    }
  }

  static Map<String, dynamic> getConfig(
      {String? configFile, FCoreGenType? type}) {
    // if `fcoregen.yaml` exists use it as config file, otherwise use `pubspec.yaml`
    String filePath = 'fcoregen.yaml';

    if (type != null && type == FCoreGenType.fastlane) {
      filePath = 'fastlane.yaml';
    } else {
      if (configFile != null && File(configFile).existsSync()) {
        filePath = configFile;
      } else if (!File(filePath).existsSync()) {
        filePath = 'pubspec.yaml';
      }
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
