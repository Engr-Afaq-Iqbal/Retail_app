import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '/Config/const.dart';
import '/Controllers/ContactController/ContactController.dart';
import '/Models/order_type_model/order_service_model.dart';
import '/Pages/Table/TablesPage.dart';
import '/Pages/home_page.dart';
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
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      debugPrint('StackTrace => $stackTrace');
      throw '$error';
    });
  }

  // type of service selection
  bool isButtonDisabled = true;
  bool showButtonTable = true;
  OrderServiceDataModel? selectedOrderType;
  //ProductCartController prodCartCtrlObj = Get.find<ProductCartController>();
  bool isServiceTypeSelectionValueUpdated = false;
  typeOfServiceTapAction(OrderServiceDataModel? v,
      {required bool isUpdate, required bool isInputFieldsAllowed}) {
    final ContactController contactCtrlObj = Get.find<ContactController>();
    contactCtrlObj.contactId = null;
    selectedOrderType = v;
    update();

    if (selectedOrderType?.name == AppValues.dineIn) {
      if (isUpdate) {
        isServiceTypeSelectionValueUpdated = true;
        isButtonDisabled = false;
        showButtonTable = true;
        update();
        Get.back();
        // Get.to(CartPage());
        return;
      }
      // TODO: testing required
      // contactCtrlObj.contactId = AppValues.walkInCustomerID;
      isButtonDisabled = false;
      showButtonTable = true;
      update();
      Get.to(() => TablesPage());
    } else if (!isInputFieldsAllowed) {
      if (isUpdate) {
        // Get.back();
        return;
      }
      isButtonDisabled = true;
      showButtonTable = false;
      update();
      Get.to(() => HomePage());
    }
  }
}
