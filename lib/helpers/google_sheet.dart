import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'dart:async';
import 'dart:convert';

class GoogleSheetHelpers {
  static Future<List<List<dynamic>>> downloadGoogleSheet(
      String documentId, String sheetId) async {
    final url =
        'https://docs.google.com/spreadsheets/d/$documentId/export?format=csv&id=$documentId&gid=$sheetId';

    print('Downloading csv from Google sheet url "$url" ...');

    var response = await http
        .get(Uri.parse(url), headers: {'accept': 'text/csv;charset=UTF-8'});

    final bytes = response.bodyBytes.toList();
    final csv = Stream<List<int>>.fromIterable([bytes]);
    final rows = await csv
        .transform(utf8.decoder)
        .transform(CsvToListConverter(
          shouldParseNumbers: false,
        ))
        .toList();
    return rows;
  }
}
