// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart' show SynchronousFuture;
// import 'package:flutter/material.dart';
//
// import '/Config/app_config.dart';
// import '/Locale/Languages/german.dart';
// import '/Locale/Languages/romanian.dart';
// import 'Languages/arabic.dart';
// import 'Languages/english.dart';
// import 'Languages/french.dart';
// import 'Languages/indonesian.dart';
// import 'Languages/italian.dart';
// import 'Languages/portuguese.dart';
// import 'Languages/spanish.dart';
// import 'Languages/swahili.dart';
// import 'Languages/turkish.dart';
//
// class AppLocalization {
//   final Locale locale;
//   AppLocalization(this.locale);
//
//   static AppLocalization? of(BuildContext context) {
//     return Localizations.of<AppLocalization>(context, AppLocalization);
//   }
//
//   String getLocalizationFor(String key) {
//     return (AppConfig.languagesSupported[locale.languageCode]!.values[key] !=
//         null
//         ? AppConfig.languagesSupported[locale.languageCode]!.values[key]
//         : AppConfig.languagesSupported[AppConfig.languageDefault]!
//         .values[key] !=
//         null
//         ? AppConfig
//         .languagesSupported[AppConfig.languageDefault]!.values[key]
//         : key)!;
//   }
//
//   static Map<String, Map<String, String>> _localizedValues = {
//     'en': english(),
//     'ar': arabic(),
//     'pt': portuguese(),
//     'fr': french(),
//     'id': indonesian(),
//     'es': spanish(),
//     'it': italian(),
//     'tr': turkish(),
//     'sw': swahili(),
//     "de": german(),
//     "ro": romanian(),
//   };
//
//   String? get fastFood {
//     return AppConfig
//         .languagesSupported[locale.languageCode]!.values['fastFood'];
//   }
//
//   String? get anytimeSoon {
//     return _localizedValues[locale.languageCode]!['anytimeSoon'];
//   }
//
//   String? get served {
//     return _localizedValues[locale.languageCode]!['served'];
//   }
//
//   String? get seaFood {
//     return _localizedValues[locale.languageCode]!['seaFood'];
//   }
//
//   String? get chinesee {
//     return _localizedValues[locale.languageCode]!['chinesee'];
//   }
//
//   String? get dessert {
//     return _localizedValues[locale.languageCode]!['dessert'];
//   }
//
//   String? get tableNo {
//     return _localizedValues[locale.languageCode]!['tableNo'];
//   }
//
//   String? get totalAmount {
//     return _localizedValues[locale.languageCode]!['totalAmount'];
//   }
//
//   String? get finishOrdering {
//     return _localizedValues[locale.languageCode]!['finishOrdering'];
//   }
//
//   String? get searchItem {
//     return _localizedValues[locale.languageCode]!['searchItem'];
//   }
//
//   String? get itemsInCart {
//     return _localizedValues[locale.languageCode]!['itemsInCart'];
//   }
//
//   String? get weMustSay {
//     return _localizedValues[locale.languageCode]!['weMustSay'];
//   }
//
//   String? get youveGreatChoiceOfTaste {
//     return _localizedValues[locale.languageCode]!['youveGreatChoiceOfTaste'];
//   }
//
//   String? get orderConfirmedWith {
//     return _localizedValues[locale.languageCode]!['orderConfirmedWith'];
//   }
//
//   String? get yourOrderWillBeAtYourTable {
//     return _localizedValues[locale.languageCode]!['yourOrderWillBeAtYourTable'];
//   }
//
//   String? get description {
//     return _localizedValues[locale.languageCode]!['description'];
//   }
//
//   String? get knowHowWeCookIt {
//     return _localizedValues[locale.languageCode]!['knowHowWeCookIt'];
//   }
//
//   String? get minVideo {
//     return _localizedValues[locale.languageCode]!['minVideo'];
//   }
//
//   String? get servings {
//     return _localizedValues[locale.languageCode]!['servings'];
//   }
//
//   String? get cookTime {
//     return _localizedValues[locale.languageCode]!['cookTime'];
//   }
//
//   String? get people {
//     return _localizedValues[locale.languageCode]!['people'];
//   }
//
//   String? get mins {
//     return _localizedValues[locale.languageCode]!['mins'];
//   }
//
//   String? get energy {
//     return _localizedValues[locale.languageCode]!['energy'];
//   }
//
//   String? get cal {
//     return _localizedValues[locale.languageCode]!['cal'];
//   }
//
//   String? get ingredients {
//     return _localizedValues[locale.languageCode]!['ingredients'];
//   }
//
//   String? get foodItems {
//     return _localizedValues[locale.languageCode]!['foodItems'];
//   }
//
//   String? get addOptions {
//     return AppConfig
//         .languagesSupported[locale.languageCode]!.values['addOptions'];
//   }
//
//   String? get addToCart {
//     return _localizedValues[locale.languageCode]!['addToCart'];
//   }
//
//   String? get relatedItemsYouMayLike {
//     return _localizedValues[locale.languageCode]!['relatedItemsYouMayLike'];
//   }
//
//   String? get ordered {
//     return _localizedValues[locale.languageCode]!['ordered'];
//   }
//
//   String? get items {
//     return _localizedValues[locale.languageCode]!['items'];
//   }
//
//   String? get table {
//     return _localizedValues[locale.languageCode]!['table'];
//   }
//
//   String? get noOrder {
//     return _localizedValues[locale.languageCode]!['noOrder'];
//   }
//   String? get submit {
//     return _localizedValues[locale.languageCode]!['submit'];
//   }
//
//   static List<Locale> getSupportedLocales() {
//     List<Locale> toReturn = [];
//     for (String langCode in AppConfig.languagesSupported.keys) {
//       toReturn.add(Locale(langCode));
//     }
//     return toReturn;
//   }
// }
//
// class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
//   const AppLocalizationsDelegate();
//
//   @override
//   bool isSupported(Locale locale) =>
//       AppConfig.languagesSupported.keys.contains(locale.languageCode);
//
//   @override
//   Future<AppLocalization> load(Locale locale) {
//     return SynchronousFuture<AppLocalization>(AppLocalization(locale));
//   }
//
//   @override
//   bool shouldReload(AppLocalizationsDelegate old) => false;
// }

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

