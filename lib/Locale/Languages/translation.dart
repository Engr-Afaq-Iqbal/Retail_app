import 'package:get/get.dart';

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

class Translation extends Translations {
  @override
  // TODO: implement keys
  //Map<String, Map<String, String>> get keys => throw UnimplementedError();
  Map<String, Map<String, String>> get keys => {
        'en_US': english(),
        'ar_AR': arabic(),
        'pt_PT': portuguese(),
        'fr_FR': french(),
        'id_ID': indonesian(),
        'es_SP': spanish(),
        'it_IT': italian(),
        'tr_TR': turkish(),
        'sw_SW': swahili(),
        'de_GR': german(),
        'ro_RO': romanian(),
      };
}
