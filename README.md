# fcoregen

Fcore Gen Project

## Use

## Feature Copyright
### add new copyright
```
flutter pub run fcoregen:copyright
```

### remove copyright
```
flutter pub run fcoregen:copyright remove
```

## Feature Localization
### use CSV
- File yaml:

```
fcoregen:
  folderLocalization: "lib/resources/localizations"
  fileCSV: "assets/language/data.csv"
```

### use Google Sheet
- Url Google Sheet: 

```
Format: https://docs.google.com/spreadsheets/d/<docsId>/edit#gid=<sheetId>

Ex url: https://docs.google.com/spreadsheets/d/1ZFgJO0zefRW0BiQMIlUwpOx74CrQjOt48INNvxS80a8/edit#gid=0
- docsId: 1ZFgJO0zefRW0BiQMIlUwpOx74CrQjOt48INNvxS80a8
- sheetId: 0

```

- File yaml:
```
fcoregen:
  folderLocalization: "lib/resources/localizations"
  fileGoogleSheet:
    docsId: "1ZFgJO0zefRW0BiQMIlUwpOx74CrQjOt48INNvxS80a8"
    sheetId: "0"
```

### genarate language
```
flutter pub run fcoregen:localization
```



## Feature Generate Feature

```
flutter pub run fcoregen:newfeat
```

## Feature Generate Fastlane

```
// All Platform
flutter pub run fcoregen:fastlane

// Platform Android
flutter pub run fcoregen:fastlane android

// Platform IOS
flutter pub run fcoregen:fastlane ios
```
Required fastlane.yaml file

```
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
```


## call test dart
```
dart test 'test/fcoregen_test.dart'
```