import '/Config/app_config.dart';
import '/Locale/Languages/german.dart';
import '/Locale/Languages/romanian.dart';
import 'Languages/arabic.dart';
import 'Languages/english.dart';
import 'Languages/french.dart';
import 'Languages/indonesian.dart';
import 'Languages/italian.dart';
import 'Languages/portuguese.dart';
import 'Languages/spanish.dart';
import 'Languages/swahili.dart';
import 'Languages/turkish.dart';

class AppLocalization {
  final Locale locale;
  AppLocalization(this.locale);

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': english(),
    'ar': arabic(),
    'pt': portuguese(),
    'fr': french(),
    'id': indonesian(),
    'es': spanish(),
    'it': italian(),
    'tr': turkish(),
    'sw': swahili(),
    "de": german(),
    "ro": romanian(),
  };

  String? get fastFood {
    return _localizedValues[locale.languageCode]!['fastFood'];
  }

  String? get anytimeSoon {
    return _localizedValues[locale.languageCode]!['anytimeSoon'];
  }

  String? get served {
    return _localizedValues[locale.languageCode]!['served'];
  }

  String? get seaFood {
    return _localizedValues[locale.languageCode]!['seaFood'];
  }

  String? get chinesee {
    return _localizedValues[locale.languageCode]!['chinesee'];
  }

  String? get dessert {
    return _localizedValues[locale.languageCode]!['dessert'];
  }

  String? get tableNo {
    return _localizedValues[locale.languageCode]!['tableNo'];
  }

  String? get totalAmount {
    return _localizedValues[locale.languageCode]!['totalAmount'];
  }

  String? get finishOrdering {
    return _localizedValues[locale.languageCode]!['finishOrdering'];
  }

  String? get searchItem {
    return _localizedValues[locale.languageCode]!['searchItem'];
  }

  String? get itemsInCart {
    return _localizedValues[locale.languageCode]!['itemsInCart'];
  }

  String? get weMustSay {
    return _localizedValues[locale.languageCode]!['weMustSay'];
  }

  String? get youveGreatChoiceOfTaste {
    return _localizedValues[locale.languageCode]!['youveGreatChoiceOfTaste'];
  }

  String? get orderConfirmedWith {
    return _localizedValues[locale.languageCode]!['orderConfirmedWith'];
  }

  String? get yourOrderWillBeAtYourTable {
    return _localizedValues[locale.languageCode]!['yourOrderWillBeAtYourTable'];
  }

  String? get description {
    return _localizedValues[locale.languageCode]!['description'];
  }

  String? get knowHowWeCookIt {
    return _localizedValues[locale.languageCode]!['knowHowWeCookIt'];
  }

  String? get minVideo {
    return _localizedValues[locale.languageCode]!['minVideo'];
  }

  String? get servings {
    return _localizedValues[locale.languageCode]!['servings'];
  }

  String? get cookTime {
    return _localizedValues[locale.languageCode]!['cookTime'];
  }

  String? get people {
    return _localizedValues[locale.languageCode]!['people'];
  }

  String? get mins {
    return _localizedValues[locale.languageCode]!['mins'];
  }

  String? get energy {
    return _localizedValues[locale.languageCode]!['energy'];
  }

  String? get cal {
    return _localizedValues[locale.languageCode]!['cal'];
  }

  String? get ingredients {
    return _localizedValues[locale.languageCode]!['ingredients'];
  }

  String? get foodItems {
    return _localizedValues[locale.languageCode]!['foodItems'];
  }

  String? get addOptions {
    return _localizedValues[locale.languageCode]!['addOptions'];
  }

  String? get addToCart {
    return _localizedValues[locale.languageCode]!['addToCart'];
  }

  String? get relatedItemsYouMayLike {
    return _localizedValues[locale.languageCode]!['relatedItemsYouMayLike'];
  }

  String? get ordered {
    return _localizedValues[locale.languageCode]!['ordered'];
  }

  String? get items {
    return _localizedValues[locale.languageCode]!['items'];
  }

  String? get table {
    return _localizedValues[locale.languageCode]!['table'];
  }

  String? get noOrder {
    return _localizedValues[locale.languageCode]!['noOrder'];
  }

  static List<Locale> getSupportedLocales() {
    List<Locale> toReturn = [];
    for (String langCode in AppConfig.languagesSupported.keys) {
      toReturn.add(Locale(langCode));
    }
    return toReturn;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppConfig.languagesSupported.keys.contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture<AppLocalization>(AppLocalization(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
