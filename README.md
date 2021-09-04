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

Ex url: https://docs.google.com/spreadsheets/d/1TSE0sP8bnnZQHsC8_vdVzxW21mGhr8il7-zMxvbHikI/edit#gid=0
- docsId: 1TSE0sP8bnnZQHsC8_vdVzxW21mGhr8il7-zMxvbHikI
- sheetId: 0

```

- File yaml:
```
fcoregen:
  folderLocalization: "lib/resources/localizations"
  fileGoogleSheet:
    docsId: "1TSE0sP8bnnZQHsC8_vdVzxW21mGhr8il7-zMxvbHikI"
    sheetId: "0"
```

### genarate language
```
flutter pub run fcoregen:localization
```



## Feature Generate Feature

```
flutter pub run fcoregen:new-feat
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
## call test dart
```
dart test 'test/fcoregen_test.dart'
```

