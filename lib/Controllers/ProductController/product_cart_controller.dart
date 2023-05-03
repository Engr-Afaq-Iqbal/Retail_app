import 'dart:convert';

import 'package:bizmodo_emenu/Config/enums.dart';
import 'package:bizmodo_emenu/Models/TableManagementModel/table_management_model.dart';
import 'package:bizmodo_emenu/Models/order_type_model/order_service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '/Config/DateTimeFormat.dart';
import '/Config/app_config.dart';
import '/Config/const.dart';
import '/Config/utils.dart';
import '/Controllers/ContactController/ContactController.dart';
import '/Controllers/ProductController/all_products_controller.dart';
import '/Controllers/TableSelectionController/table_management_controller.dart';
import '/Models/ProductsModel/ProductModel.dart';
import '/Models/ProductsModel/ProductVariationAndModifierModel.dart';
import '/Models/order_type_model/SellLineModel.dart';
import '/Pages/Orders/Controller/OrderController.dart';
import '/Pages/Tabs/View/TabsPage.dart';
import '/Pages/orderPlaced.dart';
import '/Services/api_services.dart';
import '/Services/api_urls.dart';
import '/Services/storage_services.dart';
import '../../Theme/style.dart';
import '../OrderController/order_type_controller.dart';
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
  final AllProductsController allProdCtrlObj =
      Get.find<AllProductsController>();
  final TableSelectionController tableManageCtrlObj =
      Get.find<TableSelectionController>();
  final OrderTypeSelectionController orderManageCtrlObj =
      Get.find<OrderTypeSelectionController>();
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
    tableManageCtrlObj.selectedTables.clear();
    contactCtrlObj.contactId = null;
    orderManageCtrlObj.selectedOrderType = null;
    orderCtrlObj.isOrderUpdating = false;
    tableManageCtrlObj.isTableSelectionValueUpdated = false;
    orderManageCtrlObj.isServiceTypeSelectionValueUpdated = false;
    // Get.find<PaymentController>().clearAllPaymentControllerInformation();
    update();
  }

  Future placeOrder() async {
    // debugPrint('----- old api method calling start');
    // apiCallingMethodUsingApiService();
    // debugPrint('----- old api method calling start');

    // working tested
    debugPrint('----- new api method calling start');
    createOrderOrCheckout(/*isCheckout: isCheckout*/);
    debugPrint('----- new api method calling end');
  }

  createOrderOrCheckout(/*{required bool isCheckout}*/) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${AppConfig.baseUrl}${ApiUrls.createOrder}'));

    /*

      _fields['business_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.id ?? AppStorage.getLoggedUserData()?.data.businessId}';
    _fields['location_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.data.locationId}';
    _fields['selling_price_group_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.sellingPriceGroupId}';
    _fields['invoice_no'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.invoiceSchemeId}';

    // res waiter id and created by ???
    _fields['res_waiter_id'] = '${AppStorage.getLoggedUserData()?.data.id}';
    _fields['created_by'] = '${AppStorage.getLoggedUserData()?.data.id}';

    /*
    1 for Dine In / Walk In Customers
    created contact first and that id need to pass for take away and delivery
    */
    _fields['contact_id'] = orderManageCtrlObj.contactId ?? '';
    _fields['is_suspend'] =
        '${(orderManageCtrlObj.selectedOrderType.value == orderManageCtrlObj.orderTypes.first) ? 1 : 0}';
    _fields['type_of_service'] =
        '${orderManageCtrlObj.orderTypes.firstWhere((orderType) => orderType == orderManageCtrlObj.selectedOrderType.value)}';

    _fields['type'] = 'sell';
    _fields['status'] = 'final'; // due, paid , partial ('final' value api me the)

    // if user select Dine In of order type/service
    _fields['res_table_id'] = '${tableManageCtrlObj.selectedTables.first.id}';

    _fields['transaction_date'] = '${DateTime.now()}'; // on payment success

    // payment sy related kam
    _fields['total_before_tax'] = totalAmount();
    _fields['discount_type'] = 'percentage';
    _fields['tax_amount'] = '0';
    _fields['discount_amount'] = '0'; // TODO _fields['tax_amount'] = totalTaxAmount();
    _fields['final_total'] = finalAmount();
    _fields['payment_status'] = 'due'; // for order suspend = due, cash = paid / partial,

    for (int i = 0; i < itemCartList.length; i++) {
      _fields['product_id[$i]'] = '${itemCartList[i].id}';
      _fields['variation_id[$i]'] = '${itemCartList[i].id}';
      _fields['quantity[$i]'] = '${itemCartList[i].quantity}';

      if (itemCartList[i].productTax != null) {
        _fields['tax_id[$i]'] = '${itemCartList[i].productTax?.id}';
        _fields['item_tax[$i]'] = '${itemCartList[i].productTax?.amount}';
      }

      if (itemCartList[i].productVariations.isNotEmpty) {
        _fields['line_discount_type[$i]'] = 'fixed';
        _fields['unit_price_before_discount[$i]'] =
            '${itemCartList[i].productVariations.first.variations.first.defaultSellPrice}';
        _fields['unit_price[$i]'] =
            '${itemCartList[i].productVariations.first.variations.first.defaultSellPrice}';
        _fields['unit_price_inc_tax[$i]'] =
            '${itemCartList[i].productVariations.first.variations.first.sellPriceIncTax}';
      }
      if (itemCartList[i].modifier.isNotEmpty) {
        List<int> allModifierIds = [], allModifierVariationIds = [];
        itemCartList[i].modifier.forEach(
          (_mod) {
            if (!allModifierIds.contains(_mod.productModifier.id)) {
              _mod.productModifier.variations.forEach(
                (_vars) {
                  if (!allModifierVariationIds.contains(_vars.id)) {
                    allModifierIds.add(_mod.productModifier.id);
                    allModifierVariationIds.add(_vars.id);
                  }
                },
              );
            }
          },
        );
        _fields['parent_sell_line_id[$i]'] = '$allModifierIds';
        // _fields['variation_id[$i]'] = '$allModifierVariationIds';
      }
    }

    */

    activeOrderFields(request);

    request.fields['business_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.id ?? AppStorage.getLoggedUserData()?.staffUser.businessId}';
    request.fields['location_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}';
    request.fields['selling_price_group_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.sellingPriceGroupId}';
    request.fields['invoice_no'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.invoiceSchemeId}';

    // res waiter id and created by ???
    request.fields['res_waiter_id'] =
        '${AppStorage.getLoggedUserData()?.staffUser.id}';
    request.fields['created_by'] =
        '${AppStorage.getLoggedUserData()?.staffUser.id}';
    request.fields['added_by'] =
        '${AppStorage.getLoggedUserData()?.staffUser.id}';

    /*
    1 for Dine In / Walk In Customers
    created contact first and that id need to pass for take away and delivery
    */
    request.fields['contact_id'] = contactCtrlObj.contactId;

    // '${(orderManageCtrlObj.selectedOrderType.value == orderManageCtrlObj.orderTypes.first) ? 1 : 0}';
    request.fields['type_of_service'] =
        '${orderManageCtrlObj.selectedOrderType?.id}';
    // if user select Dine In of order type/service
    if (orderManageCtrlObj.selectedOrderType?.name == AppValues.dineIn)
      request.fields['res_table_id'] =
          '${tableManageCtrlObj.selectedTables.first.id}';

    // '${orderManageCtrlObj.orderTypes.indexWhere((orderType) => orderType == orderManageCtrlObj.selectedOrderType.value)}';

    request.fields['type'] = 'sell';
    request.fields['status'] =
        'final'; // due, paid , partial ('final' value api me the)

    request.fields['transaction_date'] =
        '${DateTime.now()}'; // on payment success

    // payment sy related kam
    request.fields['total_before_tax'] = subTotalAmount();
    request.fields['discount_type'] =
        '${discountType.text.isEmpty ? '' : discountType.text}';
    request.fields['tax_amount'] = '${totalTaxAmount()}';
    request.fields['discount_amount'] =
        '${discoutCtrl.text.isEmpty ? '' : discoutCtrl.text}';
    request.fields['final_total'] = finalTotalAmount();

    request.fields['packing_charge'] = packingChargeCtrl.text.isEmpty
        ? (orderManageCtrlObj.selectedOrderType?.packingCharge ?? '0')
        : packingChargeCtrl.text;
    request.fields['packing_charge_type'] =
        'fixed'; // TODO: also picked from service types data

    request.fields['shipping_charges'] =
        shippingChargeCtrl.text.isEmpty ? '0' : shippingChargeCtrl.text;
    request.fields['shipping_details'] =
        shippingDetailsCtrl.text.isEmpty ? '' : shippingDetailsCtrl.text;
    request.fields['shipping_address'] =
        shippingAddressCtrl.text.isEmpty ? '' : shippingAddressCtrl.text;
    request.fields['shipping_status'] =
        shippingStatusCtrl.text.isEmpty ? 'Packed' : shippingStatusCtrl.text;
    request.fields['delivered_to'] =
        deliveredTo.text.isEmpty ? '0' : deliveredTo.text;

    /*
    * -----
    * Approach 1 Start
    * -----
    */

    // List<String> prod_ids = [],
    //     variation_id = [],
    //     qty = [],
    //     tax_id = [],
    //     item_tax = [],
    //     line_disc = [],
    //     unit_price_before_disc = [],
    //     unit_price = [],
    //     unit_price_inc_tax = [];
    // for (int i = 0; i < itemCartList.length; i++) {
    //   prod_ids.add('"${itemCartList[i].id}"');
    //   variation_id.add('"${itemCartList[i].id}"');
    //   qty.add('"${itemCartList[i].quantity}"');
    //
    //   if (itemCartList[i].productTax != null) {
    //     tax_id.add('"${itemCartList[i].productTax?.id}"');
    //     item_tax.add('"${itemCartList[i].productTax?.amount}"');
    //   }
    //
    //   if (itemCartList[i].productVariations.isNotEmpty) {
    //     line_disc.add('"fixed"');
    //     unit_price_before_disc
    //         .add('"${itemCartList[i].productVariations.first.variations.first.defaultSellPrice}"');
    //     unit_price
    //         .add('"${itemCartList[i].productVariations.first.variations.first.defaultSellPrice}"');
    //     unit_price_inc_tax
    //         .add('"${itemCartList[i].productVariations.first.variations.first.sellPriceIncTax}"');
    //   }
    //     if (itemCartList[i].modifier.isNotEmpty) {
    //       List<int> allModifierIds = [], allModifierVariationIds = [];
    //       itemCartList[i].modifier.forEach(
    //         (_mod) {
    //           if (!allModifierIds.contains(_mod.productModifier.id)) {
    //             _mod.productModifier.variations.forEach(
    //               (_vars) {
    //                 if (!allModifierVariationIds.contains(_vars.id)) {
    //                   allModifierIds.add(_mod.productModifier.id);
    //                   allModifierVariationIds.add(_vars.id);
    //                 }
    //               },
    //             );
    //           }
    //         },
    //       );
    //       // request.fields['parent_sell_line_id[$i]'] = '$allModifierIds';
    //       // request.fields['variation_id[$i]'] = '$allModifierVariationIds';
    //     }
    //   }
    //
    // request.fields['product_id'] = '$prod_ids';
    // request.fields['variation_id'] = '$variation_id';
    // request.fields['quantity'] = '$qty';
    //
    // request.fields['tax_id'] = '${tax_id.first}';
    // request.fields['item_tax'] = '$item_tax';
    // request.fields['line_discount_type'] = '$line_disc';
    // request.fields['unit_price_before_discount'] = '$unit_price_before_disc';
    // request.fields['unit_price'] = '$unit_price';
    // request.fields['unit_price_inc_tax'] = '$unit_price_inc_tax';

    /*
    * -----
    * Approach 1 End
    * -----
    */

    /*
    * -----
    * Approach 2 Start
    * -----
    */

    for (int i = 0; i < itemCartList.length; i++) {
      request.fields['product_id[$i]'] = '${itemCartList[i].id}';
      request.fields['variation_id[$i]'] =
          '${itemCartList[i].productVariations.first.variations.first.id}';
      request.fields['quantity[$i]'] = '${itemCartList[i].quantity}';

      if (itemCartList[i].productTax != null) {
        // request.fields['tax_id[$i]'] = '${itemCartList[i].productTax?.id}';
        request.fields['tax_id'] = '${itemCartList[i].productTax?.id}';
      }

      if (itemCartList[i].productVariations.isNotEmpty) {
        request.fields['line_discount_type[$i]'] = 'fixed';
        request.fields['unit_price_before_discount[$i]'] =
            '${itemCartList[i].productVariations.first.variations.first.defaultSellPrice}';
        request.fields['unit_price[$i]'] =
            '${itemCartList[i].productVariations.first.variations.first.defaultSellPrice}';
        request.fields['unit_price_inc_tax[$i]'] =
            '${itemCartList[i].productVariations.first.variations.first.sellPriceIncTax}';
        request.fields['item_tax[$i]'] =
            '${(double.parse('${itemCartList[i].productVariations.first.variations.first.defaultSellPrice}') / 100) * itemCartList[i].productTax!.amount!}';
      }
      if (itemCartList[i].modifier.isNotEmpty) {
        List<int> allModifierIds = [], allModifierVariationIds = [];
        itemCartList[i].modifier.forEach(
          (_mod) {
            if (!allModifierIds.contains(_mod.productModifier.id)) {
              _mod.productModifier.variations.forEach(
                (_vars) {
                  if (!allModifierVariationIds.contains(_vars.id)) {
                    allModifierIds.add(_mod.productModifier.id);
                    allModifierVariationIds.add(_vars.id);
                  }
                },
              );
            }
          },
        );
        request.fields['parent_sell_line_id[$i]'] = '$allModifierIds';
        // request.fields['variation_id[$i]'] = '$allModifierVariationIds';
      }
    }

    /*
    * -----
    * Approach 2 End
    * -----
    */

    request.fields['additional_notes'] =
        'Place through eMenu application ... .';

    logger.i(request.fields);

    request.headers.addAll(headers);

    return await request.send().then((http.StreamedResponse response) async {
      String result = await response.stream.bytesToString();
      logger.i('EndPoint => ${request.url}'
          '\nStatus Code => ${response.statusCode}'
          '\nResponse => $result');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (orderManageCtrlObj.selectedOrderType?.name == AppValues.dineIn &&
            tableManageCtrlObj.selectedTables.isNotEmpty) {
          try {
            Get.find<TableSelectionController>().changeTableStatus(
                tableManageCtrlObj.selectedTables.first.id, TableStatus.BUSY);
          } catch (e) {
            debugPrint(
                'Error -> sepNewApiCallingMethod -> API response success -> changeTableStatus: $e');
          }
        }
        // sendNotificationofOrderCompletion(
        //   token: token,
        //   id: AppStorage.getLoggedUserData()!.staffUser.id.toString(),
        //   body: 'Order Created Successfully ',
        //   title: 'Order Created',
        // );
        clearOnOrderPlaceSuccess();
        await Get.to(() => OrderPlaced());
        Get.find<OrderTypeSelectionController>().isButtonDisabled = false;
        Get.find<OrderTypeSelectionController>().update();

        ///Function to clear All Controller values
        clearAllSelectionFields();
        Get.offAll(TabsPage());
        // Get.offAll(OrderTypeSelection());
        // showDialog(
        //   context: Get.context!,
        //   builder: (BuildContext context) => _buildAboutDialog(context),
        // );
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

  updateOrder() async {
    if (orderCtrlObj.singleOrderData?.id == null) {
      showToast('Reference for update order is missing!');
      return;
    }

    // simplePutMethod();

    /// Working with 2nd approach
    multipartPutMethod();

    /// Worked but old method and invoice no issue was there
    // requestPutMethod();
  }

  simplePutMethod() async {
    Map<String, dynamic> _fields = {};

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
    };
    // var request = http.MultipartRequest(
    //     'PUT', Uri.parse('${ApiUrls.updateOrder}${orderCtrlObj.singleOrderData?.id}'));

    _fields['business_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.id ?? AppStorage.getLoggedUserData()?.staffUser.businessId}';
    _fields['location_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}';
    _fields['selling_price_group_id'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.sellingPriceGroupId}';
    _fields['invoice_no'] =
        '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.invoiceSchemeId}';
    _fields['service_staff_id'] =
        '${AppStorage.getLoggedUserData()?.staffUser.id}';

    /*
    1 for Dine In / Walk In Customers
    created contact first and that id need to pass for take away and delivery
    */
    _fields['contact_id'] = contactCtrlObj.contactId;
    _fields['is_suspend'] = '1';
    // '${(orderManageCtrlObj.selectedOrderType.value == orderManageCtrlObj.orderTypes.first) ? 1 : 0}';
    _fields['types_of_service_id'] =
        '${orderManageCtrlObj.selectedOrderType?.id}';
    // '${orderManageCtrlObj.orderTypes.indexWhere((orderType) => orderType == orderManageCtrlObj.selectedOrderType.value)}';

    // if user select Dine In of order type/service
    /// TODO: Multiple table handling (merge_tables -> id instead of first table id or single table id ...)
    if (orderManageCtrlObj.selectedOrderType?.name == AppValues.dineIn)
      _fields['table_id'] = '${orderCtrlObj.singleOrderData?.resTableId}';

    _fields['type'] = 'sell';
    _fields['status'] =
        'final'; // due, paid , partial ('final' value api me the)

    _fields['transaction_date'] = '${DateTime.now()}'; // on payment success

    // payment sy related kam
    _fields['total_before_tax'] = subTotalAmount();
    _fields['discount_type'] = 'percentage'; // percentage / fixed
    _fields['tax_amount'] = '${totalTaxAmount()}';
    _fields['discount_amount'] =
        '0'; // TODO _fields['tax_amount'] = totalTaxAmount();
    _fields['final_total'] = finalAmount();
    _fields['payment_status'] =
        'due'; // for order suspend = due, cash = paid / partial,
    _fields['round_off_amount'] = finalAmount();

    _fields['packing_charge'] =
        '0'; // TODO: should be picked from service types data
    _fields['packing_charge_type'] =
        'fixed'; // TODO: also picked from service types data

    List _products = [];

    for (int i = 0; i < itemCartList.length; i++) {
      _products.add(
        {
          '"product_id"': '${itemCartList[i].id}',
          '"variation_id"':
              '${itemCartList[i].productVariations.first.variations.first.id}',
          '"quantity"': '${itemCartList[i].quantity}',
          '"unit_price"':
              '${itemCartList[i].productVariations.first.variations.first.defaultSellPrice}',
          '"discount_amount"': '0',
          '"discount_type"': 'percentage',
        },
      );
    }

    // for (int i = 0; i < itemCartList.length; i++) {
    //   request.fields['product_id[$i]'] = '${itemCartList[i].id}';
    //   request.fields['variation_id[$i]'] = '${itemCartList[i].id}';
    //   request.fields['quantity[$i]'] = '${itemCartList[i].quantity}';
    //
    //   if (itemCartList[i].productTax != null) {
    //     // request.fields['tax_id[$i]'] = '${itemCartList[i].productTax?.id}';
    //     request.fields['tax_id'] = '${itemCartList[i].productTax?.id}';
    //     request.fields['item_tax[$i]'] = '${itemCartList[i].productTax?.amount}';
    //   }
    //
    //   if (itemCartList[i].productVariations.isNotEmpty) {
    //     request.fields['line_discount_type[$i]'] = 'fixed';
    //     request.fields['unit_price_before_discount[$i]'] =
    //         '${itemCartList[i].productVariations.first.variations.first.defaultSellPrice}';
    //     request.fields['unit_price[$i]'] =
    //         '${itemCartList[i].productVariations.first.variations.first.defaultSellPrice}';
    //     request.fields['unit_price_inc_tax[$i]'] =
    //         '${itemCartList[i].productVariations.first.variations.first.sellPriceIncTax}';
    //   }
    //   if (itemCartList[i].modifier.isNotEmpty) {
    //     List<int> allModifierIds = [], allModifierVariationIds = [];
    //     itemCartList[i].modifier.forEach(
    //       (_mod) {
    //         if (!allModifierIds.contains(_mod.productModifier.id)) {
    //           _mod.productModifier.variations.forEach(
    //             (_vars) {
    //               if (!allModifierVariationIds.contains(_vars.id)) {
    //                 allModifierIds.add(_mod.productModifier.id);
    //                 allModifierVariationIds.add(_vars.id);
    //               }
    //             },
    //           );
    //         }
    //       },
    //     );
    //     request.fields['parent_sell_line_id[$i]'] = '$allModifierIds';
    //     // request.fields['variation_id[$i]'] = '$allModifierVariationIds';
    //   }
    // }

    _fields['products'] = '$_products';

    _fields['sale_note'] =
        '${orderCtrlObj.singleOrderData?.id} Order Updated ... .';

    /// TODO: Staff note field ?
    // request.fields['staff_note'] = '${orderCtrlObj.singleOrderData?.id} Order Updated ... .';

    /// TODO: pass these parameters in case of delivery
    // request.fields["shipping_details"] = "Express Delivery";
    // request.fields["shipping_address"] = "cum";
    // request.fields["shipping_status"] = "ordered";
    // request.fields["delivered_to"] = "Mr Robin";
    // request.fields["shipping_charges"] = 10;
    // request.fields["packing_charge"] = 10;

    logger.i(_fields);

    // request.headers.addAll(headers);
    return await http
        .put(
            Uri.parse(
                '${AppConfig.baseUrl}${ApiUrls.updateOrder}${orderCtrlObj.singleOrderData?.id}'),
            body: json.encode(_fields),
            headers: headers)
        .then((_res) async {
      logger.i(
          'EndPoint => ${_res.request?.url ?? '${AppConfig.baseUrl}${ApiUrls.updateOrder}${orderCtrlObj.singleOrderData?.id}'}'
          '\nStatusCode => ${_res.statusCode}'
          '\nResponse => ${_res.body}');
      if (_res.statusCode == 200) clearOnOrderPlaceSuccess();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

  multipartPutMethod() async {
    // API Method with url
    String _url =
        '${ApiUrls.sellUpdateOrder}${orderCtrlObj.singleOrderData?.id}';

    /*
    Approach 1 (Multipart Request like create order approach)
    */

    // // API header
    // Map<String, String> headers = {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
    // };

    // var request = http.MultipartRequest('POST', Uri.parse('${AppConfig.baseUrl}$_url'));

    // request.fields['business_id'] =
    //     '${AppStorage.getBusinessDetailsData()?.businessData?.id ?? AppStorage.getLoggedUserData()?.staffUser.businessId}';
    // request.fields['location_id'] =
    //     '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}';
    // request.fields['selling_price_group_id'] =
    //     '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.sellingPriceGroupId}';
    // request.fields['invoice_no'] =
    //     '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.invoiceSchemeId}';
    // request.fields['service_staff_id'] = '${AppStorage.getLoggedUserData()?.staffUser.id}';
    //
    // /*
    // 1 for Dine In / Walk In Customers
    // created contact first and that id need to pass for take away and delivery
    // */
    // request.fields['contact_id'] = orderManageCtrlObj.contactId ?? '';
    // request.fields['is_suspend'] = '1';
    // // '${(orderManageCtrlObj.selectedOrderType.value == orderManageCtrlObj.orderTypes.first) ? 1 : 0}';
    // request.fields['types_of_service_id'] = '8';
    // // '${orderManageCtrlObj.orderTypes.indexWhere((orderType) => orderType == orderManageCtrlObj.selectedOrderType.value)}';
    //
    // request.fields['type'] = 'sell';
    // request.fields['status'] = 'final'; // due, paid , partial ('final' value api me the)
    //
    // // if user select Dine In of order type/service
    // /// TODO: Multiple table handling (merge_tables -> id instead of first table id or single table id ...)
    // request.fields['table_id'] = '${orderCtrlObj.singleOrderData?.resTableId}';
    //
    // request.fields['transaction_date'] = '${DateTime.now()}'; // on payment success
    //
    // // payment sy related kam
    // // request.fields['total_before_tax'] = totalAmount();
    // // request.fields['discounttype'] = 'percentage'; // percentage / fixed
    // // request.fields['tax_amount'] = '0';
    // // request.fields['discountamount'] = '0'; // TODO _fields['tax_amount'] = totalTaxAmount();
    // // request.fields['final_total'] = finalAmount();
    // // request.fields['payment_status'] = 'due'; // for order suspend = due, cash = paid / partial,
    // // request.fields['round_off_amount'] = finalAmount();
    // //
    // // request.fields['packing_charge'] = '0'; // TODO: should be picked from service types data
    // // request.fields['packing_charge_type'] = 'fixed'; // TODO: also picked from service types data
    //
    // // request.fields['tax_rate__id'] = '13'; // TODO
    //
    // for (int i = 0; i < itemCartList.length; i++) {
    //   request.fields['product_id[$i]'] = '${itemCartList[i].id}';
    //   request.fields['variation_id[$i]'] = '${itemCartList[i].id}';
    //   request.fields['quantity[$i]'] = '${itemCartList[i].quantity}';
    //
    //   // if (itemCartList[i].productTax != null) {
    //   //   // request.fields['tax_id[$i]'] = '${itemCartList[i].productTax?.id}';
    //   //   request.fields['tax_rate_id[$i]'] = '${itemCartList[i].productTax?.id}';
    //   //
    //   //   request.fields['tax_id'] = '${itemCartList[i].productTax?.id}';
    //   //   request.fields['item_tax[$i]'] = '${itemCartList[i].productTax?.amount}';
    //   // }
    //   //
    //   // if (itemCartList[i].productVariations.isNotEmpty) {
    //   //   request.fields['discount_type[$i]'] = 'fixed';
    //   //   request.fields['discount_amount[$i]'] = '0';
    //   //
    //   //   request.fields['unit_price[$i]'] =
    //   //       '${itemCartList[i].productVariations.first.variations.first.defaultSellPrice}';
    //   //   request.fields['line_discount_type[$i]'] = 'fixed';
    //   //   request.fields['unit_price_before_discount[$i]'] =
    //   //       '${itemCartList[i].productVariations.first.variations.first.defaultSellPrice}';
    //   //   request.fields['unit_price_inc_tax[$i]'] =
    //   //       '${itemCartList[i].productVariations.first.variations.first.sellPriceIncTax}';
    //   // }
    //   // // if (itemCartList[i].modifier.isNotEmpty) {
    //   // //   List<int> allModifierIds = [], allModifierVariationIds = [];
    //   // //   itemCartList[i].modifier.forEach(
    //   // //     (_mod) {
    //   // //       if (!allModifierIds.contains(_mod.productModifier.id)) {
    //   // //         _mod.productModifier.variations.forEach(
    //   // //           (_vars) {
    //   // //             if (!allModifierVariationIds.contains(_vars.id)) {
    //   // //               allModifierIds.add(_mod.productModifier.id);
    //   // //               allModifierVariationIds.add(_vars.id);
    //   // //             }
    //   // //           },
    //   // //         );
    //   // //       }
    //   // //     },
    //   // //   );
    //   // //   request.fields['parent_sell_line_id[$i]'] = '$allModifierIds';
    //   // //   // request.fields['variation_id[$i]'] = '$allModifierVariationIds';
    //   // // }
    // }
    //
    // request.fields['sale_note'] = '${orderCtrlObj.singleOrderData?.id} Order Updated ... .';
    //
    // // /// TODO: Staff note field ?
    // // request.fields['staff_note'] = '${orderCtrlObj.singleOrderData?.id} Order Updated ... .';
    //
    // // /// TODO: pass these parameters in case of delivery
    // // request.fields["shipping_details"] = "Express Delivery";
    // // request.fields["shipping_address"] = "cum";
    // // request.fields["shipping_status"] = "ordered";
    // // request.fields["delivered_to"] = "Mr Robin";
    // // request.fields["shipping_charges"] = 10;
    // // request.fields["packing_charge"] = 10;

    // request.headers.addAll(headers);
    //
    // request.fields.addAll({
    //   'contact_id': '552',
    //   'transaction_date': '2023-2-5 1:12:22',
    //   'status': 'final',
    //   'types_of_service_id': '5',
    //   'table_id': '11',
    //   'service_staff_id': '16',
    //   'product_id[0]': '',
    //   'variation_id[0]': '',
    //   'quantity[0]': ''
    // });

    /*
    Approach 2 (Multipart Request simple )
    */

    Map<String, String> _fields = {};

    int _productIteration = 0;

    _fields['transaction_date'] = '${DateTime.now()}';

    OrderServiceDataModel? _typesOfService = (orderCtrlObj.isOrderUpdating &&
                !orderManageCtrlObj.isServiceTypeSelectionValueUpdated
            ? orderCtrlObj.singleOrderData?.typesOfService
            : orderManageCtrlObj.selectedOrderType) ??
        orderCtrlObj.singleOrderData?.typesOfService;
    _fields['types_of_service_id'] = '${_typesOfService?.id}';

    TableDataModel? _table = _typesOfService?.name == AppValues.dineIn
        ? ((orderCtrlObj.isOrderUpdating &&
                    !tableManageCtrlObj.isTableSelectionValueUpdated
                ? orderCtrlObj.singleOrderData?.tableData
                : (tableManageCtrlObj.selectedTables.isNotEmpty)
                    ? tableManageCtrlObj.selectedTables.first
                    : null) ??
            orderCtrlObj.singleOrderData?.tableData)
        : null;
    _fields['table_id'] = '${_table?.id}';

    _fields['contact_id'] = '${orderCtrlObj.singleOrderData?.contactId}';
    _fields['service_staff_id'] =
        '${AppStorage.getLoggedUserData()?.staffUser.id}';
    _fields['created_by'] = '${AppStorage.getLoggedUserData()?.staffUser.id}';

    _fields['status'] = 'final';
    _fields['type'] = 'sell';
    _fields['discounttype'] =
        '${tTypeValues.reverse?[orderCtrlObj.singleOrderData?.discountType]}';
    _fields['discount_amount'] = '0';
    _fields['tax_rate__id'] = '${orderCtrlObj.singleOrderData?.taxId ?? '0'}';
    _fields['final_total'] = AppFormat.doubleToStringUpTo2(
            '${double.parse(finalAmount()) + double.parse('${orderCtrlObj.singleOrderData?.finalTotal}')}') ??
        '${orderCtrlObj.singleOrderData?.finalTotal}';
    _fields['exchange_rate'] = '${orderCtrlObj.singleOrderData?.exchangeRate}';
    _fields['packing_charge'] =
        '${orderCtrlObj.singleOrderData?.packingCharge}';
    _fields['packing_charge_type'] =
        '${orderCtrlObj.singleOrderData?.packingChargeType}';

    if (itemCartList.isNotEmpty)
      for (var _itr in itemCartList) {
        _fields['product_id[$_productIteration]'] = '${_itr.id}';
        _fields['variation_id[$_productIteration]'] = '${_itr.id}';
        _fields['quantity[$_productIteration]'] = '${_itr.quantity}';
        _productIteration++;
      }

    for (int i = 0; i < itemCartList.length; i++) {
      if (itemCartList[i].productTax != null) {
        // request.fields['tax_id[$i]'] = '${itemCartList[i].productTax?.id}';
        // _fields['tax_rate_id[$i]'] = '${itemCartList[i].productTax?.id}';
        _fields['tax_id[$i]'] = '${itemCartList[i].productTax?.id}';
        //_fields['item_tax[$i]'] = '${itemCartList[i].productTax?.amount}';
      }
    }
    if (orderCtrlObj.singleOrderData != null &&
        orderCtrlObj.singleOrderData!.sellLines.isNotEmpty)
      for (var _itr in orderCtrlObj.singleOrderData!.sellLines) {
        _fields['product_id[$_productIteration]'] = '${_itr.productId}';
        _fields['variation_id[$_productIteration]'] = '${_itr.productId}';
        _fields['quantity[$_productIteration]'] = '${_itr.quantity}';
        _productIteration++;
      }

    logger.i(_fields);

    // return await request.send().then((response) async {
    //   String result = await response.stream.bytesToString();
    return await ApiServices.postMethod(feedUrl: _url, fields: _fields)
        .then((response) async {
      // logger.i('EndPoint => ${_url}'
      //     '\nStatus Code => {response.statusCode}'
      //     '\nResponse => $response');

      if (response == null) return;
      clearOnOrderPlaceSuccess();
      await Get.to(() => OrderPlaced());
      Get.find<OrderTypeSelectionController>().isButtonDisabled = false;
      Get.find<OrderTypeSelectionController>().update();
      Get.offAll(TabsPage());
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

//   requestPutMethod() async {
//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
//     };
//
//     var request = http.Request('PUT',
//         Uri.parse('${AppConfig.baseUrl}${ApiUrls.updateOrder}${orderCtrlObj.singleOrderData?.id}'));
//
//     // Postman data
//     /*
//     request.body = json.encode({
//       "contact_id": 552,
//       "transaction_date": "2020-5-7 15:20:22",
//       "status": "final",
//       "is_quotation": true,
//       "tax_rate_id": 13,
//       "discount_amount": 10,
//       "discount_type": "fixed",
//       "sale_note": "impedit",
//       "staff_note": "quia",
//       "commission_agent": 17,
//       "shipping_details": "Express Delivery",
//       "shipping_address": "cum",
//       "shipping_status": "ordered",
//       "delivered_to": "Mr Robin",
//       "shipping_charges": 10,
//       "packing_charge": 10,
//       "exchange_rate": 1,
//       "selling_price_group_id": 7,
//       "pay_term_number": 3,
//       "pay_term_type": "months",
//       "is_recurring": 0,
//       "recur_interval": 9,
//       "recur_interval_type": "days",
//       "subscription_repeat_on": 7,
//       "subscription_no": "et",
//       "recur_repetitions": 13,
//       "rp_redeemed": 13,
//       "rp_redeemed_amount": 13.5,
//       "types_of_service_id": 5,
//       "service_custom_field_1": "reprehenderit",
//       "service_custom_field_2": "nobis",
//       "service_custom_field_3": "distinctio",
//       "service_custom_field_4": "nihil",
//       "round_off_amount": 93870.13096,
//       "table_id": 11,
//       "service_staff_id": 16,
//       "change_return": 0,
//       "change_return_id": 8,
//       "products": [
//         {
//           "sell_line_id": 21592,
//           "product_id": 3538,
//           "variation_id": 3557,
//           "quantity": 1,
//           "unit_price": 437.5,
//           "tax_rate_id": 13,
//           "discount_amount": 0,
//           "discount_type": "percentage",
//           "sub_unit_id": 52,
//           "note": "doloremque"
//         }
//       ],
//       "payments": [
//         {
//           "payment_id": 18,
//           "amount": 453.13,
//           "method": "cash",
//           "account_id": 19,
//           "card_number": "vitae",
//           "card_holder_name": "ex",
//           "card_transaction_number": "et",
//           "card_type": "aut",
//           "card_month": "et",
//           "card_year": "cupiditate",
//           "card_security": "odit",
//           "transaction_no_1": "iste",
//           "transaction_no_2": "eos",
//           "transaction_no_3": "tempore",
//           "note": "alias",
//           "cheque_number": "corporis",
//           "bank_account_number": "quasi"
//         }
//       ]
//     });
// */
//
//     // data
//     List _updateProductList = [];
//     // _updateProductList = [
//     //   {
//     //     "sell_line_id": 21592,
//     //     "product_id": 3538,
//     //     "variation_id": 3557,
//     //     "quantity": 1,
//     //     "unit_price": 437.5,
//     //     "tax_rate_id": 13,
//     //     "discount_amount": 0,
//     //     "discount_type": "percentage",
//     //     "sub_unit_id": 52,
//     //     "note": "doloremque"
//     //   }
//     // ];
//     for (int i = 0; i < orderCtrlObj.singleOrderData!.sellLines.length; i++) {
//       _updateProductList.add(
//         {
//           'sell_line_id': '${orderCtrlObj.singleOrderData!.sellLines[i].id}',
//           'product_id': '${orderCtrlObj.singleOrderData?.sellLines[i].productId}',
//           'quantity': '${orderCtrlObj.singleOrderData?.sellLines[i].quantity}',
//           'discount_amount': 0,
//           'discount_type': 'percentage',
//         },
//       );
//     }
//     request.body = jsonEncode(
//       {
//         'business_id':
//             '${AppStorage.getBusinessDetailsData()?.businessData?.id ?? AppStorage.getLoggedUserData()?.staffUser.businessId}',
//         'location_id':
//             '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id ?? AppStorage.getLoggedUserData()?.staffUser.locationId}',
//         'selling_price_group_id':
//             '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.sellingPriceGroupId}',
//         'invoice_no':
//             '${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.invoiceSchemeId}',
//         'service_staff_id': '${AppStorage.getLoggedUserData()?.staffUser.id}',
//         'contact_id': orderManageCtrlObj.contactId ?? '',
//         'is_suspend': '1',
//         'types_of_service_id': '8',
//         'type': 'sell',
//         'status': 'final',
//         'table_id': '${orderCtrlObj.singleOrderData?.resTableId}',
//         'transaction_date': '${DateTime.now()}',
//         'total_before_tax': totalAmount(),
//         'discount_type': 'percentage',
//         'tax_amount': '0',
//         'discount_amount': '0',
//         'final_total': finalAmount(),
//         'payment_status': 'due',
//         'round_off_amount': finalAmount(),
//         'packing_charge': '0',
//         'packing_charge_type': 'fixed',
//         "products": _updateProductList,
//         'payments': []
//       },
//     );
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//     print(await response.stream.bytesToString());
//
//     if (response.statusCode == 200) {
//       print('Success');
//     } else {
//       print(response.reasonPhrase);
//     }
//   }

  deleteFromOrderItems(int? sellLineId) {
    // TODO: API integration to delete sellLine from an order
    update();
  }

  // ----- Update Amount Calculation Function Start

  // double calculateSaleItemTotalPrice(String? _itemPriceIncTax, int? _itemQuantity) {
  //   double _price = 0.0;
  //   try {
  //     if (_itemPriceIncTax != null) {
  //       _price = double.parse('$_itemPriceIncTax') * (_itemQuantity ?? 1);
  //       // if (_item.modifier.isNotEmpty) {
  //       //   // TODO: calculate the modifier price too
  //       // }
  //     }
  //   } catch (e) {
  //     logger.wtf('Error to calculate the item total price => $e');
  //   }
  //   return _price;
  // }

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
