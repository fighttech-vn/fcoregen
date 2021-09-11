import '../contracts.dart';
import '../features/generate_fastlane/generate_fastlane.dart';
import '../helpers/helpers.dart';

Future<void> getGenerateFastlaneFeature(
    {String? path, required List<String> args}) async {
  var platform = 'all';
  if (args.isNotEmpty) {
    if (args.first.toLowerCase() == 'ios') {
      platform = 'ios';
    } else if (args.first.toLowerCase() == 'android') {
      platform = 'android';
    }
  }

  var config =
      ConfigYamlHelper.getConfig(configFile: path, type: FCoreGenType.fastlane);
  ConfigYamlHelper.checkConfig(config, FCoreGenType.fastlane, platform);
  final feature = GenerateFastlane(config, platform);
  feature.run();
}
