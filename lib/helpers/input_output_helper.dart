import 'dart:convert';

import 'dart:io';

import '../contracts.dart';

class InputOutputHelper {
  static Future<String> enterFolderFeature() async {
    var nameFolder = await enterNameFolder();
    while (nameFolder?.isEmpty ?? true) {
      var recheck = await enterText('Do you want to continue? (y/n)\n');
      if ((recheck?.isEmpty ?? true) || recheck?.toUpperCase() == 'N') {
        stdout.write('You have chosen to exit. Goodbye!\n');
        exit(0);
      }
      nameFolder = await enterNameFolder();
    }
    return nameFolder!;
  }

  static Future<String?> enterText(String message) async {
    stdout.write('\n$message');
    var text = await stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);
    return text;
  }

  static Future<String?> enterNameFolder({bool isScreen = true}) async {
    var screenName =
        await enterText('Enter ${isScreen ? 'screen' : 'page'} name: ');
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
