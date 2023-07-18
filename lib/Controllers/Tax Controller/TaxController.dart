import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/utils.dart';
import '/Models/TaxModel/taxModel.dart';
import '/Services/api_services.dart';
import '/Services/api_urls.dart';

class TaxController extends GetxController {
  ListTaxModel? listTaxModel;

  /// Fetching All Tax List
  Future fetchListTax({String? pageUrl}) async {
    await ApiServices.getMethod(feedUrl: pageUrl ?? ApiUrls.listTaxAPI)
        .then((_res) {
      update();
      if (_res == null) return null;
      listTaxModel = listTaxModelFromJson(_res);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }

  /// cart tax calculation & enable status
  // bool get isOrderTaxEnable {
  //   BusinessDataModel? businessData =
  //       AppStorage.getBusinessDetailsData()?.businessData;
  //   return businessData?.posSettings?.disableOrderTax == 0 &&
  //       businessData?.defaultSalesTax != null;
  // }
  //
  // bool get isInlineTaxEnable {
  //   BusinessDataModel? businessData =
  //       AppStorage.getBusinessDetailsData()?.businessData;
  //   return businessData?.enableInlineTax == 1 &&
  //       businessData?.posSettings?.disableOrderTax == 1;
  // }
  //
  // bool get isTaxEnable => isInlineTaxEnable || isOrderTaxEnable;
  //
  // /// TODO: need to figure-out
  // double totalTaxAmount(
  //     {List<ProductModel>? items, ordersItemsTotalTax = 0.0}) {
  //   if (!isOrderTaxEnable && !isInlineTaxEnable) return 0;
  //   final ProductCartController prodCartCtrlObj =
  //   Get.find<ProductCartController>();
  //   // fetchListTax();
  //   // (double.parse(totalAmount())/100)*tax; // TODO: tax calculation
  //   double itemsTax = 0.0;
  //   try {
  //     for (var _itr in items ?? prodCartCtrlObj.itemCartList) {
  //       double _itemPrice = double.parse(
  //           '${_itr.productVariations.first.variations.first.sellPriceIncTax ?? 0.0}');
  //       print('Item Price');
  //       print(_itemPrice);
  //       int _itemTax = _itr.productTax?.amount ?? 0;
  //       itemsTax += (_itemPrice *
  //           _itr.quantity *
  //           double.parse(listTaxModel?.data?[0].amount.toString() ?? '0')) /
  //           ((double.parse(listTaxModel?.data?[0].amount.toString() ?? '0')) +
  //               100);
  //     }
  //   } catch (e) {
  //     logger.e('Error to calculate total tax amount => $e');
  //   }
  //   return double.parse(
  //       AppFormat.doubleToStringUpTo2('${itemsTax + ordersItemsTotalTax}')!);
  // }
  //
  // /// Order tax amount calculation method
  // double get orderTaxAmount {
  //   if (!isOrderTaxEnable && isInlineTaxEnable) return 0;
  //   final ProductCartController prodCartCtrlObj =
  //   Get.find<ProductCartController>();
  //   // fetchListTax();
  //   // (double.parse(totalAmount())/100)*tax; // TODO: tax calculation
  //   double itemsTax = 0.0;
  //   try {
  //     for (var _itr in prodCartCtrlObj.itemCartList) {
  //       double _itemPrice = double.parse(
  //           '${_itr.productVariations.first.variations.first.sellPriceIncTax ?? 0.0}');
  //       print('Item Price');
  //       print(_itemPrice);
  //       int _itemTax = _itr.productTax?.amount ?? 0;
  //       itemsTax += (_itemPrice *
  //           _itr.quantity *
  //           double.parse(listTaxModel?.data?[0].amount.toString() ?? '0')) /
  //           ((double.parse(listTaxModel?.data?[0].amount.toString() ?? '0')) +
  //               100);
  //     }
  //   } catch (e) {
  //     logger.e('Error to calculate total tax amount => $e');
  //   }
  //   return double.parse(AppFormat.doubleToStringUpTo2('${itemsTax}')!);
  // }
  //
  // /// inline tax amount calculation method
  // double inlineTaxAmount(ProductModel itemProduct) {
  //   if (!isInlineTaxEnable) return 0;
  //   final ProductCartController prodCartCtrlObj =
  //   Get.find<ProductCartController>();
  //
  //   return (double.parse(
  //       '${itemProduct.productVariations.first.variations.first.defaultSellPrice}') /
  //       100) *
  //       double.parse('${itemProduct.productTax?.amount ?? 0.00}');
  // }
}
