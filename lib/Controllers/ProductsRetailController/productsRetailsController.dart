import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';

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
  bool manageValue = false;
  bool enableProduct = false;
  bool notForSelling = false;
  bool disableWooCommerce = false;
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

  List<String> rowRackList = [
    'Restaurant (BL001)',
    'Store (BL002)',
    'Afaq (BL003)',
  ];

  List<String> barCodeTypeList() {
    List<String> options = ['C128', 'C39', 'EAN-13', 'EAN-8', 'UPC-A', 'UPC-E'];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

  List<String> unitList() {
    List<String> options = [
      'Pc(s)',
      'Plate',
      'KG',
    ];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

  List<String> categoryList() {
    List<String> options = ['A Main', 'Appetizers', 'burger', 'chicken'];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

  List<String> warrantyList() {
    List<String> options = [
      '1 Years (1 Years)',
    ];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

  List<String> printersList() {
    List<String> options = [
      'Kitchen 1',
      'Kitchen 2',
      'Kitchen 12',
    ];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

  List<String> deviceModelList() {
    List<String> options = [
      'Please Select',
    ];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

  List<String> typeofProductList() {
    List<String> options = ['Test Product', 'Veg', 'Veg 1'];
    // for (int i = 0;
    // i < widget.listUserCtrlObj!.listuserModel!.data!.length;
    // i++) {
    //   options.add(
    //       '${widget.listUserCtrlObj?.listuserModel?.data?[i].firstName} ${widget.listUserCtrlObj?.listuserModel?.data?[i].lastName == null ? '' : widget.listUserCtrlObj?.listuserModel?.data?[i].lastName}' ??
    //           '');
    // }
    return options;
  }

  List<String> applicableTaxList() {
    List<String> options = ['None', 'VAT'];
    return options;
  }

  List<String> taxTypeList() {
    List<String> options = ['Inclusive', 'Exclusive'];
    return options;
  }

  Future createNewProduct() async {
    Map<String, String> _field = {
      "product_name": '${productNameCtrl.text}',
      "sku": '${productSKUCtrl.text}',
      "barcode_type": '${barCodeStatus}',
      "unit": '${unitStatus}',
      "category": '${categoryStatus}',
      "alert_quantity": '${alertQtyCtrl.text}',
      "warranty": '${warrantyStatus}',
      "printer": '${printerStatus}',
      "type_of_product": '${typeOfProductStatus}',
      "device_model": '${deviceModelStatus}',
      "product_desc": '${productDescCtrl.text}',
      "product_image": 'image',
      "product_broucer": 'prod-borucher image',
      "enable_product dexc": '1',
      "not_for_selling": '0',
      "weight": '${weightCtrl.text}',
      "custom_field1": '${customField1Ctrl}',
      "custom_field2": '${customField2Ctrl}',
      "custom_field3": '${customField3Ctrl}',
      "custom_field4": '${customField4Ctrl}',
      "disable woo comerce": '0',
      "applicable_tax": '${applicableTaxStatus}',
      "sellingPriceTaxtype": '${taxTypeStatus}',
      "product_type": '${productTypeCtrl.text}',
    };

    return await ApiServices.postMethod(
            feedUrl: ApiUrls.createNewBookingAPI, fields: _field)
        .then((_res) {
      if (_res == null) return null;

      return true;
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      throw '$error';
    });
  }

  clearAllFields() {
    productNameCtrl.clear();
  }
}
