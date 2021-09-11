import 'dart:convert';

import 'dart:io';

import '../contracts.dart';

class InputOutputHelper {
  static Future<String> enterFolderFeature() async {
    var nameFolder = await enterNameFolder();
    while (nameFolder?.isEmpty ?? true) {
      stdout.write('Do you want to continue? (y/n)\n');
      var recheck = await enterText();
      if ((recheck?.isEmpty ?? true) || recheck?.toUpperCase() == 'N') {
        stdout.write('You have chosen to exit. Goodbye!\n');
        exit(0);
      }
      nameFolder = await enterNameFolder();
    }
    return nameFolder!;
  }

  static Future<String?> enterText() async {
    var text = stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);
    return text;
  }

  static Future<String?> enterNameFolder({bool isScreen = true}) async {
    stdout.write('Enter ${isScreen ? 'screen' : 'page'} name: ');
    var screenName = await enterText();
    final dir = Directory('${FCoreGenConstant.folderFeatures}/$screenName');
    final dirExist = await dir.exists();
    if (dirExist) {
      stdout.write(
          'Sorry, the folder you want to create already exists, please delete the old folder or choose another name.\n');
      return null;
    }
    return screenName;
  }
}
