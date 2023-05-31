import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../Models/order_type_model/SaleOrderModel.dart';
import '../AllSalesController/allSalesController.dart';

class ReceiptsController extends GetxController {
  String totalAmount = '0';
  SaleOrderModel? order;
  void markUnMarkOrder(SaleOrderDataModel orderSellLine, {int? index}) {
    // --------------------- is item cooked or not condition with popup
    // if (!isItCooked(index: index)) {
    //   showToast('Item is not Cooked yet!');
    //   return;
    // }

    orderSellLine.isSelected = !orderSellLine.isSelected;
    if (orderSellLine.isSelected == true) {
      totalAmount =
          '${double.parse(totalAmount) + double.parse(orderSellLine.finalTotal!)}';
    } else if (orderSellLine.isSelected == false) {
      totalAmount =
          '${double.parse(totalAmount) - double.parse(orderSellLine.finalTotal!)}';
    }
    print(orderSellLine.isSelected);
    print(totalAmount);
    // if (singleOrderData != null) {
    //   for (int i = 0; i < singleOrderData!.; i++) {
    //     if (singleOrderData!.sellLines[i].isSelected) {
    //       totalAmount =
    //           '${double.parse(totalAmount) + double.parse(singleOrderData!.finalTotal!)}';
    //     }
    //   }
    // }
    update();
  }

  SaleOrderDataModel? singleOrderData;
  List<SaleOrderDataModel>? listSaleOrderDataModel;
  markUnMarkAllOrder() {
    // listSaleOrderDataModel
    //     ?.forEach((element) => element.isSelected = !element.isSelected);
    if (listSaleOrderDataModel != null) {
      for (int i = 0; i < listSaleOrderDataModel!.length; i++) {
        listSaleOrderDataModel?[i].isSelected =
            !listSaleOrderDataModel![i].isSelected;
        totalAmount =
            '${double.parse(totalAmount) + double.parse(listSaleOrderDataModel?[i].finalTotal ?? '0')}';
        print(totalAmount);
      }
    }

    print(totalAmount);
    update();
  }
}
