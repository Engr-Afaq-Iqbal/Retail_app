import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Config/DateTimeFormat.dart';
import '../../Models/ProductsModel/product.dart';
import '../../Models/business_n_register/BusinessModel.dart';
import '../../Models/order_type_model/SaleOrderModel.dart';
import '../../Services/storage_services.dart';
import '../ProductController/all_products_controller.dart';
import '../exception_controller.dart';
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
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.listTaxAPI, error, stackTrace),
      );
      update();
    });
  }

  /// cart tax calculation & enable status
  bool get isOrderTaxEnable {
    BusinessDataModel? businessData =
        AppStorage.getBusinessDetailsData()?.businessData;
    return businessData?.posSettings?.disableOrderTax == 0 &&
        businessData?.defaultSalesTax != null;
  }

  bool get isInlineTaxEnable {
    BusinessDataModel? businessData =
        AppStorage.getBusinessDetailsData()?.businessData;
    return businessData?.enableInlineTax == 1 &&
        businessData?.posSettings?.disableOrderTax == 1;
  }

  bool get isTaxEnable => isInlineTaxEnable || isOrderTaxEnable;

  /// TODO: need to figure-out
  double totalTaxAmount({
    List<Product>? items,
    ordersItemsTotalTax = 0.0,
    List<String>? quantity,
  }) {
    if (!isOrderTaxEnable && !isInlineTaxEnable) return 0;
    final AllProductsController prodCartCtrlObj =
    Get.find<AllProductsController>();
    // fetchListTax();
    // (double.parse(totalAmount())/100)*tax; // TODO: tax calculation
    double itemsTax = 0.0;
    try {
      // for (var _itr in items ?? prodCartCtrlObj.selectedProducts) {
      //   double _itemPrice = double.parse(
      //       '${_itr.productVariations?.first.variations?.first.sellPriceIncTax ?? 0.0}');
      //   print('Item Price');
      //   print(_itemPrice);
      //   int _itemTax = _itr.productTax?.amount ?? 0;
      //   itemsTax += (_itemPrice *
      //           _itr.quantity *
      //           double.parse(listTaxModel?.data?[0].amount.toString() ?? '0')) /
      //       ((double.parse(listTaxModel?.data?[0].amount.toString() ?? '0')) +
      //           100);
      // }
      var length = quantity?.length ?? 0;
      for (int i = 0; i < length; i++) {
        double _itemPrice = double.parse(
            '${prodCartCtrlObj.selectedProducts[i].productVariations?.first.variations?.first.sellPriceIncTax ?? 0.0}');
        itemsTax += (_itemPrice *
            double.parse(quantity?[i] ?? '0.00') *
            double.parse(listTaxModel?.data?[0].amount.toString() ?? '0')) /
            ((double.parse(listTaxModel?.data?[0].amount.toString() ?? '0')) +
                100);
      }
    } catch (e) {
      logger.e('Error to calculate total tax amount => $e');
    }
    return double.parse(
        AppFormat.doubleToStringUpTo2('${itemsTax + ordersItemsTotalTax}')!);
  }

  /// Order tax amount calculation method
  double get orderTaxAmount {
    if (!isOrderTaxEnable && isInlineTaxEnable) return 0;
    final AllProductsController prodCartCtrlObj =
    Get.find<AllProductsController>();
    // fetchListTax();
    // (double.parse(totalAmount())/100)*tax; // TODO: tax calculation
    double itemsTax = 0.0;
    try {
      // for (var _itr in prodCartCtrlObj.selectedProducts) {
      //   double _itemPrice = double.parse(
      //       '${_itr.productVariations?.first.variations?.first.sellPriceIncTax ?? 0.0}');
      //   print('Item Price');
      //   print(_itemPrice);
      //   int _itemTax = _itr.productTax?.amount ?? 0;
      //   itemsTax += (_itemPrice *
      //           _itr.quantity *
      //           double.parse(listTaxModel?.data?[0].amount.toString() ?? '0')) /
      //       ((double.parse(listTaxModel?.data?[0].amount.toString() ?? '0')) +
      //           100);
      // }

      for (int i = 0;
      i < Get.find<AllProductsController>().selectedQuantityList.length;
      i++) {
        double _itemPrice = double.parse(
            '${prodCartCtrlObj.selectedProducts[i].productVariations?.first.variations?.first.sellPriceIncTax ?? 0.0}');
        itemsTax += (_itemPrice *
            double.parse(
                Get.find<AllProductsController>().selectedQuantityList[i] ??
                    '0.00') *
            double.parse(listTaxModel?.data?[0].amount.toString() ?? '0')) /
            ((double.parse(listTaxModel?.data?[0].amount.toString() ?? '0')) +
                100);
      }
      print('Order tax ;;;;${itemsTax}');
    } catch (e) {
      logger.e('Error to calculate total tax amount => $e');
    }
    return double.parse(AppFormat.doubleToStringUpTo2('${itemsTax}')!);
  }

  /// inline tax amount calculation method
  double inlineTaxAmount(
      Product itemProduct,
      ) {
    if (!isInlineTaxEnable) return 0;
    final AllProductsController prodCartCtrlObj =
    Get.find<AllProductsController>();

    // return (double.parse(
    //             '${itemProduct.productVariations?.first.variations?.first.sellPriceIncTax}') *
    //         double.parse('${itemProduct.productTax?.amount ?? 0.00}')) /
    //     (100 + double.parse('${itemProduct.productTax?.amount ?? 0.00}'));
    return (double.parse(
        '${itemProduct.productVariations?.first.variations?.first.defaultSellPrice}') /
        100) *
        double.parse('${itemProduct.productTax?.amount ?? 0.00}');
  }

  /// inline tax amount calculation method
  double inlineTaxAmountForPDF(
      int? taxId,
      String? amount,
      ) {
    if (!isInlineTaxEnable) return 0;
    final AllProductsController prodCartCtrlObj =
    Get.find<AllProductsController>();

    // return (double.parse(
    //             '${itemProduct.productVariations?.first.variations?.first.sellPriceIncTax}') *
    //         double.parse('${itemProduct.productTax?.amount ?? 0.00}')) /
    //     (100 + double.parse('${itemProduct.productTax?.amount ?? 0.00}'));
    print(
        'Inside Tax Ctrl --> ${(double.parse('${amount}') / 100) * double.parse('${checkTaxAmount(taxId: taxId) ?? 0.00}')}');
    return (double.parse('${amount}') / 100) *
        double.parse('${checkTaxAmount(taxId: taxId) ?? 0.00}');
  }

  checkTaxAmount({
    int? taxId,
  }) {
    return listTaxModel?.data?.firstWhereOrNull((i) => i.id == taxId)?.amount ??
        '0.00';
  }
}
