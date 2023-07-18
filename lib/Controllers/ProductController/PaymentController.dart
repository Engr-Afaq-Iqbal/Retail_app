import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Config/DateTimeFormat.dart';
import '../../Config/const.dart';
import '../../Services/storage_services.dart';
import '../register/RegisterController.dart';
import '/Config/utils.dart';

import '/Models/PaymentMethodModel/paymentMethodModel.dart';
import '/Models/business_n_register/BusinessModel.dart';
import '/Pages/checkout/payment_fields.dart';
import '/Services/api_urls.dart';

class PaymentController extends GetxController {
  final RegisterController regCtrlObj = Get.find<RegisterController>();

  final TextEditingController sellNoteCtrl = TextEditingController();
  final TextEditingController staffNoteCtrl = TextEditingController();

  ///for Add Payment from All Sells page
  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController transactionNoCtrl = TextEditingController();
  final TextEditingController checkNoCtrl = TextEditingController();
  final TextEditingController paymentNoteCtrl = TextEditingController();
  final TextEditingController paymentAccountCtrl = TextEditingController();
  final TextEditingController fileNameCtrl = TextEditingController();
  final TextEditingController paymentMethodCtrl = TextEditingController();
  final TextEditingController accountIdCtrl = TextEditingController();

  /// payment widget list handlers
  RxList<PaymentFields> paymentWidgetList = <PaymentFields>[].obs;

  addPaymentWidget({PaymentFields? paymentWidget, double? totalAmount}) {
    paymentWidgetList.add(
      paymentWidget ??
          PaymentFields(
            key: UniqueKey(),
            enabledPaymentOptions: getAllowedPayments(),
            remainingAmount: _calculateRemainingAmountForCheckout(totalAmount),
          ),
    );
  }

  removePaymentWidget({int? index, Key? key}) {
    if (index != null)
      paymentWidgetList.removeAt(index);
    else if (key != null)
      paymentWidgetList
          .removeWhere((_paymentWidget) => _paymentWidget.key == key);
    else
      logger.e(
          'Error -> PaymentController -> removePaymentWidget => index or key both values are not available!');
  }

  /// Function to get the Payment Methods
  PaymentAccount? getCashOrFirstAllowedPayment() {
    PaymentAccount? _enabledPaymentOption;

    List<BusinessLocationModel> businessLocations =
        AppStorage.getBusinessDetailsData()?.businessData?.locations ?? [];

    if (businessLocations.isEmpty) return null;

    for (int i = 0; i < businessLocations.length; i++) {
      if (businessLocations[i].id ==
          regCtrlObj.openedRegisterStatus?.locationId) {
        // first priority is to find payment information against cash
        _enabledPaymentOption = businessLocations[i]
            .paymentAccount
            ?.firstWhereOrNull((element) => element.paymentMethod == 'cash');

        // if enabled payment option is still null, find very first enabled payment information
        if (_enabledPaymentOption == null) {
          _enabledPaymentOption = businessLocations[i]
              .paymentAccount
              ?.firstWhereOrNull((element) => element.isEnabled);
        }
        break;
      }
    }

    return _enabledPaymentOption;
  }

  List<PaymentAccount> getAllowedPayments() {
    List<PaymentAccount> _enabledPaymentOptionsList = [];

    List<BusinessLocationModel> businessLocations =
        AppStorage.getBusinessDetailsData()?.businessData?.locations ?? [];

    if (businessLocations.isEmpty) return [];

    if (businessLocations.length > 1) {
      for (int i = 0; i < businessLocations.length; i++) {
        // if (businessLocations[i].id ==
        //     regCtrlObj.openedRegisterStatus?.locationId) {
        for (int j = 0; j < businessLocations[i].paymentAccount!.length; j++) {
          if (businessLocations[i].paymentAccount?[j] != null &&
              businessLocations[i].paymentAccount![j].isEnabled) {
            _enabledPaymentOptionsList
                .add(businessLocations[i].paymentAccount![j]);
            print(businessLocations[0].paymentAccount![j]);
          }
        }
        // }
      }
    }
    // else {
    //   for (int j = 0; j < businessLocations.first.paymentAccount!.length; j++) {
    //     if (businessLocations.first.paymentAccount?[j] != null &&
    //         businessLocations.first.paymentAccount![j].isEnabled) {
    //       _enabledPaymentOptionsList
    //           .add(businessLocations.first.paymentAccount![j]);
    //     }
    //   }
    // }

    logger.i('Payment options => $_enabledPaymentOptionsList');
    return _enabledPaymentOptionsList;
  }

