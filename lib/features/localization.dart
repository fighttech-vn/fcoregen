import 'dart:convert';
import 'dart:io';

import '../helpers/helpers.dart';

class Localization {
  final String folderSaveLanguage;
  final String internationalizationFile;
  final List<List<dynamic>> dataLanguage;
  //Ex: 'Copyright 2021 Fighttech, Ltd. All right reserved.';
  final String? copyright;

  Localization({
    required this.internationalizationFile,
    required this.folderSaveLanguage,
    required this.dataLanguage,
    this.copyright,
  });

  Future<void> handleLanguage() async {
    final listLang = await _loadLanguages();
    if (listLang.isNotEmpty) {
      for (var item in listLang) {
        if (item['key'] != null && item['translate'] != null) {
          await _createFileLanguage(item['key'] as String,
              Map<String, dynamic>.from(item['translate'] as Map));
          await _importInternationalizationFile(item['key'] as String);
        }
      }
    }
  }

  Future<List<Map<String, dynamic>>> _loadLanguages() async {
    if (dataLanguage.isEmpty) {
      return [];
    }

    final indexID = dataLanguage[0].indexWhere((element) => element == 'id');
    List<Map<String, dynamic>> listLanguages = [];
    for (var i = indexID + 1; i < dataLanguage[0].length; i++) {
      final item = '${dataLanguage[0][i]}';
      if (item.length == 2) {
        var itemMap = {'index': i, 'key': dataLanguage[0][i]};
        listLanguages.add(itemMap);
      }
    }
    for (var i = 1; i < dataLanguage.length; i++) {
      final item = dataLanguage[i];
      for (var ii = 0; ii < listLanguages.length; ii++) {
        final language = listLanguages[ii];
        if (language['translate'] == null) {
          language['translate'] = {};
        }
        language['translate']
            .addAll({'${item[indexID]}': '${item[language['index'] as int]}'});
      }
    }

    return listLanguages;
  }

  Future<void> _createFileLanguage(
      String langCode, Map<String, dynamic> contentLanguage) async {
    var content = jsonEncode(contentLanguage)
        .replaceAll('{', '\t{\n\t')
        .replaceAll('","', '",\n\t"')
        .replaceAll('":"', '": "')
        .replaceAll('}', '\n};\n');
    final infoCopyright =
        (copyright?.isNotEmpty ?? false) ? '// $copyright\n' : '';
    FilesHelper.writeFile(
        pathFile: '$folderSaveLanguage/lang_$langCode.dart',
        content: '''${infoCopyright}part of 'internationalization.dart';

// ignore_for_file: prefer_single_quotes, lines_longer_than_80_chars
const lang${langCode.toUpperCase()} =$content
          ''');
  }

  Future<void> _importInternationalizationFile(String langCode) async {
    final runFile = File(internationalizationFile);
    final runFileExists = await runFile.exists();
    if (!runFileExists) {
      return;
    }
    final result = await runFile.readAsString();

    if (result.isEmpty) {
      return;
    }

    bool hadCode = false;
    const keyFind =
        'static final Map<String, Map<String, dynamic>> translations';
    final indexF = result.indexOf(keyFind);

    final subString01 =
        result.substring(indexF + keyFind.length, result.length);
    final indexFi = subString01.indexOf('{');
    final indeLa = subString01.indexOf(';');

    final subString02 = subString01
        .substring(indexFi + 1, indeLa - 1)
        .replaceAll('\n', '')
        .replaceAll('\t', '')
        .replaceAll(' ', '');

    final array01 = subString02.split('}');

    List<Map<String, dynamic>> listData = [];
    for (var item in array01) {
      final arrayLang = item.split('{');
      final code = arrayLang.first
          .replaceAll('"', '')
          .replaceAll("'", '')
          .replaceAll(',', '')
          .replaceAll(':', '');
      if (code.isNotEmpty) {
        listData.add({'code': code});
        // if (code == langCode) {
        //   hashCode == true;
        // }
        final info = arrayLang.last;
        for (var itemInfo in info.split(',')) {
          if (itemInfo.contains('language')) {
            listData.last['language'] = itemInfo
                .split(':')
                .last
                .replaceAll('"', '')
                .replaceAll(',', '')
                .replaceAll(':', '');
            if (code == langCode &&
                listData.last['language'] == 'lang${langCode.toUpperCase()}') {
              return;
            }
          } else if (itemInfo.contains('timeago')) {
            listData.last['timeago'] = itemInfo
                .split(':')
                .last
                .replaceAll('"', '')
                .replaceAll(',', '')
                .replaceAll(':', '');
          }
        }
      }
    }
    if (!hadCode) {
      listData.add({
        'code': langCode,
        'language': 'lang${langCode.toUpperCase()}',
        'timeago': '${langCode[0].toUpperCase()}${langCode[1]}Messages()'
      });
    }

    Map<String, dynamic> dataImport = {};
    for (var item in listData) {
      dataImport.addAll({
        '${item['code']}': {
          'language': item['language'],
          'timeago': item['timeago'],
        }
      });
    }
    var resultI = jsonEncode(dataImport);
    for (var item in listData) {
      resultI = resultI
          .replaceAll('"${item['code']}"', '\n\t\t"${item['code']}"')
          .replaceAll('"${item['language']}"', '${item['language']}')
          .replaceAll('"${item['timeago']}"', '${item['timeago']}');
    }
    resultI = '{ $resultI';
    resultI = resultI
        .replaceFirst('{', '')
        .replaceAll(':', ': ')
        .replaceAll(',', ', ')
        .replaceAll('}}', '}\n\t};');

    final finalStringStart = result.substring(0, indexF + keyFind.length);

    var firstPart = finalStringStart.indexOf('part');
    final firstClass = finalStringStart.indexOf('class');

    var firstString = finalStringStart;
    if (firstClass > 0 && !finalStringStart.contains('lang_$langCode.dart')) {
      if (firstPart == -1) {
        firstPart = firstClass - 1;
      }
      String partOf = finalStringStart.substring(firstPart, firstClass);
      partOf = "${partOf}part 'lang_$langCode.dart';"
          .replaceAll('\n', '')
          .replaceAll(';', ';\n');

      var topString = finalStringStart.substring(0, firstPart);

      if (topString[topString.length - 1] == '\n') {
        topString = topString.substring(0, topString.length - 1);
      }

      firstString =
          '$topString\n$partOf\n${finalStringStart.substring(firstClass, finalStringStart.length)}';
    }

    final finalStringEnd =
        subString01.substring(indeLa + 1, subString01.length);
    FilesHelper.writeFile(
        pathFile: internationalizationFile,
        content:
            '$firstString =${resultI.replaceAll('"', "'")}$finalStringEnd');
  }
}
