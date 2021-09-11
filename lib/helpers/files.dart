import 'dart:async';
import 'dart:io';

import '../contracts.dart';

class FilesHelper {
  static Future<bool> createFolder(String folder) async {
    final folderFeature = Directory(folder);
    final checkExist = await folderFeature.exists();
    if (checkExist) {
      printLog('[Error] Folder $folder is exist!');
      return false;
    }

    final create = await folderFeature.create();
    return create.path.isNotEmpty;
  }

  static Future<bool>? writeFile({
    required String pathFile,
    required String content,
    bool isCreateNew = false,
  }) async {
    final runBash = File(pathFile);
    final runBashExists = await runBash.exists();

    if (!runBashExists) {
      runBash.createSync();
    } else if (isCreateNew) {
      runBash.deleteSync();
      runBash.createSync();
    }

    await runBash.writeAsString(content);
    return runBash.path.isNotEmpty;
  }

  static Future<String?>? readFile({required String pathFile}) async {
    final runBash = File(pathFile);
    final runBashExists = await runBash.exists();
    if (!runBashExists) {
      return '';
    }
    final result = await runBash.readAsString();
    return result;
  }

  static Future<List<FileSystemEntity>> dirContents(String path) {
    final dir = Directory(path);
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = dir.list(recursive: false);
    lister.listen((file) => files.add(file),
        // should also register onError
        onDone: () => completer.complete(files));
    return completer.future;
  }
}