  /// payment information store krny k leay titans wala method
  /// (field ke value identifier k against object me store krna or usi object ko further pass krna)
  /// but not in use
  // Map<String, dynamic> paymentInformation = {};
  // addOrUpdatePaymentFieldsInformation() {
  //   // paymentInformation.addAllIf(condition, values);
  // }

  String? _calculateRemainingAmountForCheckout(double? totalAmount) {
    double enteredAmountToPay = totalAmount ?? 0.0;
    if (paymentWidgetList.length > 0) {
      for (var pay in paymentWidgetList) {
        enteredAmountToPay -=
            (double.tryParse('${pay.amountCtrl.text}') ?? 0.0);
      }
    }
    return AppFormat.doubleToStringUpTo2(enteredAmountToPay.toString());
  }

  /// helper functions
  bool isSelectedPaymentOptionCheque(
      {Key? key, int? index, String? selectedPaymentMethod}) {
    if (key != null) {
      return paymentWidgetList
              .firstWhere((_paymentWidget) => _paymentWidget.key == key)
              .selectedPaymentOption
              ?.paymentMethod ==
          AppValues.chequeMethod;
    } else if (index != null) {
      return paymentWidgetList[index].selectedPaymentOption?.paymentMethod ==
          AppValues.chequeMethod;
    } else if (selectedPaymentMethod != null) {
      return selectedPaymentMethod == AppValues.chequeMethod;
    } else {
      logger.e(
          'Error -> PaymentController -> isSelectedPaymentOptionCheque => index or key both values are not available!');
      return false;
    }
  }

  bool isSelectedPaymentOptionCash(
      {Key? key, int? index, String? selectedPaymentMethod}) {
    if (key != null) {
      return paymentWidgetList
              .firstWhere((_paymentWidget) => _paymentWidget.key == key)
              .selectedPaymentOption
              ?.paymentMethod ==
          AppValues.cashMethod;
    } else if (index != null) {
      return paymentWidgetList[index].selectedPaymentOption?.paymentMethod ==
          AppValues.cashMethod;
    } else if (selectedPaymentMethod != null) {
      return selectedPaymentMethod == AppValues.cashMethod;
    } else {
      logger.e(
          'Error -> PaymentController -> isSelectedPaymentOptionCheque => index or key both values are not available!');
      return false;
    }
  }

  double totalPayingAmount() {
    double totalPayingAmount = 0.0;
    for (int i = 0; i < paymentWidgetList.length; i++) {
      totalPayingAmount +=
          (double.tryParse('${paymentWidgetList[i].amountCtrl.text}') ?? 0.0);
    }
    return totalPayingAmount;
  }

  void clearAllPaymentControllerInformation() {
    sellNoteCtrl.clear();
    staffNoteCtrl.clear();
    paymentWidgetList.clear();
  }

  void clearAllAddPaymentControllerInformation() {
    amountCtrl.clear();
    transactionNoCtrl.clear();
    checkNoCtrl.clear();
    paymentNoteCtrl.clear();
    paymentAccountCtrl.clear();
    fileNameCtrl.clear();
    paymentMethodCtrl.clear();
    accountIdCtrl.clear();
  }

