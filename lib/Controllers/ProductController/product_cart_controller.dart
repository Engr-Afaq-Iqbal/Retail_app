import 'package:bizmodo_emenu/Config/enums.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '/Config/DateTimeFormat.dart';
import '/Config/utils.dart';
import '/Controllers/ContactController/ContactController.dart';
import '/Models/ProductsModel/ProductModel.dart';
import '/Models/ProductsModel/ProductVariationAndModifierModel.dart';
import '/Models/order_type_model/SellLineModel.dart';
import '/Pages/Orders/Controller/OrderController.dart';

import '../../Theme/style.dart';
import '../Tax Controller/TaxController.dart';

class ProductCartController extends GetxController {
  TextEditingController packingChargeCtrl = TextEditingController();
  TextEditingController shippingChargeCtrl = TextEditingController();
  TextEditingController shippingDetailsCtrl = TextEditingController();
  TextEditingController shippingAddressCtrl = TextEditingController();
  TextEditingController shippingStatusCtrl = TextEditingController();
  TextEditingController discountType = TextEditingController();
  TextEditingController deliveredTo = TextEditingController();
  TextEditingController discoutCtrl = TextEditingController();
  final ContactController contactCtrlObj = Get.find<ContactController>();
  final OrderController orderCtrlObj = Get.find<OrderController>();
  TaxController taxCtrlObj = Get.find<TaxController>();
  var totalPriceOfItems = 0.0;
  // String token = '';

  List<ProductModel> itemCartList = [];

  clearController() {
    discoutCtrl.clear();
    update();
  }

  clearAllSelectionFields() {
    contactCtrlObj.searchCustomerCtrl.clear();
    contactCtrlObj.nameCtrl.clear();
    contactCtrlObj.mobileNumberCtrl.clear();
    contactCtrlObj.customLabelCtrl.clear();
    packingChargeCtrl.clear();
    contactCtrlObj.cityCtrl.clear();
    contactCtrlObj.streetCtrl.clear();
    contactCtrlObj.villaBuildingApartmentCtrl.clear();
    contactCtrlObj.addressCtrl.clear();
    shippingChargeCtrl.clear();
  }

  double productTotalAmount(String? price, int quantity) {
    return double.parse('${price ?? 0.0}') * quantity;
  }

  // TODO: add item as new entry
  void updateCart(ProductModel? _item, {required bool isAdd}) {
    if (_item == null) return;

    // agr item me data yah product object available hy to yeh execute kry ga

    // agr cart empty ni to yeh block execute ho ga is me product id ke base pr pehly index find kr rahy han
    if (itemCartList.isNotEmpty) {
      int? indexOfItem;
      for (int ind = 0; ind < itemCartList.length; ind++) {
        bool _isExist =
            _isItemExistInCart(item: _item, cartProd: itemCartList[ind]);
        if (_isExist) {
          indexOfItem = ind;
          break;
        } else {
          indexOfItem = -1;
        }
      }
      logger.d('cart item index => $indexOfItem');
      if (indexOfItem != null && indexOfItem > -1) {
        debugPrint('indexOfItem >= 0');
        int theProductQuantity = itemCartList[indexOfItem].quantity;
        if (isAdd) {
          ++theProductQuantity;
        } else {
          --theProductQuantity;
        }
        // these statements are for replace the old record with new record
        itemCartList.removeAt(indexOfItem);
        itemCartList.insert(
          indexOfItem,
          _item.copyWith(
            quantity: theProductQuantity,
            productTotalPrice:
                calculateItemTotalPrice(_item, theProductQuantity),
          ),
        );
        update();
        return;
      }
    }

    // agr cart empty ho ga to item add kr rahy han (only first and single time he chly ge condition)
    itemCartList.add(_item.copyWith(
      quantity: 1,
      productTotalPrice: calculateItemTotalPrice(_item, 1),
    ));
    update();
    return;
  }

