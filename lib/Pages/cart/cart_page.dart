import 'package:bizmodo_emenu/Controllers/ContactController/ContactController.dart';
import 'package:bizmodo_emenu/Controllers/OrderController/order_type_controller.dart';
import 'package:bizmodo_emenu/Pages/Tabs/View/order_type_selection.dart';
import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Components/custom_circular_button.dart';
import '/Controllers/ProductController/product_cart_controller.dart';
import '/Pages/Orders/Controller/OrderController.dart';
import '../ProductsPage/home_page.dart';
import '/Theme/style.dart';
import '../../Controllers/TableSelectionController/table_management_controller.dart';
import '../../Controllers/Tax Controller/TaxController.dart';
import '../Table/TablesPage.dart';
import '../SalesView/discount.dart';
import 'CartItemTile.dart';
import 'OrderedCart/OrderedItemsCartPage.dart';
// import '../print_page.dart';

class CartPage extends StatefulWidget {
  final bool isSubPage;

  CartPage({this.isSubPage = false, Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // final TableSelectionController _tableCtrlObj = Get.find<TableSelectionController>();
  final OrderController orderCtrlObj = Get.find<OrderController>();
  final TaxController taxCtrlObj = Get.find<TaxController>();
  final ProductCartController productCartControllerObj =
      Get.find<ProductCartController>();
  // final OrderTypeSelectionController orderTypeSelectionCtrlObj =
  //     Get.find<OrderTypeSelectionController>();
  final ContactController contactCtrlObj = Get.find<ContactController>();
  // String token = '';

  @override
  void initState() {
    // TODO: implement initState
    contactCtrlObj.fetchCustomerInfo('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isSubPage
          ? null
          : AppBar(
              title: Text('cart'.tr),
              backgroundColor: Colors.transparent,
              actions: [
                if (orderCtrlObj.isOrderUpdating)
                  AppStyles.p12p5(
                    CustomButton(
                        btnTxt: 'add_item'.tr,
                        onTap: () => Get.to(() => HomePage())),
                  ),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Order ID
                            if (orderCtrlObj.isOrderUpdating)
                              Text(
                                'Invoice No'.tr +
                                    ' ${orderCtrlObj.singleOrderData?.invoiceNo}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                maxLines: 2,
                              ),

                            // Table name
                            GetBuilder(builder: (OrderTypeSelectionController
                                _orderTypeCtrlObj) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // GetBuilder(builder: (OrderTypeSelectionController
                                  //     _orderTypeCtrlObj) {
                                  //   return (_orderTypeCtrlObj.selectedOrderType !=
                                  //               null ||
                                  //           orderCtrlObj.isOrderUpdating)
                                  //       ?
                                  if ((_orderTypeCtrlObj.selectedOrderType !=
                                          null ||
                                      orderCtrlObj.isOrderUpdating))
                                    CustomButton(
                                      height: 30,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      onTap: () async {
                                        if (contactCtrlObj.customerNameCtrl.text
                                                .isEmpty &&
                                            contactCtrlObj.customerContacts
                                                    ?.contactDataList !=
                                                null) {
                                          contactCtrlObj.nameCtrl.text =
                                              '${contactCtrlObj.customerContacts?.contactDataList[0].name}';
                                          contactCtrlObj
                                                  .searchCustomerCtrl.text =
                                              '${contactCtrlObj.customerContacts?.contactDataList[0].name} ${contactCtrlObj.customerContacts?.contactDataList[0].contactId}';
                                          contactCtrlObj.mobileNumberCtrl.text =
                                              '${contactCtrlObj.customerContacts?.contactDataList[0].mobile}';
                                        }
                                        await Get.to(
                                          () => OrderTypeSelection(
                                            isInputFieldsAllowed: true,
                                            isUpdate: true,
                                            // tableCartSelectionCallBack: () {
                                            //   _tableCtrlObj.isTableSelectionValueUpdated = true;
                                            //   Get.back();
                                            // },
                                          ),
                                        );
                                      },
                                      bgColor:
                                          Theme.of(context).colorScheme.primary,
                                      // orderTypeSelectionCtrlObj
                                      //         .isButtonDisabled
                                      //     ? buttonColor
                                      //     : Theme.of(context)
                                      //         .primaryColorLight,
                                      btnChild: Text(
                                        (orderCtrlObj.isOrderUpdating &&
                                                    !_orderTypeCtrlObj
                                                        .isServiceTypeSelectionValueUpdated
                                                ? orderCtrlObj.singleOrderData
                                                    ?.typesOfService?.name
                                                : _orderTypeCtrlObj
                                                    .selectedOrderType?.name) ??
                                            'select_service'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                      ),
                                    ),
                                  if ((_orderTypeCtrlObj.selectedOrderType !=
                                              null ||
                                          orderCtrlObj.isOrderUpdating) &&
                                      _orderTypeCtrlObj.showButtonTable ==
                                          false)
                                    CustomButton(
                                      height: 30,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      onTap: () async {
                                        if (contactCtrlObj
                                                .nameCtrl.text.isEmpty &&
                                            contactCtrlObj.customerContacts
                                                    ?.contactDataList !=
                                                null) {
                                          contactCtrlObj.nameCtrl.text =
                                              '${contactCtrlObj.customerContacts?.contactDataList[0].name}';
                                          contactCtrlObj
                                                  .searchCustomerCtrl.text =
                                              '${contactCtrlObj.customerContacts?.contactDataList[0].name} ${contactCtrlObj.customerContacts?.contactDataList[0].contactId}';
                                          contactCtrlObj.mobileNumberCtrl.text =
                                              '${contactCtrlObj.customerContacts?.contactDataList[0].mobile}';
                                        }
                                        await Get.to(
                                          () => OrderTypeSelection(
                                            isInputFieldsAllowed: true,
                                            isHeadingAllowed: false,
                                            isUpdate: true,
                                            // tableCartSelectionCallBack: () {
                                            //   _tableCtrlObj.isTableSelectionValueUpdated = true;
                                            //   Get.back();
                                            // },
                                          ),
                                        );
                                      },
                                      bgColor:
                                          _orderTypeCtrlObj.isButtonDisabled
                                              ? buttonColor
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                      btnChild: Text(
                                        '${contactCtrlObj.nameCtrl.text.isNotEmpty ? contactCtrlObj.nameCtrl.text : 'Walk-In'}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                      ),
                                    ),
                                  //Table selection
                                  if (_orderTypeCtrlObj.showButtonTable == true)
                                    GetX(builder: (TableSelectionController
                                        _tableCtrlObj) {
                                      return (_tableCtrlObj
                                                  .selectedTables.isNotEmpty ||
                                              orderCtrlObj.isOrderUpdating)
                                          ? CustomButton(
                                              height: 30,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              onTap: () async {
                                                await Get.to(
                                                  () => TablesPage(
                                                    tableCartSelectionCallBack:
                                                        () {
                                                      _tableCtrlObj
                                                              .isTableSelectionValueUpdated =
                                                          true;
                                                      Get.back();
                                                    },
                                                  ),
                                                );
                                              },
                                              bgColor: Theme.of(context)
                                                  .primaryColor,
                                              btnChild: Text(
                                                'table'.tr +
                                                    ' ' +
                                                    ((orderCtrlObj.isOrderUpdating &&
                                                                !_tableCtrlObj
                                                                    .isTableSelectionValueUpdated
                                                            ? orderCtrlObj
                                                                .singleOrderData
                                                                ?.tableData
                                                                ?.name
                                                            : (_tableCtrlObj
                                                                    .selectedTables
                                                                    .isNotEmpty)
                                                                ? _tableCtrlObj
                                                                    .selectedTables
                                                                    .first
                                                                    .name
                                                                : null) ??
                                                        'tap_to_select'.tr),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white),
                                              ),
                                            )
                                          : SizedBox();
                                    }),

                                  ///Disount button
                                  GetBuilder<ProductCartController>(builder:
                                      (ProductCartController
                                          _productCartCtrlObj) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomButton(
                                          height: 30,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          onTap: () async {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                //title: title != null ? Text(title) : null,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15,
                                                        horizontal: 0),
                                                content: Discount(),
                                              ),
                                            );
                                          },
                                          bgColor: _productCartCtrlObj
                                                  .discoutCtrl.text.isNotEmpty
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Theme.of(context)
                                                  .primaryColorLight,
                                          btnChild: Text(
                                            'discount'.tr +
                                                ': ' +
                                                _productCartCtrlObj
                                                    .discoutCtrl.text,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                              );
                            }),
                            // buildItemsInCartButton(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        height: 5,
                        color: kLightTextColor.withOpacity(0.1),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'product_description'.tr,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          Text(
                            'unit_price'.tr,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Spacer(),
                          Text(
                            'sub'.tr,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Divider(
                        height: 5,
                        color: kLightTextColor.withOpacity(0.1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      body: Stack(
        children: [
          // List of cart items
          CustomScrollView(
            slivers: [
              // Selected Items Record
              GetBuilder<ProductCartController>(
                  builder: (ProductCartController prodCartCtrlObj) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return CartItemTile(prodCartCtrlObj.itemCartList[index]);
                    },
                    childCount: prodCartCtrlObj.itemCartList.length,
                  ),
                );
              }),

              // Ordered
              if (orderCtrlObj.isOrderUpdating &&
                  orderCtrlObj.singleOrderData != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: OrderedItemsCartPage(),
                  ),
                ),

              // Page Bottom Spacing
              SliverToBoxAdapter(child: AppStyles.scrollBottomSpacing()),
            ],
          ),

          // Total Price
          GetBuilder(builder: (ProductCartController prodCartCtrlObj) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Subtotal Amount and Tax
                    if (prodCartCtrlObj.itemCartList.isNotEmpty)
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'sub_total'.tr,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              prodCartCtrlObj.subTotal(
                                ordersItemsSubTotalAmount:
                                    prodCartCtrlObj.totalOrderedItemsAmount(),
                              ),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    Divider(
                      height: 0,
                      color: kLightTextColor.withOpacity(0.1),
                    ),
                    if (prodCartCtrlObj.itemCartList.isNotEmpty &&
                        prodCartCtrlObj.discoutCtrl.text.isNotEmpty)
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'discount'.tr,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              (prodCartCtrlObj.discountType.text == 'Fixed')
                                  ? prodCartCtrlObj.discoutCtrl.text
                                  : prodCartCtrlObj
                                      .totalDiscountPercentage(
                                        ordersItemsSubTotalAmount:
                                            prodCartCtrlObj
                                                .totalOrderedItemsAmount(),
                                      )
                                      .toString(),
                              // AppFormat.doubleToStringUpTo2(
                              //     order.totalAmountRecovered) ??
                              // prodCartCtrlObj.discoutCtrl.text,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    Divider(
                      height: 0,
                      color: kLightTextColor.withOpacity(0.1),
                    ),
                    //  Sub total After discount
                    // if (prodCartCtrlObj.itemCartList.isNotEmpty)
                    //   Container(
                    //     color: Theme.of(context).scaffoldBackgroundColor,
                    //     padding: EdgeInsets.symmetric(
                    //         vertical: 4.0, horizontal: 10.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: <Widget>[
                    //         Text(
                    //           'sub_total_after_discount'.tr,
                    //           style: Theme.of(context).textTheme.bodySmall,
                    //         ),
                    //         Text(
                    //           prodCartCtrlObj.subTotalAfterDiscount(
                    //             ordersItemsSubTotalAmount:
                    //                 prodCartCtrlObj.totalOrderedItemsAmount(),
                    //           ),
                    //           style: Theme.of(context).textTheme.bodySmall,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // Divider(
                    //   height: 0,
                    //   color: kLightTextColor.withOpacity(0.1),
                    // ),
                    //  Tax
                    if (prodCartCtrlObj.itemCartList.isNotEmpty)
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'tax_amount'.tr,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              '${prodCartCtrlObj.totalTaxAmountWithDiscount(ordersItemsTotalTax: prodCartCtrlObj.totalOrderedTaxAmount(), taxCtrlObj: taxCtrlObj)}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    Divider(
                      height: 0,
                      color: kLightTextColor.withOpacity(0.1),
                    ),

                    if (prodCartCtrlObj.itemCartList.isNotEmpty &&
                        prodCartCtrlObj.shippingChargeCtrl.text.isNotEmpty)
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'shipping_charge'.tr,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              prodCartCtrlObj.shippingChargeCtrl.text,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    Divider(
                      height: 0,
                      color: kLightTextColor.withOpacity(0.1),
                    ),

                    // Total Amount and Tax
                    if (prodCartCtrlObj.itemCartList.isNotEmpty)
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'totalAmount'.tr,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              prodCartCtrlObj.finalTotalAmount(
                                  ordersItemsSubTotalAmount:
                                      prodCartCtrlObj.totalOrderedItemsAmount(),
                                  taxCtrlObj: taxCtrlObj),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    // Divider(
                    //   height: 0,
                    //   color: kLightTextColor.withOpacity(0.1),
                    // ),
                    // if (prodCartCtrlObj.itemCartList.isNotEmpty)
                    //   Container(
                    //     color: Theme.of(context).scaffoldBackgroundColor,
                    //     padding: EdgeInsets.symmetric(
                    //         vertical: 4.0, horizontal: 10.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: <Widget>[
                    //         Text(
                    //           'payed_amount'.tr,
                    //           style: Theme.of(context).textTheme.bodySmall,
                    //         ),
                    //         Text(
                    //           // AppFormat.doubleToStringUpTo2(
                    //           //     order.totalAmountRecovered) ??
                    //           '',
                    //           style: Theme.of(context).textTheme.bodySmall,
                    //         ),
                    //       ],
                    //     ),
                    //   ),

                    // Cancel and Place Order Buttons
                    // Wrap(
                    //   children: [
                    //     if (prodCartCtrlObj.itemCartList.isNotEmpty)
                    //       CustomButton(
                    //         onTap: () {
                    //           Get.to(() => PortScanPage());
                    //         },
                    //         padding: EdgeInsets.all(20),
                    //         bgColor: Colors.orangeAccent,
                    //         title: Text(
                    //           "Print KOT",
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .bodyText1!
                    //               .copyWith(fontSize: 16),
                    //         ),
                    //         borderRadius: 0,
                    //       ),
                    //     if (prodCartCtrlObj.itemCartList.isNotEmpty)
                    //       CustomButton(
                    //         onTap: () {},
                    //         padding: EdgeInsets.all(20),
                    //         bgColor: Colors.green,
                    //         title: Text(
                    //           "Print Invoice",
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .bodyText1!
                    //               .copyWith(fontSize: 16),
                    //         ),
                    //         borderRadius: 0,
                    //       ),
                    //     if (prodCartCtrlObj.itemCartList.isNotEmpty)
                    //       CustomButton(
                    //         onTap: () {
                    //           Get.find<AllProductsController>()
                    //               .currentPageSection
                    //               .value = OrderProcess.ServiceSelectionPage;
                    //           prodCartCtrlObj.itemCartList.clear();
                    //
                    //           if (Get.currentRoute == '/CartPage') Get.back();
                    //         },
                    //         padding: EdgeInsets.all(20),
                    //         bgColor: Colors.redAccent,
                    //         title: Text(
                    //           'Cancel',
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .bodyText1!
                    //               .copyWith(fontSize: 16),
                    //         ),
                    //         borderRadius: 0,
                    //       ),
                    //     CustomButton(
                    //       onTap: (prodCartCtrlObj.itemCartList.isNotEmpty)
                    //           ? () => prodCartCtrlObj.placeOrder()
                    //           : null,
                    //       padding: EdgeInsets.all(20),
                    //       bgColor: Theme.of(context).colorScheme.primary,
                    //       title: Text(
                    //         (prodCartCtrlObj.itemCartList.isEmpty)
                    //             ? 'Cart Is Empty. Select Items.'
                    //             : 'Create Order',
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .bodyText1!
                    //             .copyWith(fontSize: 16),
                    //       ),
                    //       borderRadius: 0,
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        if (prodCartCtrlObj.itemCartList.isNotEmpty)
                          Expanded(
                            child: CustomButton(
                              onTap: () {
                                prodCartCtrlObj.itemCartList.clear();
                                prodCartCtrlObj.update();
                                Get.close(1);
                                //setState(() {});
                                //Get.to(HomePage());
                                //Get.close(3);
                              },
                              padding: EdgeInsets.all(15),
                              bgColor: Colors.redAccent,
                              btnTxt: 'cancel'.tr,
                              borderRadius: 0,
                            ),
                          ),
                        Expanded(
                          child: CustomButton(
                            onTap: (orderCtrlObj.isOrderUpdating)
                                ? () {
                                    print('pressed');
                                    Get.find<OrderTypeSelectionController>()
                                        .isButtonDisabled = true;
                                    setState(() {});
                                    Get.find<OrderTypeSelectionController>()
                                        .update();
                                    prodCartCtrlObj.updateOrder();
                                  }
                                : Get.find<OrderTypeSelectionController>()
                                        .isButtonDisabled
                                    ? null
                                    : (prodCartCtrlObj.itemCartList.isNotEmpty)
                                        ? () {
                                            print('pressed');
                                            Get.find<
                                                    OrderTypeSelectionController>()
                                                .isButtonDisabled = true;
                                            setState(() {});
                                            Get.find<
                                                    OrderTypeSelectionController>()
                                                .update();
                                            prodCartCtrlObj.placeOrder();
                                            // prodCartCtrlObj
                                            //     .sendNotificationofOrderCompletion(
                                            //   context: context,
                                            //   token: token,
                                            //   id: AppStorage
                                            //           .getLoggedUserData()!
                                            //       .staffUser
                                            //       .id
                                            //       .toString(),
                                            //   body:
                                            //       'Order Created Successfully',
                                            //   title: 'Order Created',
                                            // );
                                          }
                                        : null,
                            padding: EdgeInsets.all(15),
                            bgColor: Theme.of(context).colorScheme.primary,
                            btnTxt: (orderCtrlObj.isOrderUpdating &&
                                    orderCtrlObj.singleOrderData != null)
                                ? 'update_order'.tr
                                : (prodCartCtrlObj.itemCartList.isEmpty)
                                    ? 'cart_is_empty'.tr
                                    : 'create_order'.tr,
                            borderRadius: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
