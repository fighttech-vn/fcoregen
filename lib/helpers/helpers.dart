import 'package:universal_io/io.dart';

export 'config_yaml.dart';
export 'csv.dart';
export 'files.dart';
export 'google_sheet.dart';
export 'input_output_helper.dart';

extension StringExt on String {
  String get pathPlatForm => Platform.isWindows ? replaceAll('/', '\\') : this;
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
}