  double calculateItemTotalPrice(ProductModel _item, int _itemQuantity) {
    double _price = 0.0;
    try {
      if (_item.productVariations.isNotEmpty &&
          _item.productVariations.first.variations.isNotEmpty) {
        VariationModel _productVariation =
            _item.productVariations.first.variations.first;
        _price = double.parse(
                '${_item.taxType == TaxType.INCLUSIVE ? _productVariation.sellPriceIncTax : _productVariation.defaultSellPrice}') *
            _itemQuantity;
        if (_item.modifier.isNotEmpty) {
          // TODO: calculate the modifier price too
        }
      }
    } catch (e) {
      logger.wtf('Error to calculate the item total price => $e');
    }
    return _price;
  }

  bool _isItemExistInCart(
      {required ProductModel item, required ProductModel cartProd}) {
    bool _isProdIdMatch = false,
        _isModifierMatch = false,
        _isVariationMatch = false;

    // product id
    //
    //
    // agr product id same dekhny ko mily to he modifiers ke condition ko test krwana hy
    _isProdIdMatch = (item.id == cartProd.id);

    // modifiers
    //
    //
    // agr modifiers ke length equal hy to further variations ke condition test ke jaay ge ni to not exist ka flag return kr dena hy
    if (_isProdIdMatch &&
        item.modifier.length == 0 &&
        cartProd.modifier.length == 0) {
      // means the item is without any modifier
      return true;
    } else if (_isProdIdMatch &&
        (item.modifier.length == cartProd.modifier.length)) {
      // extract the already existed modifier ids and store in new array
      List<ModifierModel> cartModifiers = [...cartProd.modifier];

      debugPrint('extracted modifier ids length => ${cartModifiers.length}');

      for (int i = 0; i < item.modifier.length; i++) {
        debugPrint(
            'item modifier id => ${item.modifier[i].productModifier.id}');
        bool isEnyMatchInItr = false;
        //
        //
        for (int j = 0; j < cartModifiers.length; j++) {
          debugPrint(
              'cart modifier id => ${cartModifiers[j].productModifier.id}');
          //
          //
          if (item.modifier[i].productModifier.id ==
              cartModifiers[j].productModifier.id) {
            //
            //
            _isVariationMatch = isVariationsSame(
              itemProdVariations: item.modifier[i].productModifier.variations,
              cartProdVariations: cartModifiers[j].productModifier.variations,
            );
            //
            //
            if (_isVariationMatch) {
              _isModifierMatch = true;
              isEnyMatchInItr = true;
              cartModifiers.removeAt(j);
              break;
            }
            //
            //
          } else {
            _isModifierMatch = false;
          }
          //
          //
        }
        //
        //
        if (!isEnyMatchInItr) {
          _isModifierMatch = false;

          break;
        }
      }
    }

    // Variation
    //
    //
    // agr modifier exist krta hy or modifier variations ke length equal hy to yeh variations pe condition apply kren gy
    if (_isModifierMatch && _isVariationMatch) {
      // extract modifier variations ids and store in new array
      // List<int> cartModifierVariationIds = [], itemModifierVariationIds = [];
      // cartProd.modifier.forEach(
      //   (element) {
      //     if (!cartModifierVariationIds.contains(element.productModifier.id))
      //       cartModifierVariationIds.add(element.productModifier.id);
      //   },
      // );

      return true;
    }

    //
    //
    //
    return false;
  }

  bool isVariationsSame(
      {required List<VariationModel> itemProdVariations,
      required List<VariationModel> cartProdVariations}) {
    bool _isVariationMatch = false;

    // extract modifier variations ids and store in new array
    List<int> cartModifierVariationIds = [], itemModifierVariationIds = [];
    cartProdVariations.forEach(
      (element) {
        if (!cartModifierVariationIds.contains(element.id))
          cartModifierVariationIds.add(element.id);
      },
    );
    itemProdVariations.forEach(
      (element) {
        if (!itemModifierVariationIds.contains(element.id))
          itemModifierVariationIds.add(element.id);
      },
    );
    debugPrint('Item Modifier Variation IDs => $itemModifierVariationIds');
    debugPrint('Cart Modifier Variation IDs => $cartModifierVariationIds');

    // compare the ids and remove item extracted id on match
    if (cartModifierVariationIds.length == itemModifierVariationIds.length) {
      for (int i = 0; i < itemModifierVariationIds.length; i++) {
        debugPrint(
            'item modifier variation id => ${itemModifierVariationIds[i]}');
        bool isEnyMatchInItr = false;

        for (int j = 0; j < cartModifierVariationIds.length; j++) {
          debugPrint(
              'cart modifier variation id => ${cartModifierVariationIds[j]}');
          if (itemModifierVariationIds[i] == cartModifierVariationIds[j]) {
            _isVariationMatch = true;
            isEnyMatchInItr = true;
            cartModifierVariationIds.removeAt(j);
            break;
          } else {
            _isVariationMatch = false;
          }
        }
        if (!isEnyMatchInItr) {
          _isVariationMatch = false;
          break;
        }
      }
    }
    return _isVariationMatch;
  }

