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
## call test dart
```
dart test 'test/fcoregen_test.dart'
```

