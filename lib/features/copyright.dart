import 'dart:io';

import '../contracts.dart';
import '../helpers/helpers.dart';

class FeatureCopyRight {
  //Ex: ['modules', 'submodules', 'submodule', 'module'];
  final List<String>? scan;

  //Ex: 'lib';
  final String? dirCheck;

  var _dirCheck = 'lib';

  //Ex: ['dart'];
  final List<String> extensions;

  //Ex: 'Copyright 2021 QSoft, Ltd. All right reserved.';
  final String contentUpdate;

  int _count = 0;
  bool _isRemove = false;

  FeatureCopyRight({
    this.scan,
    this.dirCheck,
    required this.extensions,
    required this.contentUpdate,
  }) {
    _dirCheck = dirCheck ?? 'lib';
  }

  Future<int> active({bool isRemove = false, String dirScan = './'}) async {
    _isRemove = isRemove;
    _count = 0;
    _validate();
    await _scanObject(dirScan, '_Directory');
    printLog('Successfully updated $_count files.');
    return _count;
  }

  void _validate() {
    if (extensions.isEmpty) {
      printLog('Please do not leave the file extension empty');
      exit(1);
    }

    if (contentUpdate.isEmpty) {
      printLog('Please enter the information Copyright');
      exit(1);
    }
  }

  Future<void> _scanObject(String path, String type,
      {int level = 0, bool scanFull = false}) async {
    final dirContent = await FilesHelper.dirContents(path);
    for (var item in dirContent) {
      if ('${item.runtimeType}' == '_Directory') {
        if (_dirCheck.contains(item.path.split('/'.pathPlatForm).last)) {
          await _updateObject(item.path, '${item.runtimeType}');
        } else if (scanFull ||
            ((scan?.contains(item.path.split('/'.pathPlatForm).last)) ??
                false)) {
          await _scanObject(item.path, '${item.runtimeType}',
              level: level + 1, scanFull: scanFull ? false : true);
        }
      }
    }
  }

  Future<void> _updateObject(String path, String type) async {
    if (type == '_Directory') {
      final dirContent = await FilesHelper.dirContents(path);
      for (var item in dirContent) {
        if ('${item.runtimeType}' == '_Directory') {
          await _updateObject(item.path, '${item.runtimeType}');
        } else if (extensions
            .contains(item.path.pathPlatForm.split('.').last)) {
          if (_isRemove) {
            await _handleRemove(item.path);
          } else {
            await _handleAdd(item.path);
          }
        }
      }
    }
  }

  Future<void> _handleAdd(String path) async {
    final file = File(path);
    final data = file.readAsLinesSync();
    if (data.isEmpty || !data.first.contains(contentUpdate)) {
      final dataFile = file.readAsStringSync();
      file.writeAsStringSync('// $contentUpdate\n');
      file.writeAsStringSync(dataFile, mode: FileMode.append);
      printLog('Successfully updated the file $path');
      _count++;
    }
  }

  Future<void> _handleRemove(String path) async {
    final file = File(path);
    final data = file.readAsLinesSync();
    var isRemoved = false;
    if (data.isNotEmpty) {
      var readLine = file.readAsLinesSync();
      if (readLine.isNotEmpty) {
        readLine.removeWhere((ele) {
          if (ele.replaceAll(' ', '') ==
              '//$contentUpdate'.replaceAll(' ', '')) {
            isRemoved = true;
            return true;
          }
          return false;
        });

        if (isRemoved) {
          file.writeAsStringSync(readLine.isEmpty ? '' : readLine[0]);
          for (var i = 0; i < readLine.length; i++) {
            if (i != 0) {
              final dataWrite = readLine[i];
              file.writeAsStringSync('\n$dataWrite', mode: FileMode.append);
            }
          }
          printLog('Successfully remove the file $path');
          _count++;
        }
      }
    }
  }
}
