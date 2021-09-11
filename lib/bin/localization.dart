import 'dart:io';

import '../contracts.dart';
import '../features/localization.dart';
import '../helpers/helpers.dart';

Future<void> handleLocalization(
    {String? path, required List<String> args}) async {
  printLog('Checking data...');
  var config = ConfigYamlHelper.getConfig(configFile: path);
  ConfigYamlHelper.checkConfig(config, FCoreGenType.localization);

  final folderLocalization = config['folderLocalization'];
  var copyright = '';
  if (config['copyright'] != null &&
      (config['copyright'] as String).isNotEmpty) {
    copyright = config['copyright'] as String;
  }

  printLog(copyright);
  var dataLanguage = <List<dynamic>>[];
  if (config['fileCSV'] != null && (config['fileCSV'] as String).isNotEmpty) {
    printLog('Read data from file CSV...');
    dataLanguage = await CSVHelpers.readCSV(config['fileCSV'] as String);
  } else if (config['fileGoogleSheet'] != null &&
      (config['fileGoogleSheet'] as Map).isNotEmpty) {
    dataLanguage = await GoogleSheetHelpers.downloadGoogleSheet(
        config['fileGoogleSheet']['docsId'] as String,
        config['fileGoogleSheet']['sheetId'] as String);
  }

  final dir = Directory(folderLocalization as String);
  if (!(await dir.exists())) {
    printLog(
        '`fcoregen` not found folder $folderLocalization, please try again.');
    exit(1);
  }

  if (dataLanguage.isEmpty) {
    printLog('`fcoregen` load data is failed, please check data again.');
    exit(1);
  }
  printLog('Start handle data...');
  Localization localization = Localization(
    folderSaveLanguage: folderLocalization,
    internationalizationFile: '$folderLocalization/internationalization.dart',
    dataLanguage: dataLanguage,
    copyright: copyright,
  );
  await localization.handleLanguage();
  printLog('Handle localization done!');
}
