import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../exception_controller.dart';
import '/Models/order_type_model/order_service_model.dart';
import '/Services/api_services.dart';
import '/Services/api_urls.dart';

class OrderTypeSelectionController extends GetxController {
  // RxString selectedOrderType = "".obs;
  // RxList<String> orderTypes = <String>[
  //   "Dine-In",
  //   "Take-Away",
  //   "Delivery",
  // ].obs;

  OrderServiceModel? orderServiceTypes;

  fetchOrderTypes() async {
    return await ApiServices.getMethod(feedUrl: ApiUrls.getOrderTypes)
        .then((_res) {
      if (_res == null) return;

      /// TODO: parsing and move from list to object
      orderServiceTypes = orderServiceModelFromJson(_res);
      update();
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      debugPrint('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.unitListApi, error, stackTrace),
      );
      throw '$error';
    });
  }

  // type of service selection
  bool isButtonDisabled = true;
  bool showButtonTable = true;
  OrderServiceDataModel? selectedOrderType;
  //ProductCartController prodCartCtrlObj = Get.find<ProductCartController>();
  bool isServiceTypeSelectionValueUpdated = false;
}
