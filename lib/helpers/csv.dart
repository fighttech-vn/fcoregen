import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

class CSVHelpers {
  static Future<List<List<dynamic>>> readCSV(String path) async {
    final input = File(path).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();

    return fields;
  }
}