  void addItemQuantity(ProductModel cartItem) {
    cartItem.quantity++;
    cartItem.productTotalPrice =
        calculateItemTotalPrice(cartItem, cartItem.quantity);
    update();
  }

  void removeItemQuantity(ProductModel cartItem) {
    cartItem.quantity--;
    cartItem.productTotalPrice =
        calculateItemTotalPrice(cartItem, cartItem.quantity);
    update();
  }

  void deleteFromCart(ProductModel item) {
    AppStyles.deleteConfirmationDialog(confirmBtnAct: () {
      itemCartList.remove(item);
      update();
    });
  }

  void deleteFromProdPage(ProductModel item) {
    itemCartList.remove(item.id);
    update();
  }

  // bool isItemInCart(int _itemId) {
  //   return itemCartList.indexWhere((prod) => prod.id == _itemId) != -1;
  // }

  bool isItemInCart(int _itemId) {
    return itemCartList.indexWhere((prod) => prod.id == _itemId) != -1;
  }

  String countItemInCart(int _itemId) {
    int totalCount = 0;
    try {
      List<ProductModel> allSameItems =
          itemCartList.where((prod) => prod.id == _itemId).toList();
      allSameItems.forEach((prod) => totalCount = totalCount + prod.quantity);
      return '$totalCount';
    } catch (_err) {
      return '$totalCount';
    }
  }

  // ----- Amount Calculation Functions Start
  String subTotalAmount(
      {List<ProductModel>? items, double ordersItemsSubTotalAmount = 0.0}) {
    double itemsPriceCount = 0.0;
    try {
      for (var _itr in items ?? itemCartList) {
        // itemsPriceCount += _itr.productTotalPrice;
        itemsPriceCount += double.parse(
                '${_itr.productVariations.first.variations.first.defaultSellPrice ?? 0.0}') *
            _itr.quantity;
      }
    } catch (e) {
      logger.e('Error to calculate sub total amount => $e');
    }
    totalPriceOfItems = itemsPriceCount;
    return AppFormat.doubleToStringUpTo2(
            '${itemsPriceCount + ordersItemsSubTotalAmount}') ??
        '0';
  }

  String subTotal(
      {List<ProductModel>? items, double ordersItemsSubTotalAmount = 0.0}) {
    double itemsPriceCount = 0.0;
    try {
      for (var _itr in items ?? itemCartList) {
        // itemsPriceCount += _itr.productTotalPrice;
        itemsPriceCount += double.parse(
                '${_itr.productVariations.first.variations.first.sellPriceIncTax ?? 0.0}') *
            _itr.quantity;
      }
    } catch (e) {
      logger.e('Error to calculate sub total amount => $e');
    }

    return AppFormat.doubleToStringUpTo2(
            '${itemsPriceCount + ordersItemsSubTotalAmount}') ??
        '0';
  }

  //calculate discount amount

