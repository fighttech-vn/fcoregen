import 'templates/fastlane_android.dart';
import 'templates/fastlane_ios.dart';

class GenerateFastlaneConstants {
  static const String keyGetConfigIOS = 'fastlaneIOS';
  static const String keyGetConfigAndroid = 'fastlaneAndroid';
  static const String keyPathFileExportOption = 'pathFileExportOption';
  static Map<String, dynamic> scriptBuild = {
    'filename': 'distribution.sh',
    'content': contentAndroidEnv,
    'data': ['firebaseAppId', 'emailTester'],
  };

  static List<Map<String, dynamic>> fastlaneAndroidFile = [
    {
      'filename': '.env.production',
      'content': contentAndroidEnv,
      'data': ['firebaseAppId', 'emailTester'],
    },
    {
      'filename': 'Appfile',
      'content': contentAndroidAppFile,
      'data': ['bundleId'],
    },
    {
      'filename': 'Fastfile',
      'content': contentAndroidFastfile,
    },
    {
      'filename': 'Pluginfile',
      'content': contentAndroidPluginfile,
    },
    {
      'filename': 'README.md',
      'content': contentAndroidReadme,
    }
  ];

  static List<Map<String, dynamic>> fastlaneIOSFile = [
    {
      'filename': '.env.production',
      'content': contentIOSEnv,
      'data': [
        'firebaseAppId',
        'emailTester',
        'bundleId',
        'teamId',
        'teamId',
        'appAppleId',
        'emailAppleDevelop',
        'pathIPA',
        'provisioningAppStore',
        'provisioningAdhoc',
        'codeSignIdentifyDistribute',
        'buildConfiguration'
      ],
    },
    {
      'filename': 'Appfile',
      'content': contentIOSAppFile,
    },
    {
      'filename': 'Fastfile',
      'content': contentIOSFastfile,
    },
    {
      'filename': 'Pluginfile',
      'content': contentIOSPluginfile,
    },
    {
      'filename': 'README.md',
      'content': contentIOSReadme,
    }
  ];

  static const String exampleDocs = '''

####################################
##### Content of fcoregen.yaml #####
fcoregen:
  fastlaneIOS:
    firebaseAppId: "1:630490387268:ios:7c5fd8e49iksj3355246cd"        # required
    emailTester: "exampleaccount@gmail.com"                           # required
    bundleId: "com.example.appmobile"                                 # required
    teamId: "86PCDKI3HF"                                              # required
    appAppleId: "2984875825" 
    emailAppleDevelop: "exampleaccount@gmail.com"                     # required
    pathFileExportOption: "resources/certs/ExportOptions.plist"       # required - root of path is project folder
    pathIPA: "../build/ios/ipa/MyApp.ipa"                             # required - root of path is ios folder
    provisioningAdhoc: "./Profiles/MyApp_Adhoc.mobileprovision"       # required - root of path is ios folder
    provisioningAppStore: "./Profiles/MyApp_AppStore.mobileprovision" #            root of path is ios folder
    codeSignIdentifyDistribute: "iPhone Distribution"                 # required - default:iPhone Distribution
    buildConfiguration: "Release"                                     # required - default:Release
    
  fastlaneAndroid:
    firebaseAppId: "1:630490387268:android:7c5fd8e49iksj3355246cd"    # required
    emailTester: "exampleaccount@gmail.com"                           # required
    bundleId: "com.example.appmobile"                                 # required

####################################
''';
}
