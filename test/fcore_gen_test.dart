import 'dart:io';

import 'package:fcoregen/features/copyright.dart';
import 'package:fcoregen/helpers/helpers.dart';
import 'package:path/path.dart';
import 'package:test/test.dart';

void main() {
  final testDir = join('.dart_tool', 'fcoregen', 'test', 'config_file');

  String? currentDirectory;
  void setCurrentDirectory(String path) {
    path = join(testDir, path);
    Directory(path).createSync(recursive: true);
    Directory.current = path;
  }

  setUp(() {
    currentDirectory = Directory.current.path;
  });
  tearDown(() {
    Directory.current = currentDirectory;
  });

  group('Handle config file from yaml', () {
    test('Default config', () {
      // Given
      const yamlDefaultConfig = '''
fcoregen:
  scan_dir:
    - plugins
  dir_update: lib
  extensions: 
    - dart
  copyright: "Copyright 2021 Fighttech, Ltd. All right reserved."
''';
      setCurrentDirectory('default');
      File('fcoregen_test.yaml').writeAsStringSync(yamlDefaultConfig);

      // When
      final Map<String, dynamic>? config =
          ConfigYamlHelper.getConfig(configFile: 'fcoregen_test.yaml');
      File('fcoregen_test.yaml').deleteSync();

      // Then
      expect(config, isNotNull);
      expect(config!['scan_dir'], isNotNull);
      expect(config['extensions'], isNotNull);
      expect(config['dir_update'], 'lib');
      expect(config['copyright'],
          'Copyright 2021 Fighttech, Ltd. All right reserved.');
    });

    test('Missing Optional Config', () {
      // Given
      const yamlMissingOptionalConfig = '''
fcoregen:
  scan_dir:
    - plugins
  extensions: 
    - dart
  copyright: "Copyright 2021 Fighttech, Ltd. All right reserved."
''';
      setCurrentDirectory('default');
      File('fcoregen_test.yaml').writeAsStringSync(yamlMissingOptionalConfig);

      // When
      final Map<String, dynamic>? config =
          ConfigYamlHelper.getConfig(configFile: 'fcoregen_test.yaml');
      File('fcoregen_test.yaml').deleteSync();

      // Then
      expect(config, isNotNull);
      expect(config!['scan_dir'], isNotNull);
      expect(config['extensions'], isNotNull);
      expect(config['dir_update'], isNull);
      expect(config['copyright'],
          'Copyright 2021 Fighttech, Ltd. All right reserved.');
    });

    test('Missing Config', () {
      // Given
      const yamlMissingCopyrightConfig = '''
fcoregen:
  scan_dir:
    - plugins
  dir_update: lib
''';
      setCurrentDirectory('default');
      File('fcoregen_test.yaml').writeAsStringSync(yamlMissingCopyrightConfig);

      // When
      final Map<String, dynamic>? config =
          ConfigYamlHelper.getConfig(configFile: 'fcoregen_test.yaml');
      File('fcoregen_test.yaml').deleteSync();

      // Then
      expect(config, isNotNull);
      expect(config!['scan_dir'], isNotNull);
      expect(config['dir_update'], isNotNull);
      expect(config['extensions'], isNull);
      expect(config['copyright'], isNull);
    });
  });

  group('Active handle Copyright', () {
    test('Add Copyright success', () async {
      // Given
      const yamlDefaultConfig = '''
fcoregen:
  scan_dir:
    - plugins
  dir_update: lib
  extensions: 
    - dart
  copyright: "Copyright 2021 Fighttech, Ltd. All right reserved."
''';
      setCurrentDirectory('default/lib');
      File('../fcoregen_test.yaml').writeAsStringSync(yamlDefaultConfig);
      File('file01.dart').writeAsStringSync('');
      File('file02.dart').writeAsStringSync(
          '//Copyright 2021 Fighttech, Ltd. All right reserved.');

      // When
      final Map<String, dynamic>? config =
          ConfigYamlHelper.getConfig(configFile: '../fcoregen_test.yaml');
      FeatureCopyRight feature = FeatureCopyRight(
        contentUpdate: config!['copyright'] as String,
        extensions: config['extensions'] as List<String>,
        scan: (config['scan_dir'] ?? <String>[]) as List<String>,
        dirCheck: config['dir_update'] as String,
      );

      final result = await feature.active(dirScan: '../');
      File('../fcoregen_test.yaml').deleteSync();
      File('file01.dart').deleteSync();
      File('file02.dart').deleteSync();

      // Then
      expect(config, isNotNull);
      expect(result, 1);
    });

    test('Remove Copyright success', () async {
      // Given
      const yamlDefaultConfig = '''
fcoregen:
  scan_dir:
    - plugins
  dir_update: lib
  extensions: 
    - dart
  copyright: "Copyright 2021 Fighttech, Ltd. All right reserved."
''';
      setCurrentDirectory('default/lib');
      File('../fcoregen_test.yaml').writeAsStringSync(yamlDefaultConfig);
      File('file01.dart').writeAsStringSync('');
      File('file02.dart').writeAsStringSync(
          '// Copyright 2021 Fighttech, Ltd. All right reserved.');

      // When
      const isRemove = true;
      final Map<String, dynamic>? config =
          ConfigYamlHelper.getConfig(configFile: '../fcoregen_test.yaml');
      FeatureCopyRight feature = FeatureCopyRight(
        contentUpdate: config!['copyright'] as String,
        extensions: config['extensions'] as List<String>,
        scan: (config['scan_dir'] ?? <String>[]) as List<String>,
        dirCheck: config['dir_update'] as String,
      );

      final result = await feature.active(dirScan: '../', isRemove: isRemove);
      File('../fcoregen_test.yaml').deleteSync();
      File('file01.dart').deleteSync();
      File('file02.dart').deleteSync();

      // Then
      expect(result, 1);
    });
  });
}
