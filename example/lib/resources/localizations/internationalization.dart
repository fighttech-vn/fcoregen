// Copyright 2021 Fighttech, Ltd. All right reserved.
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart';

part 'lang_ja.dart';
part 'lang_it.dart';
part 'lang_ru.dart';
part 'lang_ar.dart';

class SLocalizationsDelegate extends LocalizationsDelegate<S> {
  const SLocalizationsDelegate();

  static final Map<String, Map<String, dynamic>> translations = {
    'ja': {'language': langJA, 'timeago': JaMessages()},
    'it': {'language': langIT, 'timeago': ItMessages()},
    'ru': {'language': langRU, 'timeago': RuMessages()},
    'ar': {'language': langAR, 'timeago': ArMessages()},
  };
  @override
  bool isSupported(Locale locale) =>
      translations.keys.contains(locale.languageCode);

  @override
  Future<S> load(Locale locale) async {
    translations.forEach((key, value) {
      timeago.setLocaleMessages(key, value['timeago'] as LookupMessages);
    });
    timeago.setDefaultLocale(locale.languageCode);

    final localeName =
        (locale.countryCode == null || locale.countryCode!.isEmpty)
            ? locale.languageCode
            : locale.toString();

    final localizations = S(localeName);
    localizations.load(locale);
    return localizations;
  }

  @override
  bool shouldReload(SLocalizationsDelegate old) => false;
}

class S {
  S(this.localeName);

  bool load(Locale locale) {
    final Map<String, dynamic> _result = SLocalizationsDelegate
        .translations[locale.languageCode]!['language'] as Map<String, dynamic>;

    _sentences = {};
    _result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });

    return true;
  }

  // ignore: prefer_constructors_over_static_methods
  static S of(BuildContext context) {
    return Localizations.of<S>(context, S) ?? S(null);
  }

  final String? localeName;
  late Map<String, String> _sentences;

  String translate(String key, {List<dynamic>? params = const []}) {
    if (localeName == null) {
      return key;
    }
    return _sentences[key] == null ? key : sprintf(_sentences[key]!, params);
  }
}

extension SFormatCurrency on S {
  String fotmatCurrency(dynamic price) {
    if (localeName == null) {
      return '$price';
    }
    final formatCurrency = NumberFormat.simpleCurrency(locale: localeName);
    return formatCurrency.format(price);
  }
}

extension SFormatTime on S {
  String timeAgo(DateTime dateTime) {
    try {
      return timeago.format(dateTime); // 15 min ago

    } catch (_) {
      return ' ';
    }
  }
}
