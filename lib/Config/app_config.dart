import '/Locale/Languages/arabic.dart';
import '/Locale/Languages/english.dart';
import '/Locale/Languages/french.dart';
import '/Locale/Languages/german.dart';
import '/Locale/Languages/indonesian.dart';
import '/Locale/Languages/italian.dart';
import '/Locale/Languages/portuguese.dart';
import '/Locale/Languages/romanian.dart';
import '/Locale/Languages/spanish.dart';
import '/Locale/Languages/swahili.dart';
import '/Locale/Languages/turkish.dart';
import '/Models/AppLanguageModel.dart';

class AppConfig {
  static final String appName = "BizModo Retail";

  // // to get the token
  static String clientId = "8";
  static String clientSecret = "vq0BFIMp8w2aQAZsrhtLm9Wnl7TXxde9Va3W9uWj";

  // api base url
  static String baseUrl = "https://manage.bizmodo.ae/";
  // static String socketBaseUrl = "https://manage.bizmodo.ae:8006";
  static String socketBaseUrl = "https://manage.bizmodo.ae:8008";

  static String grantType = "password";
  static String scope = "";

  /// For AE
  // Client Access Token & ID
  // static String clientId = "8";
  // static String clientSecret = "vq0BFIMp8w2aQAZsrhtLm9Wnl7TXxde9Va3W9uWj";
  // // API base url
  // static String baseUrl = "https://manage.bizmodo.ae/";
  // static String socketBaseUrl = "https://manage.bizmodo.ae:8008";

  /// For IO
  // // Client Access Token & ID
  // static String clientId = "11";
  // static String clientSecret = "6nRy0lz57qx4NaGEdVypPO2JlM5NyDUeizQcz9Mc";
  // // API base url
  // static String baseUrl = "https://manage.bizmodo.io/";
  // static String socketBaseUrl = "https://manage.bizmodo.io:8006";

  // static final bool isDemoMode = true;
  static final bool isDemoMode = false;

  static String supportNumber = "+971504059006";

  // language
  static const String languageDefault = "en";
  static final Map<String, AppLanguage> languagesSupported = {
    "en": AppLanguage("English", english()),
    "ar": AppLanguage("عربى", arabic()),
    "pt": AppLanguage("Portugal", portuguese()),
    "fr": AppLanguage("Français", french()),
    "id": AppLanguage("Bahasa Indonesia", indonesian()),
    "es": AppLanguage("Español", spanish()),
    "it": AppLanguage("italiano", italian()),
    "tr": AppLanguage("Türk", turkish()),
    "sw": AppLanguage("Kiswahili", swahili()),
    "de": AppLanguage("Deutsch", german()),
    "ro": AppLanguage("Română", romanian()),
  };
}
