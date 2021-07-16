export 'files.dart';
export 'config_yaml.dart';
export 'csv.dart';
export 'google_sheet.dart';
export 'input_output_helper.dart';

import 'package:universal_io/io.dart';

extension StringExt on String {
  String get pathPlatForm => Platform.isWindows ? replaceAll('/', '\\') : this;
  String get capitalize => "${this[0].toUpperCase()}${this.substring(1)}";
}