  double totalDiscountPercentage({
    List<ProductModel>? items,
    double ordersItemsSubTotalAmount = 0.0,
  }) {
    double itemsDiscountCount = 0.0;

    try {
      for (var _itr in items ?? itemCartList) {
        // itemsPriceCount += _itr.productTotalPrice;
        itemsDiscountCount += ((double.tryParse(discoutCtrl.text) ?? 0) / 100) *
            (double.parse(
                    '${_itr.productVariations.first.variations.first.sellPriceIncTax ?? 0.0}') *
                _itr.quantity);
        print(
            '${_itr.productVariations.first.variations.first.defaultSellPrice}');
        print('$itemsDiscountCount');
      }
    } catch (e) {
      logger.e('Error to calculate sub total amount => $e');
    }

    return double.parse(
        AppFormat.doubleToStringUpTo2(itemsDiscountCount.toString())!);
    // print(double.parse(discoutCtrl.text));
    // print(totalPriceOfItems);
    // double finalPercentagePrice =
    //     (double.parse(discoutCtrl.text) / 100) * totalPriceOfItems;
    // discoutCtrl.text =
    //     AppFormat.doubleToStringUpTo2(finalPercentagePrice.toString())!;
    // print(finalPercentagePrice);
    // return finalPercentagePrice;
  }

  // double totalTaxAmount(
  //     {List<ProductModel>? items, ordersItemsTotalTax = 0.0}) {
  //   // (double.parse(totalAmount())/100)*tax; // TODO: tax calculation
  //   double itemsTax = 0.0;
  //   try {
  //     for (var _itr in items ?? itemCartList) {
  //       double _itemPrice = double.parse(
  //           '${_itr.productVariations.first.variations.first.sellPriceIncTax ?? 0.0}');
  //       int _itemTax = _itr.productTax?.amount ?? 0;
  //       itemsTax += ((_itemPrice * _itemTax) / 100) * _itr.quantity;
  //     }
  //   } catch (e) {
  //     logger.e('Error to calculate sub total amount => $e');
  //   }
  //   return double.parse(
  //       AppFormat.doubleToStringUpTo2('${itemsTax + ordersItemsTotalTax}')!);
  // }

  double totalTaxAmountWithDiscount(
      {List<ProductModel>? items, ordersItemsTotalTax = 0.0, taxCtrlObj}) {
    double itemsTax = 0.0;
    try {
      itemsTax = (double.parse(subTotalAfterDiscount(
                  items: items,
                  ordersItemsSubTotalAmount: ordersItemsTotalTax)) *
              double.parse(
                  taxCtrlObj.listTaxModel?.data?[0].amount.toString() ?? '0')) /
          ((double.parse(
                  taxCtrlObj.listTaxModel?.data?[0].amount.toString() ?? '0')) +
              100);
    } catch (e) {
      logger.e('Error to calculate sub total amount => $e');
    }
    print('Items Tax:::::::::::::');
    print('${itemsTax + ordersItemsTotalTax}');
    return double.parse(
        AppFormat.doubleToStringUpTo2('${itemsTax + ordersItemsTotalTax}')!);
  }

  double totalTaxAmount(
      {List<ProductModel>? items, ordersItemsTotalTax = 0.0, taxCtrlObj}) {
    // taxCtrlObj.fetchListTax();
    // (double.parse(totalAmount())/100)*tax; // TODO: tax calculation
    double itemsTax = 0.0;
    try {
      for (var _itr in items ?? itemCartList) {
        double _itemPrice = double.parse(
            '${_itr.productVariations.first.variations.first.sellPriceIncTax ?? 0.0}');
        int _itemTax = _itr.productTax?.amount ?? 0;
        itemsTax += (_itemPrice *
                _itr.quantity *
                double.parse(
                    taxCtrlObj.listTaxModel?.data?[0].amount.toString() ??
                        '0')) /
            ((double.parse(
                    taxCtrlObj.listTaxModel?.data?[0].amount.toString() ??
                        '0')) +
                100);
      }
      print('Items Tax:::::::::::::');
      print(itemsTax);
    } catch (e) {
      logger.e('Error to calculate sub total amount => $e');
    }
    print('2nd one');
    print('${itemsTax + ordersItemsTotalTax}');

    return double.parse(
        AppFormat.doubleToStringUpTo2('${itemsTax + ordersItemsTotalTax}')!);
  }

