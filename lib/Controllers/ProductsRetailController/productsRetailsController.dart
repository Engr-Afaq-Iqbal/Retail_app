import 'dart:io';
import 'package:bizmodo_emenu/Controllers/Tax%20Controller/TaxController.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/DateTimeFormat.dart';
import '../../Config/utils.dart';
import '../../Models/ProductsModel/ProductModel.dart';
import '../../Models/ProductsModel/ShowProductListModel.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../../Services/storage_services.dart';
import '../exception_controller.dart';

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
  TextEditingController marginCtrl = TextEditingController();
  TextEditingController defaultSellingPriceCtrl = TextEditingController();
  TextEditingController defaultSelllingIncCtrl = TextEditingController();
  TextEditingController defaultSelllingExcCtrl = TextEditingController();

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

  File? broucher;
  File? image;

  addProduct() async {
    String _url = '${ApiUrls.createNewProductApi}';

    Map<String, String> _fields = {};
    _fields['name'] = '${productNameCtrl.text}';
    _fields['brand_id'] = '45';
    _fields['unit_id'] = '${unitID}';
    _fields['category_id'] = '${categoryID}';
    _fields['tax'] = '${applicableTaxId}';
    _fields['type'] = '${productTypeStatus?.toLowerCase()}';
    _fields['barcode_type'] = '${barCodeKey}';
    _fields['sku'] = '${productSKUCtrl.text}';
    _fields['alert_quantity'] = '${alertQtyCtrl.text}';
    _fields['tax_type'] = '${taxTypeStatus?.toLowerCase()}';
    _fields['weight'] = '${weightCtrl.text}';
    _fields['product_custom_field1'] = '${customField1Ctrl.text}';
    _fields['product_custom_field2'] = '${customField2Ctrl.text}';
    _fields['product_custom_field3'] = '${customField3Ctrl.text}';
    _fields['product_custom_field4'] = '${customField4Ctrl.text}';
    _fields['product_description'] = '';
    _fields['sub_unit_ids'] = '51';
    _fields['preparation_time_in_minutes'] = '';
    _fields['kitchen_id'] = '${printerID}';
    _fields['type_of_product'] = '${typeOfProductID}';
    _fields['sub_category_id'] = '${categoryID}';
    _fields['enable_stock'] = '';
    _fields['warranty_id'] = '$warrantyID';
    _fields['has_module_data'] = '1';
    _fields['repair_model_id'] = '';
    _fields['enable_sr_no'] = '$enableProductID';
    _fields['not_for_selling'] = '${notForSellingID}';
    _fields['woocommerce_disable_sync'] = '$disableWooCommerceID';
    _fields['single_dpp_inc_tax'] = '${incTaxCtrl.text}';
    _fields['single_dpp'] = '${excTaxCtrl.text}';
    _fields['profit_percent'] = '${marginCtrl.text}';
    _fields['single_dsp'] = '${defaultSelllingExcCtrl.text}';
    _fields['single_dsp_inc_tax'] = '${defaultSelllingIncCtrl.text}';
    _fields['product_locations[0]'] = '30';
    _fields['product_brochure'] = '${broucher?.path}';
    _fields['image'] = '${image?.path}';
    _fields['rack[0]'] = 'Assumenda dolores ad';
    _fields['row[0]'] = 'Consectetur quia qu';
    _fields['position[0]'] = 'Amet aut est quasi';
    _fields['location_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}';
    logger.i(_fields);

    return await ApiServices.postMultiPartQuery(feedUrl: _url, files: _fields)
        .then((response) async {
      if (response == null) return;
      stopProgress();
      Get.close(1);
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

  Future createNewProduct() async {
    Map<String, String> _field = {
      'name': '${productNameCtrl.text}',
      'brand_id': '45',
      'unit_id': '${unitID}',
      'category_id': '${categoryID}',
      'tax': '${applicableTaxId}',
      'type': '${productTypeStatus?.toLowerCase()}',
      'barcode_type': '${barCodeKey}',
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
      'single_dpp_inc_tax': '${incTaxCtrl.text}',
      'single_dpp': '${excTaxCtrl.text}',
      'profit_percent': '${marginCtrl.text}',
      'single_dsp': '${defaultSelllingExcCtrl.text}',
      'single_dsp_inc_tax': '${defaultSelllingIncCtrl.text}',
      'product_locations[0]': '30',
      'product_brochure': '${broucher?.path}',
      'image': '${image?.path}',
      'rack[0]': 'Assumenda dolores ad',
      'row[0]': 'Consectetur quia qu',
      'position[0]': 'Amet aut est quasi',
      'location_id':
          '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}'
    };

    return await ApiServices.postMultiPartQuery(
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

  /// Fetching Product List Method
  Future fetchShowProductList({String? pageUrl}) async {
    await ApiServices.getMethod(feedUrl: pageUrl ?? ApiUrls.showProductListApi)
        .then((_res) {
      update();
      if (_res == null) return null;
      showProductListModel = showProductListModelFromJson(_res);
      update();
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.showProductListApi, error, stackTrace),
      );
      update();
    });
  }

  ///Functions are starting from here for Taxes
  String excTax({String? value}) {
    double itemsPriceCount = 0.0;
    try {
      if (taxTypeStatus?.toLowerCase() == 'exclusive') {}
    } catch (e) {
      logger.e('Error to calculate sub total amount => $e');
    }

    return AppFormat.doubleToStringUpTo2('${itemsPriceCount}') ?? '0';
  }

  String defaultSellingPrice({String? value, taxCtrlObj}) {
    double defaultSellingAmount = 0;
    try {
      if (taxTypeStatus?.toLowerCase() == 'exclusive') {
        defaultSellingAmount = double.parse(excTaxCtrl.text) *
            (double.parse(marginCtrl.text) / 100);
        defaultSellingAmount =
            defaultSellingAmount + double.parse(excTaxCtrl.text);
        defaultSelllingExcCtrl.text = defaultSellingAmount.toString();
        defaultSellingPriceCtrl.text = defaultSellingAmount.toString();
        print('Result;;;;;;;;;');
        print(defaultSellingAmount);
        update();
      } else if (taxTypeStatus?.toLowerCase() == 'inclusive') {
        defaultSellingAmount = double.parse(incTaxCtrl.text) *
            (double.parse(marginCtrl.text) / 100);
        defaultSellingAmount =
            defaultSellingAmount + double.parse(incTaxCtrl.text);
        defaultSelllingIncCtrl.text = defaultSellingAmount.toString();
        defaultSellingPriceCtrl.text = defaultSellingAmount.toString();
        print('Result;;;;;;;;;');
        print(defaultSellingAmount);
        update();
      }
    } catch (e) {
      logger.e('Error to calculate sub total amount => $e');
    }

    return AppFormat.doubleToStringUpTo2('${defaultSellingAmount}') ?? '0';
  }

  String incTax({String? value, taxCtrlObj}) {
    double defaultSellingAmount = 0;
    try {
      if (taxTypeStatus?.toLowerCase() == 'exclusive') {
        ///Exclusive Vat
        ///Formula : Amount /100*Vat
        ///100/100*5  =5 +100 = 105
        defaultSellingAmount = (double.parse(excTaxCtrl.text) / 100) *
            double.parse(
                taxCtrlObj.listTaxModel?.data?[0].amount.toString() ?? '0');

        defaultSellingAmount =
            defaultSellingAmount + double.parse(excTaxCtrl.text);
        excTaxCtrl.text = defaultSellingAmount.toString();
        print('Result;;;;;;;;;');
        print(defaultSellingAmount);
        update();
      } else if (taxTypeStatus?.toLowerCase() == 'inclusive') {
        ///Inclusive Vat
        ///Formula : Amount*vat/100+vat
        ///100*5/105 = 4.76
        ///100 - 4.76 =. 95.76
        defaultSellingAmount = (double.parse(incTaxCtrl.text) *
                double.parse(
                    taxCtrlObj.listTaxModel?.data?[0].amount.toString() ??
                        '0')) /
            (100 +
                double.parse(
                    taxCtrlObj.listTaxModel?.data?[0].amount.toString() ??
                        '0'));
        defaultSellingAmount =
            double.parse(incTaxCtrl.text) - defaultSellingAmount;
        incTaxCtrl.text = defaultSellingAmount.toString();
        print('Result;;;;;;;;;');
        print(defaultSellingAmount);
        update();
      }
    } catch (e) {
      logger.e('Error to calculate sub total amount => $e');
    }

    return AppFormat.doubleToStringUpTo2('${defaultSellingAmount}') ?? '0';
  }

  addVatInInctax({taxCtrlObj}) {
    double defaultSellingAmount = 0;
    try {
      incTaxCtrl.text =
          '${double.parse(incTaxCtrl.text) + double.parse(taxCtrlObj.listTaxModel?.data?[0].amount.toString() ?? '0')}';
      update();
    } catch (e) {
      logger.e('Error to calculate sub total amount => $e');
    }

    return AppFormat.doubleToStringUpTo2('${defaultSellingAmount}') ?? '0';
  }

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
    excTaxCtrl.clear();
    incTaxCtrl.clear();
    unitStatusHint = 'Please Select';
    barCodeHintStatus = 'Please Select';
    categoriesHintStatus = 'Please Select';
    typeOfProductHintStatus = 'Please Select';
    barCodeStatus = null;
    barCodeKey = null;
    unitStatus = null;
    unitID = null;
    categoryStatus = null;
    categoryID = null;
    warrantyStatus = null;
    warrantyID = null;
    printerStatus = null;
    printerID = null;
    typeOfProductStatus = null;
    typeOfProductID = null;
    enableProduct = false;
    enableProductID = '0';
    notForSelling = false;
    notForSellingID = '0';
    disableWooCommerce = false;
    disableWooCommerceID = '0';
    applicableTaxStatus = null;
    applicableTaxId = null;
    taxTypeStatus = null;
    applicableTaxStatus = null;
    productTypeStatus = null;
    manageValue = false;
    excTaxCtrl.clear();
    incTaxCtrl.clear();
    defaultSellingPriceCtrl.clear();
    marginCtrl.clear();
  }
}
