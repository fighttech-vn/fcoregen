import 'dart:io';
import 'dart:async';

import '../contracts.dart';
import '../features/generate_feature/generate_feature.dart';
import '../features/generate_feature/generate_feature_constants.dart';
import '../helpers/helpers.dart';

Future<void> handleGenerateFeature() async {
  var nameFolder;
  var nameFolderParent = '';
  var createRoute = true;

  stdout.write('''Select feature:
1. Create a new screen
2. Create a new page
0. Exit\n >I choose: ''');
  var line = await InputOutputHelper.enterText();
  var valueChoose = 0;
  try {
    valueChoose = int.tryParse('$line') ?? 0;
    if (valueChoose <= 0 && valueChoose >= 2) {
      stdout.write('You have chosen to exit. Goodbye!');
      exit(0);
    }
  } catch (e) {
    stdout.write('You have chosen to exit. Goodbye!');
    exit(0);
  }

  switch (valueChoose) {
    case 1:
      nameFolder = await InputOutputHelper.enterFolderFeature();
      stdout.write(
          'Do you want to create a route for the $nameFolder screen? (y/n)\n');
      var recheck = await InputOutputHelper.enterText();
      if ((recheck?.isEmpty ?? true) || recheck?.toUpperCase() == 'N') {
        createRoute = false;
      }

      break;
    case 2:
      stdout.write(
          'Enter name folder parent (The folder must be available and located in the folder <your-project>/lib/features): ');
      nameFolderParent = (await InputOutputHelper.enterText()) ?? '';
      final dir =
          Directory('${FCoreGenConstant.folderFeatures}/$nameFolderParent');
      final dirExist = await dir.exists();
      if (!dirExist) {
        stdout.write('Sorry, the folder $nameFolderParent is\'nt exists!\n');
        exit(0);
      }
      nameFolderParent = '/$nameFolderParent';
      nameFolder = await InputOutputHelper.enterFolderFeature();

      break;
    default:
  }

  final generateFeature = GenerateFeature(
    folder: '${FCoreGenConstant.folderFeatures}$nameFolderParent',
    name: nameFolder,
    type: nameFolderParent.isNotEmpty
        ? GenerateFeatureType.page
        : GenerateFeatureType.screen,
    createRoute: createRoute,
  );
  await generateFeature.create();
}
