import '../contracts.dart';
import '../features/copyright.dart';
import '../helpers/helpers.dart';

Future<void> handleCopyRight({String? path, required List<String> args}) async {
  var config = ConfigYamlHelper.getConfig(configFile: path);
  ConfigYamlHelper.checkConfig(config, FCoreGenType.copyright);

  FeatureCopyRight feature = FeatureCopyRight(
    contentUpdate: config['copyright'] as String,
    extensions: config['extensions'] as List<String>,
    scan: config['scan_dir'] as List<String>,
    dirCheck: config['dir_update'] as String?,
  );

  final isRemove = args.isNotEmpty && args.first == 'remove';
  feature.active(isRemove: isRemove);
}
