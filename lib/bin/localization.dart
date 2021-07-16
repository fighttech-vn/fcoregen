import 'dart:io';

import '../features/localization.dart';
import '../helpers/helpers.dart';
import '../contracts.dart';

Future<void> handleLocalization(
    {String? path, required List<String> args}) async {
  print("Checking data...");
  var config = ConfigYamlHelper.getConfig(configFile: path);
  ConfigYamlHelper.checkConfig(config, FCoreGenType.localization);

  final folderLocalization = config['folderLocalization'];
  var copyright = '';
  if (config['copyright']?.isNotEmpty ?? false) {
    copyright = config['copyright'];
  }

  print(copyright);
  var dataLanguage;
  if (config['fileCSV']?.isNotEmpty ?? false) {
    print("Read data from file CSV...");
    dataLanguage = await CSVHelpers.readCSV(config['fileCSV']);
  } else if ((config['fileGoogleSheet']?.isNotEmpty ?? false)) {
    dataLanguage = await GoogleSheetHelpers.downloadGoogleSheet(
        config['fileGoogleSheet']['docsId'],
        config['fileGoogleSheet']['sheetId']);
  }

  final dir = Directory(folderLocalization);
  if (!(await dir.exists())) {
    print('`fcoregen` not found folder $folderLocalization, please try again.');
    exit(1);
  }
  if (dataLanguage?.isEmpty ?? true) {
    print('`fcoregen` load data is failed, please check data again.');
    exit(1);
  }
  print("Start handle data...");
  Localization localization = Localization(
    folderSaveLanguage: folderLocalization,
    internationalizationFile: '$folderLocalization/internationalization.dart',
    dataLanguage: dataLanguage,
    copyright: copyright,
  );
  await localization.handleLanguage();
  print("Handle localization done!");
}
