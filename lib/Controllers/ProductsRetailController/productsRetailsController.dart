import 'package:bizmodo_emenu/Controllers/Tax%20Controller/TaxController.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Models/ProductsModel/ProductModel.dart';
import '../../Models/ProductsModel/ShowProductListModel.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../../Services/storage_services.dart';

class ProductsRetailController extends GetxController {
  String? barCodeStatus;
  String? unitStatus;
  String? categoryStatus;
  String? warrantyStatus;
  String? printerStatus;
  String? deviceModelStatus;
  String? typeOfProductStatus;
  String? applicableTaxStatus;
  String? taxTypeStatus;
  String? productTypeStatus;
  String? barCodeKey;
  String? unitID;
  String? categoryID;
  String? warrantyID;
  String? printerID;
  String? typeOfProductID;
  String? applicableTaxId;
  String barCodeHintStatus = 'Please Select';
  String unitStatusHint = 'Please Select';
  String categoriesHintStatus = 'Please Select';
  String warrantyHintStatus = 'Please Select';
  String typeOfProductHintStatus = 'Please Select';
  bool manageValue = false;
  bool enableProduct = false;
  bool notForSelling = false;
  bool disableWooCommerce = false;
  String enableProductID = '0';
  String notForSellingID = '0';
  String disableWooCommerceID = '0';
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productSKUCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController productDescCtrl = TextEditingController();
  TextEditingController weightCtrl = TextEditingController();
  TextEditingController customField1Ctrl = TextEditingController();
  TextEditingController customField2Ctrl = TextEditingController();
  TextEditingController customField3Ctrl = TextEditingController();
  TextEditingController customField4Ctrl = TextEditingController();
  TextEditingController serviceStaffTimerCtrl = TextEditingController();
  TextEditingController productTypeCtrl = TextEditingController();
  TextEditingController rackCtrl = TextEditingController();
  TextEditingController rowCtrl = TextEditingController();
  TextEditingController positionCtrl = TextEditingController();
  TextEditingController alertQtyCtrl = TextEditingController();
  TextEditingController excTaxCtrl = TextEditingController();
  TextEditingController incTaxCtrl = TextEditingController();

  clearAllFields() {
    productNameCtrl.clear();
    productSKUCtrl.clear();
    dateCtrl.clear();
    productDescCtrl.clear();
    weightCtrl.clear();
    customField1Ctrl.clear();
    customField2Ctrl.clear();
    customField3Ctrl.clear();
    customField4Ctrl.clear();
    serviceStaffTimerCtrl.clear();
    productTypeCtrl.clear();
    rackCtrl.clear();
    rowCtrl.clear();
    positionCtrl.clear();
    alertQtyCtrl.clear();
    unitStatusHint = 'Please Select';
    barCodeHintStatus = 'Please Select';
    categoriesHintStatus = 'Please Select';
    typeOfProductHintStatus = 'Please Select';
  }

  List<String> rowRackList = [
    'Restaurant (BL001)',
    'Store (BL002)',
    'Afaq (BL003)',
  ];

  List<String> barCodeTypeList(ProductsRetailController productRetailCtrlObj) {
    //List<String> options = ['C128', 'C39', 'EAN-13', 'EAN-8', 'UPC-A', 'UPC-E'];
    List<String> options = [];

    for (int i = 0;
        i < productRetailCtrlObj.showProductListModel!.barcodeTypes!.length;
        i++) {
      options.add(
          '${productRetailCtrlObj.showProductListModel?.barcodeTypes?[i].value}');
    }
    return options;
  }

  List<String> unitList(ProductsRetailController productRetailCtrlObj,
      int? index, List<ProductModel>? productModelObjs) {
    // List<String> options = [
    //   'Pc(s)',
    //   'Plate',
    //   'KG',
    // ];
    List<String> options = [];
    List<String> idsList = [];
    for (int i = 0;
        i < productRetailCtrlObj.showProductListModel!.units!.length;
        i++) {
      options
          .add('${productRetailCtrlObj.showProductListModel?.units?[i].name}');
      idsList.add('${productRetailCtrlObj.showProductListModel?.units?[i].id}');
    }
    print(idsList);

    if (index != null) {
      int unitStatus =
          idsList.indexOf(productModelObjs![index].unitId.toString());
      unitStatusHint = options[unitStatus];
    }
    return options;
  }