  String subTotalAfterDiscount({
    List<ProductModel>? items,
    double ordersItemsSubTotalAmount = 0.0,
  }) {
    double itemsPriceCount = 0.0;
    try {
      for (var _itr in items ?? itemCartList) {
        // itemsPriceCount += _itr.productTotalPrice;
        itemsPriceCount += double.parse(
                '${_itr.productVariations.first.variations.first.sellPriceIncTax ?? 0.0}') *
            _itr.quantity;
      }
      if (discountType.text == 'Fixed') {
        itemsPriceCount = (itemsPriceCount - double.parse(discoutCtrl.text));
      } else if (discountType.text == 'Percentage') {
        itemsPriceCount = itemsPriceCount -
            totalDiscountPercentage(
              ordersItemsSubTotalAmount: totalOrderedItemsAmount(),
            );
      }
    } catch (e) {
      logger.e('Error to calculate sub total amount => $e');
    }

    return AppFormat.doubleToStringUpTo2(
            '${itemsPriceCount + ordersItemsSubTotalAmount}') ??
        '0';
  }

  String finalTotalAmount(
      {List<ProductModel>? items,
      double ordersItemsSubTotalAmount = 0.0,
      taxCtrlObj}) {
    print(
        '${double.parse('${subTotalAfterDiscount(items: items, ordersItemsSubTotalAmount: ordersItemsSubTotalAmount)}') - totalTaxAmountWithDiscount(items: items, taxCtrlObj: taxCtrlObj, ordersItemsTotalTax: totalOrderedTaxAmount())}');
    return AppFormat.doubleToStringUpTo2(
          '${double.parse('${subTotalAfterDiscount(items: items, ordersItemsSubTotalAmount: ordersItemsSubTotalAmount)}')}', //- totalTaxAmountWithDiscount(items: items, taxCtrlObj: taxCtrlObj, ordersItemsTotalTax: totalOrderedTaxAmount())}',
        ) ??
        '0';
  }

  String finalAmount(
      {List<ProductModel>? items, double ordersItemsSubTotalAmount = 0.0}) {
    //  TODO: (Total Amount - Discount) + Tax Amount
    //  TODO: Discount
    return AppFormat.doubleToStringUpTo2(
          '${double.parse('${subTotalAmount(items: items, ordersItemsSubTotalAmount: ordersItemsSubTotalAmount)}') + totalTaxAmount()}',
        ) ??
        '0';
  }

  String totalItemPrice(String? price, int? quantity) {
    if (price == null || quantity == null) return '-';
    return AppFormat.doubleToStringUpTo2('${quantity * double.parse(price)}') ??
        '-';
  }

  double totalOrderedItemsAmount() {
    return 0.0;
  }

  double totalOrderedDiscountAmount() {
    return 0.0;
  }

  double totalOrderedTaxAmount() {
    return 0.0;
  }
  // ----- Amount Calculation Functions End

  clearOnOrderPlaceSuccess() {
    itemCartList.clear();
    contactCtrlObj.contactId = null;
    orderCtrlObj.isOrderUpdating = false;
    // Get.find<PaymentController>().clearAllPaymentControllerInformation();
    update();
  }

  // Request Fields for Active Order Create
  activeOrderFields(http.MultipartRequest request) {
    request.fields['is_suspend'] = '1';
    request.fields['payment_status'] =
        'due'; // for order suspend = due, cash = paid / partial,
  }

  checkoutFieldsForCart(http.MultipartRequest request) {
    // PaymentController _paymentCtrlObj = Get.find<PaymentController>();
    // request.fields['is_suspend'] = '0';
    // request.fields['payment_status'] =
    // _paymentCtrlObj.totalPayingAmount() < double.parse(finalAmount())
    //     ? 'partial'
    //     : 'paid'; // for order suspend = due, cash = paid / partial,
    //
    // // Get.find<PaymentController>().fieldsForCheckout(request);
    // /// OR
    // for (int checkoutIndex = 0;
    // checkoutIndex < _paymentCtrlObj.paymentWidgetList.length;
    // checkoutIndex++) {
    //   request.fields['amount[$checkoutIndex]'] =
    //   '${_paymentCtrlObj.paymentWidgetList[checkoutIndex].amountCtrl.text}';
    //   request.fields['method[$checkoutIndex]'] =
    //   '${_paymentCtrlObj.paymentWidgetList[checkoutIndex].selectedPaymentOption?.paymentMethod}';
    //   request.fields['account_id[$checkoutIndex]'] =
    //   '${_paymentCtrlObj.paymentWidgetList[checkoutIndex].selectedPaymentOption?.account?.id}';
    //   request.fields['card_type[$checkoutIndex]'] = 'credit'; // debit
    //
    //   if (_paymentCtrlObj.isSelectedPaymentOptionCheque(index: checkoutIndex)) {
    //     request.fields['cheque_number[$checkoutIndex]'] =
    //     '${_paymentCtrlObj.paymentWidgetList[checkoutIndex].checkNoCtrl.text}';
    //   } else if (!_paymentCtrlObj.isSelectedPaymentOptionCash(
    //       index: checkoutIndex)) {
    //     request.fields['transaction_no_1[$checkoutIndex]'] =
    //     '${_paymentCtrlObj.paymentWidgetList[checkoutIndex].transactionNoCtrl.text}';
    //   }
    //
    //   request.fields['note[$checkoutIndex]'] =
    //   '${_paymentCtrlObj.paymentWidgetList[checkoutIndex].paymentNoteCtrl.text}';
    // }
  }