  // Request Fields for CheckOut Order Create
  fieldsForCheckout(http.MultipartRequest request) {
    print('for api');
    print(paymentMethodCtrl.text);
    for (int checkoutIndex = 0;
        checkoutIndex < paymentWidgetList.length;
        checkoutIndex++) {
      request.fields['amount[$checkoutIndex]'] =
          '${paymentWidgetList[checkoutIndex].amountCtrl.text}';
      request.fields['method[$checkoutIndex]'] =
          '${paymentMethodCtrl.text}'; //'custom_pay_1';
      // '${paymentWidgetList[checkoutIndex].selectedPaymentOption?.paymentMethod}';
      request.fields['account_id[$checkoutIndex]'] = '27';
      // '${paymentWidgetList[checkoutIndex].selectedPaymentOption?.account?.id}';
      request.fields['card_type[$checkoutIndex]'] = 'credit'; // debit

      if (isSelectedPaymentOptionCheque(index: checkoutIndex)) {
        request.fields['cheque_number[$checkoutIndex]'] =
            '${paymentWidgetList[checkoutIndex].checkNoCtrl.text}';
      } else if (!isSelectedPaymentOptionCash(index: checkoutIndex)) {
        request.fields['transaction_no_1[$checkoutIndex]'] =
            '${paymentWidgetList[checkoutIndex].transactionNoCtrl.text}';
      }

      request.fields['note[$checkoutIndex]'] =
          '${paymentWidgetList[checkoutIndex].paymentNoteCtrl.text}';
    }
  }

  fieldsForAddPayment(http.MultipartRequest request) {
    request.fields['amount[0]'] = '${amountCtrl.text}';
    request.fields['method[0]'] = '${paymentMethodCtrl.text}';
    // '${paymentWidgetList[checkoutIndex].selectedPaymentOption?.paymentMethod}';
    request.fields['account_id[0]'] = '${accountIdCtrl.text}'; //'27';
    // '${paymentWidgetList[checkoutIndex].selectedPaymentOption?.account?.id}';
    request.fields['card_type[0]'] = 'credit'; // debit
    request.fields['transaction_no_1[0]'] = '${transactionNoCtrl.text}';

    // if (isSelectedPaymentOptionCheque(index: checkoutIndex)) {
    //   request.fields['cheque_number[$checkoutIndex]'] =
    //       '${paymentWidgetList[checkoutIndex].checkNoCtrl.text}';
    // } else if (!isSelectedPaymentOptionCash(index: checkoutIndex)) {
    //   request.fields['transaction_no_1[$checkoutIndex]'] =
    //       '${paymentWidgetList[checkoutIndex].transactionNoCtrl.text}';
    // }

    request.fields['note[0]'] = '${paymentNoteCtrl.text}';
  }

  // method to submit payment api against order
  Future submitOrderPayment(String orderId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiUrls.orderPaymentAPI}$orderId'));

    fieldsForCheckout(request);

    logger.i(request.fields);

    request.headers.addAll(headers);

    return await request.send().then((http.StreamedResponse response) async {
      String result = await response.stream.bytesToString();
      logger.i(
          'EndPoint => ${ApiUrls.orderPaymentAPI}$orderId\nStatus Code => ${response.statusCode}\nResponse => $result');

      if (response.statusCode == 200 || response.statusCode == 201) {
        clearAllPaymentControllerInformation();
        addPaymentWidget();
        Get.back(result: true);
      } else {
        final jd = jsonDecode(result);
        showToast(jd["message"]);
        return null;
      }
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

  // method to submit payment for sell page
  Future addPaymentForSellPage(String orderId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiUrls.orderPaymentAPI}$orderId'));

    fieldsForAddPayment(request);

    logger.i(request.fields);

    request.headers.addAll(headers);

    return await request.send().then((http.StreamedResponse response) async {
      String result = await response.stream.bytesToString();
      logger.i(
          'EndPoint => ${ApiUrls.orderPaymentAPI}$orderId\nStatus Code => ${response.statusCode}\nResponse => $result');

      if (response.statusCode == 200 || response.statusCode == 201) {
        clearAllAddPaymentControllerInformation();
        // addPaymentWidget();
        Get.back(result: true);
      } else {
        final jd = jsonDecode(result);
        showToast(jd["message"]);
        return null;
      }
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }
}