  List<String> categoryList(ProductsRetailController prodRtailCtrlObj,
      int? index, List<ProductModel>? productModelObjs) {
    //List<String> options = ['A Main', 'Appetizers', 'burger', 'chicken'];
    List<String> options = [];
    List<String> idsList = [];
    for (int i = 0;
        i < prodRtailCtrlObj.showProductListModel!.categories!.length;
        i++) {
      options
          .add('${prodRtailCtrlObj.showProductListModel!.categories![i].name}');
      idsList
          .add('${prodRtailCtrlObj.showProductListModel!.categories![i].id}');
    }
    if (index != null) {
      int unitStatus =
          idsList.indexOf(productModelObjs![index].categoryId.toString());
      print(unitStatus);
      categoriesHintStatus = options[unitStatus];
    }
    return options;
  }

  List<String> warrantyList(ProductsRetailController prodRtailCtrlObj,
      int? index, List<ProductModel>? productModelObjs) {
    // List<String> options = [
    //   '1 Years (1 Years)',
    // ];
    List<String> options = [];
    List<String> idsList = [];
    for (int i = 0;
        i < prodRtailCtrlObj.showProductListModel!.warranties!.length;
        i++) {
      options
          .add('${prodRtailCtrlObj.showProductListModel!.warranties![i].name}');
      idsList
          .add('${prodRtailCtrlObj.showProductListModel!.warranties![i].id}');
    }
    if (index != null) {
      int unitStatus =
          idsList.indexOf(productModelObjs![index].warrantyId.toString());
      if (unitStatus == -1) {
        warrantyHintStatus = '';
      } else {
        warrantyHintStatus = options[unitStatus];
      }
      print(unitStatus);
    }
    return options;
  }

  List<String> typeofProductList(ProductsRetailController prodRtailCtrlObj,
      int? index, List<ProductModel>? productModelObjs) {
    //List<String> options = ['Test Product', 'Veg', 'Veg 1'];
    List<String> options = [];
    List<String> idsList = [];
    for (int i = 0;
        i < prodRtailCtrlObj.showProductListModel!.typeOfProducts!.length;
        i++) {
      options.add(
          '${prodRtailCtrlObj.showProductListModel?.typeOfProducts?[i].name}');
      idsList.add(
          '${prodRtailCtrlObj.showProductListModel?.typeOfProducts?[i].id}');
    }
    if (index != null) {
      int unitStatus =
          idsList.indexOf(productModelObjs![index].type.toString());
      if (unitStatus == -1) {
        typeOfProductHintStatus = '';
      } else {
        typeOfProductHintStatus = options[unitStatus];
      }
      print(unitStatus);
    }
    return options;
  }

  // List<String> deviceModelList(ProductsRetailController prodRtailCtrlObj) {
  //   // List<String> options = [
  //   //   'Please Select',
  //   // ];
  //   List<String> options = [];
  //   for (int i = 0;
  //   i <prodRtailCtrlObj.showProductListModel.;
  //   i++) {
  //     options.add(
  //         '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName}');
  //   }
  //   return options;
  // }

  List<String> applicableTaxList(TaxController taxCtrlObj) {
    // List<String> options = ['None', 'VAT'];
    List<String> options = [];
    for (int i = 0; i < taxCtrlObj.listTaxModel!.data!.length; i++) {
      options.add('${taxCtrlObj.listTaxModel?.data?[i].name}');
    }
    return options;
  }

  List<String> taxTypeList() {
    List<String> options = ['Inclusive', 'Exclusive'];
    return options;
  }

  List<String> productTypeList() {
    List<String> options = ['Single', 'Variable', 'Combo'];
    return options;
  }

