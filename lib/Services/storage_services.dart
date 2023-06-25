import 'package:get_storage/get_storage.dart';

import '/Models/AuthModels/loggged_in_user_detail.dart';
import '/Models/AuthModels/o_auth_model.dart';
import '/Models/ProductsModel/all_products_model.dart';
import '/Models/TableManagementModel/table_management_model.dart';
import '/Models/business_n_register/BusinessModel.dart';
import '/Models/order_type_model/order_service_model.dart';

class AppStorage {
  static final box = GetStorage();

  static String _retailLangStorageKey = "Lang";
  static String _retailTokenStorageKey = "token";
  static String _retailLoggedUserDataStorageKey = "loggedUserData";
  static String _retailBusinessDetailDataStorageKey = "businessDetailData";
  static String _retailTableDataStorageKey = "tableCount";
  static String _retailPrinterDataStorageKey = "printers";
  static String _retailProductsStorageKey = "products";
  static String _retailOrderTypesStorageKey = "orderTypes";

  static Future<void> _write(String key, dynamic value) async {
    await box.write(key, value);
  }

  // static _read(String key) {
  //   return box.read(key);
  // }

  static bool _storageHasData(String key) {
    return AppStorage.box.hasData(key);
  }

  /// Localization
  static isStorageHasLocalizationData() =>
      _storageHasData(AppStorage._retailLangStorageKey);

  static setLocalizationData(String? _res) async =>
      await AppStorage._write(AppStorage._retailLangStorageKey, _res);

  static OauthModel? getLocalizationData() {
    try {
      return oauthModelFromJson(box.read(_retailLangStorageKey));
    } catch (e) {
      return null;
    }
  }

  /// User Access Token Storage
  static isStorageHasUserToken() =>
      _storageHasData(AppStorage._retailTokenStorageKey);

  static setUserToken(String _res) async =>
      await AppStorage._write(AppStorage._retailTokenStorageKey, _res);

  static OauthModel? getUserToken() {
    try {
      return oauthModelFromJson(box.read(_retailTokenStorageKey));
    } catch (e) {
      return null;
    }
  }

  /// Logged User Storage
  static isStorageHasLoggedUserData() =>
      _storageHasData(AppStorage._retailLoggedUserDataStorageKey);

  static setLoggedUserData(String _res) async =>
      await AppStorage._write(AppStorage._retailLoggedUserDataStorageKey, _res);

  static LoggedInUserDetail? getLoggedUserData() {
    try {
      String? storedLoginUserData = box.read(_retailLoggedUserDataStorageKey);
      if (storedLoginUserData == null) return null;

      return loggedInUserDetailFromJson(storedLoginUserData);
    } catch (e) {
      return null;
    }
  }

  /// Business Storage
  static isStorageHasBusinessDetails() =>
      _storageHasData(AppStorage._retailBusinessDetailDataStorageKey);

  static setBusinessDetails(String _res) async => await AppStorage._write(
      AppStorage._retailBusinessDetailDataStorageKey, _res);

  static BusinessModel? getBusinessDetailsData() {
    try {
      String? storedBusinessDetails =
          box.read(_retailBusinessDetailDataStorageKey);
      if (storedBusinessDetails == null) return null;

      return businessModelFromJson(storedBusinessDetails);
    } catch (_e) {
      return null;
    }
  }

  /// Order Service Storage
  static isStorageHasOrderServiceTypes() =>
      _storageHasData(AppStorage._retailOrderTypesStorageKey);

  static Future setOrderServiceTypes(String _res) async =>
      await AppStorage._write(AppStorage._retailOrderTypesStorageKey, _res);

  static OrderServiceModel? getOrderServiceData({String? res}) {
    try {
      return orderServiceModelFromJson(
          res ?? box.read(_retailOrderTypesStorageKey));
    } catch (_e) {
      return null;
    }
  }

  /// Table Storage
  static isStorageHasTablesData() =>
      _storageHasData(AppStorage._retailTableDataStorageKey);

  static setTablesData(String _res) async =>
      await AppStorage._write(AppStorage._retailTableDataStorageKey, _res);

  static TableModel? getTablesData({String? res}) {
    try {
      return tableModelFromJson(res ?? box.read(_retailTableDataStorageKey));
    } catch (_e) {
      return null;
    }
  }

  // /// Printer Storage
  // static setPrinterData(String _res) async =>
  //     await AppStorage.write(AppStorage.printerDataStorageKey, _res);
  //
  // static List<AllPrintersModel>? getPrinterData({String? res}) {
  //   try {
  //     return allPrintersModelFromJson(res ?? box.read(printerDataStorageKey));
  //   } catch (_e) {
  //     logger.e('Error => $_e');
  //     return null;
  //   }
  // }

  /// Products Storage
  static isStorageHasProductsData() =>
      _storageHasData(AppStorage._retailProductsStorageKey);

  static setProductsData(String _res) async =>
      await AppStorage._write(AppStorage._retailProductsStorageKey, _res);

  static CategoriesProductsModel? getProductsData({String? res}) {
    try {
      return categoriesProductsModelFromJson(
          res ?? box.read(_retailProductsStorageKey));
    } catch (_e) {
      return null;
    }
  }
}
