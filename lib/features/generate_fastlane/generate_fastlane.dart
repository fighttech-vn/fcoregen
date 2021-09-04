import 'package:fcoregen/features/generate_fastlane/generate_fastlane_constants.dart';
import 'package:fcoregen/features/generate_fastlane/templates/fastlane_android.dart';
import 'package:fcoregen/features/generate_fastlane/templates/fastlane_ios.dart';
import 'package:fcoregen/helpers/helpers.dart';
import 'package:universal_io/io.dart';

class GenerateFastlane {
  late Map<String, dynamic> _config;
  late String _platform;

  GenerateFastlane(Map<String, dynamic> config, String platform)
      : _config = Map<String, dynamic>.from(config),
        _platform = platform;

  Map<String, dynamic> getDataPlatform(String platform) {
    if (platform.toLowerCase() == 'ios') {
      return Map<String, dynamic>.from(
          _config[GenerateFastlaneConstants.keyGetConfigIOS]);
    } else if (platform.toLowerCase() == 'android') {
      return Map<String, dynamic>.from(
          _config[GenerateFastlaneConstants.keyGetConfigAndroid]);
    }
    return {};
  }

  Future<void> createScript(String platform) async {
    var contentFile = '''
#!/bin/bash
set -e
''';
    switch (_platform) {
      case 'ios':
        contentFile +=
            '$scriptBuildIOS \necho "Deploy firebase Android Done !!!"';
        break;
      case 'android':
        contentFile +=
            '$scriptBuildAndroid\n echo "Deploy firebase Android Done !!!"';
        break;
      default:
        contentFile += scriptBuildAndroid;
        contentFile +=
            'cd ..\n$scriptBuildIOS\n echo "Deploy firebase Android & iOS Done !!!"';
    }
    final configWithPlatform = getDataPlatform('ios');
    contentFile = contentFile.replaceAll(
        GenerateFastlaneConstants.keyPathFileExportOption,
        configWithPlatform[GenerateFastlaneConstants.keyPathFileExportOption]);

    await FilesHelper.writeFile(
        pathFile: './distribution.sh', content: contentFile);
  }

  Future<void> run() async {
    switch (_platform) {
      case 'ios':
        await generateFastlane(_platform);
        break;
      case 'android':
        await generateFastlane(_platform);
        break;
      default:
        await generateFastlane('ios');
        await generateFastlane('android');
    }
    await createScript(_platform);
  }

  Future<void> generateFastlane(String platform) async {
    await checkAndBackupFolder(platform);

    final folderParent = '$platform/fastlane';
    await FilesHelper.createFolder(folderParent);
    final configWithPlatform = getDataPlatform(platform);
    final infoFile = platform == 'ios'
        ? GenerateFastlaneConstants.fastlaneIOSFile
        : GenerateFastlaneConstants.fastlaneAndroidFile;

    for (var file in infoFile) {
      var content = '${file['content']}';
      if (file['data'] != null &&
          (file['data'] is List) &&
          file['data'].isNotEmpty) {
        for (var data in file['data']) {
          if (configWithPlatform[data] != null) {
            content = content.replaceAll(data, configWithPlatform[data]);
          }
        }
      }

      var pathFile = '$folderParent/${file['filename']}';
      await FilesHelper.writeFile(pathFile: pathFile, content: content);
    }
  }

  Future<void> checkAndBackupFolder(String folder) async {
    final dir = Directory('$folder/fastlane');
    final isExistDir = await dir.exists();
    if (isExistDir) {
      final isBackup = await InputOutputHelper.enterText(
          'Found fastlane folder in $folder folder, this fastlane folder will be deleted. \nDo you want to backup this fastlane folder? (y/n): ');
      if (isBackup?.toLowerCase() == 'y') {
        await Process.run(
            'cp', ['-R', '$folder/fastlane', '$folder/fastlane_backup']);
      }
      await Process.run('rm', ['-rf', '$folder/fastlane']);
    }
  }
}