  /// ----- Order Update (Start)
  // bool _isOrderUpdating = false;
  // void set isOrderUpdating(bool val) => this._isOrderUpdating = val;
  // SaleOrderDataModel orderItemsList;
  //
  // void deleteFromOrderItems(item) {
  //   int orderItemIndex = orderItemsList.indexOf(item);
  //   orderItemsList.removeAt(orderItemIndex);
  //   update();
  // }

  // API integration for update order

  removeOrderedItemQuantity(SellLine sellLineItem) {
    sellLineItem.quantity--;
    // cartItem.productTotalPrice = calculateItemTotalPrice(cartItem, cartItem.quantity);
    orderCtrlObj.update();
  }

  deleteOrderedItemFromCart(SellLine sellLineItem) {
    AppStyles.deleteConfirmationDialog(confirmBtnAct: () {
      /// TODO: API call to delete item from db too.
      orderCtrlObj.singleOrderData?.sellLines.remove(sellLineItem);
      orderCtrlObj.update();
    });
  }

  addOrderedItemQuantity(SellLine sellLineItem) {
    sellLineItem.quantity++;
    // cartItem.productTotalPrice = calculateItemTotalPrice(cartItem, cartItem.quantity);
    orderCtrlObj.update();
  }

  String saleItemTotalAmount(String? _itemPriceIncTax, int? _itemQuantity) {
    double _itemsPriceCount = 0.0;
    try {
      // for (var _itr in items ?? itemCartList) {
      //   _itemsPriceCount += _itr.productTotalPrice;
      // }
      if (_itemPriceIncTax != null) {
        _itemsPriceCount =
            double.parse('$_itemPriceIncTax') * (_itemQuantity ?? 1);
      }
    } catch (e) {
      logger.e('Error to calculate total amount => $e');
    }
    return AppFormat.doubleToStringUpTo2('${_itemsPriceCount}') ?? '0';
  }

  // String orderedTotalTaxAmount() {
  //   // (taxAmount/100)*taxValue // TODO: tax calculation
  //   return '0';
  // }
  //
  // String orderedFinalAmount() {
  //   //  TODO: (Total Amount - Discount) + Tax Amount
  //   return totalAmount();
  // }

  // ----- Update Amount Calculation Function End

  /// ----- Order Update (End)

  ///Function for firebase messaging
  // sendNotificationofOrderCompletion(
  //     {required String token,
  //     required String id,
  //     required String body,
  //     required String title}) async {
  //   Map<String, String> headerMap = {
  //     'Content-Type': 'application/json',
  //     'Authorization': serverToken,
  //   };
  //
  //   Map notificationMap = {'body': body, 'title': title};
  //
  //   Map dataMap = {
  //     'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //     'id': '1',
  //     'status': 'done',
  //     'ride_request_id': id
  //   };
  //
  //   Map sendNotificationMap = {
  //     "notification": notificationMap,
  //     "data": dataMap,
  //     "priority": "high",
  //     "to": token,
  //   };
  //
  //   var res = await http.post(
  //     Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //     headers: headerMap,
  //     body: jsonEncode(sendNotificationMap),
  //   );
  //   print('response:::::::::::::::::::::');
  //   print(res.body);
  // }
}