  Future createNewProduct() async {
    Map<String, String> _field = {
      // 'name': '${productNameCtrl.text}',
      // 'brand_id': '45',
      // 'unit_id': '${unitID}',
      // 'category_id': '${categoryID}',
      // 'tax': '${applicableTaxId}',
      // 'type': '${productTypeStatus?.toLowerCase()}',
      // 'barcode_type': '', // '${barCodeKey}',
      // 'sku': '${productSKUCtrl.text}',
      // 'alert_quantity': '${alertQtyCtrl.text}',
      // 'weight': '${weightCtrl.text}',
      // 'product_custom_field1': '${customField1Ctrl.text}',
      // 'product_custom_field2': '${customField2Ctrl.text}',
      // 'product_custom_field3': '${customField3Ctrl.text}',
      // 'product_custom_field4': '${customField4Ctrl.text}',
      // 'product_description': '${productDescCtrl.text}',
      // 'sub_unit_ids': '51',
      // 'preparation_time_in_minutes': '',
      // 'kitchen_id': '15', //'${printerID}',
      // 'type_of_product': '${typeOfProductID}',
      // 'sub_category_id': '51',
      // 'enable_stock': '1',
      // 'warranty_id': '${warrantyID}',
      // 'has_module_data': '1',
      // 'repair_model_id': '',
      // 'enable_sr_no': '${enableProductID}',
      // 'not_for_selling': '${notForSellingID}',
      // 'woocommerce_disable_sync': '${disableWooCommerceID}',
      // 'tax_type': '${taxTypeStatus}'.toLowerCase(),
      // 'single_dpp_inc_tax': '105.00',
      // 'single_dpp': '100',
      // 'profit_percent': '25.00',
      // 'single_dsp': '125.00',
      // 'single_dsp_inc_tax': '131.25',
      // 'image': '',
      // 'product_brochure': '',
      // 'variation_images[0]': '',
      // 'product_locations[0]': '30',
      // 'rack[0]': 'Assumenda dolores ad',
      // 'row[0]': 'Consectetur quia qu',
      // 'position[0]': 'Amet aut est quasi',
      // 'location_id':
      //    '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}'
      'name': '${productNameCtrl.text}',
      'brand_id': '45',
      'unit_id': '${unitID}',
      'category_id': '${categoryID}',
      'tax': '${applicableTaxId}',
      'type': '${productTypeStatus?.toLowerCase()}',
      'barcode_type': '${barCodeStatus}',
      'sku': '${productSKUCtrl.text}',
      'alert_quantity': '${alertQtyCtrl.text}',
      'tax_type': '${taxTypeStatus?.toLowerCase()}',
      'weight': '${weightCtrl.text}',
      'product_custom_field1': '${customField1Ctrl.text}',
      'product_custom_field2': '${customField2Ctrl.text}',
      'product_custom_field3': '${customField3Ctrl.text}',
      'product_custom_field4': '${customField4Ctrl.text}',
      'product_description': '',
      'sub_unit_ids': '51',
      'preparation_time_in_minutes': '',
      'kitchen_id': '${printerID}',
      'type_of_product': '${typeOfProductID}',
      'sub_category_id': '${categoryID}',
      'enable_stock': '',
      'warranty_id': '$warrantyID',
      'has_module_data': '1',
      'repair_model_id': '',
      'enable_sr_no': '$enableProductID',
      'not_for_selling': '${notForSellingID}',
      'woocommerce_disable_sync': '$disableWooCommerceID',
      'single_dpp_inc_tax': '105.00',
      'single_dpp': '100',
      'profit_percent': '25.00',
      'single_dsp': '125.00',
      'single_dsp_inc_tax': '131.25',
      'product_locations[0]': '30',
      'rack[0]': 'Assumenda dolores ad',
      'row[0]': 'Consectetur quia qu',
      'position[0]': 'Amet aut est quasi',
      'location_id':
          '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}'
    };

    return await ApiServices.postMethod(
            feedUrl: ApiUrls.createNewProductApi, fields: _field)
        .then((_res) {
      if (_res == null) return null;
      stopProgress();
      return true;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      throw '$error';
    });
  }

  ShowProductListModel? showProductListModel;

  /// Fetching Stock Adjustment
  Future fetchShowProductList({String? pageUrl}) async {
    await ApiServices.getMethod(feedUrl: pageUrl ?? ApiUrls.showProductListApi)
        .then((_res) {
      update();
      if (_res == null) return null;
      showProductListModel = showProductListModelFromJson(_res);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }
}
