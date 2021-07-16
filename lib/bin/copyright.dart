import '../features/copyright.dart';
import '../helpers/helpers.dart';
import '../contracts.dart';

Future<void> handleCopyRight({String? path, required List<String> args}) async {
  var config = ConfigYamlHelper.getConfig(configFile: path);
  ConfigYamlHelper.checkConfig(config, FCoreGenType.copyright);

  FeatureCopyRight feature = FeatureCopyRight(
    contentUpdate: config['copyright'],
    extensions: config['extensions'],
    scan: config['scan_dir'] ?? <String>[],
    dirCheck: config['dir_update'],
  );

  final isRemove = args.isNotEmpty && args.first == 'remove';
  feature.active(isRemove: isRemove);
}
