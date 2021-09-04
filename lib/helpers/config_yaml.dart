import 'dart:io';
import 'package:yaml/yaml.dart';

import '../contracts.dart';
import '../features/generate_fastlane/generate_fastlane_constants.dart';
import 'helpers.dart';

class ConfigYamlHelper {
  static void checkConfig(Map<String, dynamic> config, FCoreGenType type,
      [String platform = 'all']) {
    switch (type) {
      case FCoreGenType.copyright:
        if (!config.containsKey('copyright')) {
          print('Your `fcoregen` section does not contain a `copyright` or '
              '`copyright`.');
          exit(1);
        }

        if (!config.containsKey('extensions')) {
          print('Your `fcoregen` section does not contain a `extensions` or '
              '`extensions`.');
          exit(1);
        }
        break;
      case FCoreGenType.localization:
        if (!config.containsKey('folderLocalization')) {
          print(
              'Your `fcoregen` section does not contain a `folderLocalization` or '
              '`folderLocalization`.');
          exit(1);
        }

        if (!config.containsKey('fileCSV') &&
            !(config.containsKey('fileGoogleSheet') &&
                config['fileGoogleSheet']?.containsKey('docsId') &&
                config['fileGoogleSheet']?.containsKey('sheetId'))) {
          print('Your `fcoregen` section does not contain a `fileCSV` or '
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
          print('Your `fcoregen` section does not contain a `fastlaneIOS` .');
          exit(1);
        } else if (!isExistAndroidConfig && platform == 'android') {
          print(
              'Your `fcoregen` section does not contain a `fastlaneAndroid`.');
          exit(1);
        } else if (!isExistIOSConfig && !isExistAndroidConfig) {
          print('Your `fcoregen` section does not contain a `fastlaneIOS` and '
              '`fastlaneAndroid`.');
          exit(1);
        }

        var messageError = '';
        var countError = 0;

        // validate android
        if (config.containsKey('fastlaneAndroid')) {
          if (!config['fastlaneAndroid'].containsKey('firebaseAppId') ||
              config['fastlaneAndroid']['firebaseAppId'].isEmpty) {
            countError++;
            messageError +=
                "\n $countError. [fastlaneAndroid] > [firebaseAppId]";
          }

          if (!config['fastlaneAndroid'].containsKey('emailTester') ||
              config['fastlaneAndroid']['emailTester'].isEmpty) {
            countError++;
            messageError += "\n $countError. [fastlaneAndroid] > [emailTester]";
          }

          if (!config['fastlaneAndroid'].containsKey('bundleId') ||
              config['fastlaneAndroid']['bundleId'].isEmpty) {
            countError++;
            messageError += "\n $countError. [fastlaneAndroid] > [bundleId]";
          }
        }

        // validate ios
        if (config.containsKey('fastlaneIOS') &&
            config['fastlaneIOS'] != null) {
          if (!config['fastlaneIOS'].containsKey('firebaseAppId') ||
              config['fastlaneIOS']['firebaseAppId'].isEmpty) {
            countError++;
            messageError += "\n $countError. [fastlaneIOS] > [firebaseAppId]";
          }
          if (!config['fastlaneIOS'].containsKey('emailTester') ||
              config['fastlaneIOS']['emailTester'].isEmpty) {
            countError++;
            messageError += "\n $countError. [fastlaneIOS] > [emailTester]";
          }
          if (!config['fastlaneIOS'].containsKey('bundleId') ||
              config['fastlaneIOS']['bundleId'].isEmpty) {
            countError++;
            messageError += "\n $countError. [fastlaneIOS] > [bundleId]";
          }
          if (!config['fastlaneIOS'].containsKey('teamId') ||
              config['fastlaneIOS']['teamId'].isEmpty) {
            countError++;
            messageError += "\n $countError. [fastlaneIOS] > [teamId]";
          }
          if (!config['fastlaneIOS'].containsKey('emailAppleDevelop') ||
              config['fastlaneIOS']['emailAppleDevelop'].isEmpty) {
            countError++;
            messageError +=
                "\n $countError. [fastlaneIOS] > [emailAppleDevelop]";
          }
          if (!config['fastlaneIOS'].containsKey('pathIPA') ||
              config['fastlaneIOS']['pathIPA'].isEmpty) {
            countError++;
            messageError += "\n $countError. [fastlaneIOS] > [pathIPA]";
          }
          if (!config['fastlaneIOS'].containsKey('provisioningAdhoc') ||
              config['fastlaneIOS']['provisioningAdhoc'].isEmpty) {
            countError++;
            messageError +=
                "\n $countError. [fastlaneIOS] > [provisioningAdhoc]";
          }
          if (!config['fastlaneIOS']
                  .containsKey('codeSignIdentifyDistribute') ||
              config['fastlaneIOS']['codeSignIdentifyDistribute'].isEmpty) {
            countError++;
            messageError +=
                "\n $countError. [fastlaneIOS] > [codeSignIdentifyDistribute]";
          }
          if (!config['fastlaneIOS'].containsKey('buildConfiguration') ||
              config['fastlaneIOS']['buildConfiguration'].isEmpty) {
            countError++;
            messageError +=
                "\n $countError. [fastlaneIOS] > [buildConfiguration]";
          }
          if (!config['fastlaneIOS'].containsKey('pathFileExportOption') ||
              config['fastlaneIOS']['pathFileExportOption'].isEmpty) {
            countError++;
            messageError +=
                "\n $countError. [fastlaneIOS] > [pathFileExportOption]";
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

    final Map yamlMap = loadYaml(File(filePath).readAsStringSync());

    if (!(yamlMap['fcoregen'] is Map)) {
      throw Exception('Your `$filePath` file does not contain a '
          '`fcoregen` section.');
    }

    // yamlMap has the type YamlMap, which has several unwanted side effects
    final config = <String, dynamic>{};
    for (MapEntry<dynamic, dynamic> entry in yamlMap['fcoregen'].entries) {
      if (entry.value is YamlList) {
        var list = <String>[];
        (entry.value as YamlList).forEach((dynamic value) {
          if (value is String) {
            list.add(value);
          }
        });
        config[entry.key] = list;
      } else {
        config[entry.key] = entry.value;
      }
    }
    return config;
  }
}
