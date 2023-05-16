import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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

  List<String> rowRackList = [
    'Restaurant (BL001)',
    'Store (BL002)',
    'Afaq (BL003)',
  ];

  List<String> barCodeTypeList() {
    List<String> options = [
      'Code 128 (C128)',
      'Code 39 (C39)',
      'EAN-13',
      'EAN-8',
      'UPC-A',
      'UPC-E'
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

  List<String> unitList() {
    List<String> options = [
      'Pieces (Pc(s))',
      'Plate (Plate)',
      'KG (KG)',
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
}
