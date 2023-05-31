import 'package:bizmodo_emenu/Pages/Tabs/View/packingCharges.dart';
import 'package:bizmodo_emenu/Pages/SalesView/shippingCharge.dart';
import 'package:bizmodo_emenu/Pages/cart/cart_page.dart';
import 'package:bizmodo_emenu/Pages/order_type/search_customer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import '/Components/custom_circular_button.dart';
import '/Components/single_selection_chip.dart';
import '/Components/textfield.dart';
import '/Config/const.dart';
import '/Config/utils.dart';
import '/Controllers/ContactController/ContactController.dart';
import '/Models/order_type_model/order_service_model.dart';
import '../../ProductsPage/home_page.dart';
import '/Theme/style.dart';
import '../../../Controllers/OrderController/order_type_controller.dart';
import '../../../Controllers/ProductController/product_cart_controller.dart';
import '../../../Theme/colors.dart';
import '../../Notification Services/pushnotification.dart';
import 'cityNames.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message codewaa: ${message.messageId}");
// }

class OrderTypeSelection extends StatefulWidget {
  final bool isInputFieldsAllowed;
  final bool isHeadingAllowed;
  final bool isUpdate;
  OrderTypeSelection(
      {this.isInputFieldsAllowed = false,
      this.isUpdate = false,
      this.isHeadingAllowed = true,
      Key? key})
      : super(key: key);

  @override
  State<OrderTypeSelection> createState() => _OrderTypeSelectionState();
}

class _OrderTypeSelectionState extends State<OrderTypeSelection> {
  final GlobalKey<FormState> takeAwayFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> deliveryFormKey = GlobalKey<FormState>();

  // final OrderTypeSelectionController orderCtrl = Get.find<OrderTypeSelectionController>();
  final ContactController contactCtrlObj = Get.find<ContactController>();

  final ProductCartController productCtrlObj =
      Get.find<ProductCartController>();
  // NotificationServices notificationServices = NotificationServices();

  ///Starting
//   late FirebaseMessaging _messaging;
//   late int _totalNotifications;
//   late PushNotification _notificationInfo;
//
//   void registerNotification() async {
//     await Firebase.initializeApp();
//     _messaging = FirebaseMessaging.instance;
//
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       provisional: false,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         print(
//           'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data},',
//         );
//
//         // Parse the message received
//         PushNotification notification = PushNotification(
//           title: message.notification?.title,
//           body: message.notification?.body,
//           dataTitle: message.data['title'],
//           dataBody: message.data['body'],
//         );
//
//         _notificationInfo = notification;
//         _totalNotifications++;
//         // setState(() {
//         //
//         // });
//
//         if (_notificationInfo != null) {
//           // For displaying the notification as an overlay
//           showSimpleNotification(
//             Text(_notificationInfo.title!),
//             subtitle: Text(_notificationInfo.body!),
//             background: primaryColor,
//             duration: Duration(seconds: 4),
//           );
//         }
//       });
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
//
// // For handling notification when the app is in terminated state
//   checkForInitialMessage() async {
//     await Firebase.initializeApp();
//     RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();
//
//     if (initialMessage != null) {
//       PushNotification notification = PushNotification(
//         title: initialMessage.notification?.title,
//         body: initialMessage.notification?.body,
//         dataTitle: initialMessage.data['title'],
//         dataBody: initialMessage.data['body'],
//       );
//
//       setState(() {
//         _notificationInfo = notification;
//         _totalNotifications++;
//       });
//     }
//   }

  ///ending

  @override
  void initState() {
    // _totalNotifications = 0;
    // registerNotification();
    // checkForInitialMessage();

    // For handling notification when the app is in background
    // but not terminated
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   PushNotification notification = PushNotification(
    //     title: message.notification?.title,
    //     body: message.notification?.body,
    //     dataTitle: message.data['title'],
    //     dataBody: message.data['body'],
    //   );
    //
    //   setState(() {
    //     _notificationInfo = notification;
    //     _totalNotifications++;
    //   });
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.isUpdate) ? AppBar() : null,
      body: RefreshIndicator(
        onRefresh: () async {
          await Get.find<OrderTypeSelectionController>().fetchOrderTypes();
        },
        child: AppStyles.p20h(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),

              /// Order Type Selection
              Text(
                'select_order_type'.tr.obs.value,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),

              //if (widget.isHeadingAllowed)
              AppStyles.p15v(
                GetBuilder(
                    builder: (OrderTypeSelectionController _orderCtrlObj) {
                  return Center(
                    child: (_orderCtrlObj.orderServiceTypes != null)
                        ? SingleSelectionChip<OrderServiceDataModel>(
                            chipsDataList:
                                _orderCtrlObj.orderServiceTypes!.orderService,
                            initialData: _orderCtrlObj.selectedOrderType,
                            valueChanged: (v) {
                              if (widget.isHeadingAllowed)
                                _orderCtrlObj.typeOfServiceTapAction(
                                  v,
                                  isUpdate: widget.isUpdate,
                                  isInputFieldsAllowed:
                                      widget.isInputFieldsAllowed,
                                );
                            },
                            isHeadingAllowed:
                                widget.isHeadingAllowed ? true : false,
                          )
                        : progressIndicator(),
                  );
                }),
              ),

              if (widget.isInputFieldsAllowed)
                GetBuilder(
                    builder: (OrderTypeSelectionController _orderCtrlObj) {
                  return Expanded(
                    child: ListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      children: [
                        /// Take Away
                        if (_orderCtrlObj.selectedOrderType?.name ==
                            AppValues.takeAway)
                          Form(
                            key: takeAwayFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // AppFormField(
                                //   fontWeight: false,
                                //   labelText: 'search_customer'.tr,
                                //   controller: contactCtrlObj.searchCustomerCtrl,
                                //   readOnly: true,
                                //   onTap: () async {
                                //     /// Search Customer
                                //     await showSearch(
                                //       context: context,
                                //       delegate: CustomerSearch(),
                                //     ).then((ContactDataModel?
                                //         _customerInfo) async {
                                //       logger.wtf(
                                //           'Customer Information search result => $_customerInfo');
                                //       if (_customerInfo != null &&
                                //           _customerInfo.contactId != null) {
                                //         contactCtrlObj.searchCustomerCtrl.text =
                                //             '${_customerInfo.name} (${_customerInfo.contactId})';
                                //         contactCtrlObj.nameCtrl.text =
                                //             _customerInfo.name ?? '';
                                //         contactCtrlObj.mobileNumberCtrl.text =
                                //             _customerInfo.mobile ?? '';
                                //       } else if (_customerInfo != null) {
                                //         contactCtrlObj.searchCustomerCtrl.text =
                                //             'create_new_customer'.tr;
                                //         contactCtrlObj.nameCtrl.clear();
                                //         contactCtrlObj.mobileNumberCtrl.clear();
                                //       }
                                //     });
                                //   },
                                // ),

                                // name
                                AppFormField(
                                  fontWeight: false,
                                  validator: (String? v) {
                                    if (v!.isEmpty) return 'field_required'.tr;
                                    return null;
                                  },
                                  labelText: 'customer_name'.tr,
                                  controller: contactCtrlObj.nameCtrl,
                                ),

                                // mobile number
                                AppFormField(
                                  fontWeight: false,
                                  validator: (String? v) {
                                    if (v!.isEmpty) return 'field_required'.tr;
                                    return null;
                                  },
                                  labelText: 'mobile_number'.tr,
                                  controller: contactCtrlObj.mobileNumberCtrl,
                                  keyboardType: TextInputType.number,
                                ),

                                // custom ID 1
                                AppFormField(
                                  fontWeight: false,
                                  labelText: 'custom_label1'.tr,
                                  controller: contactCtrlObj.customLabelCtrl,
                                ),
                                //Packaging Charges
                                AppFormField(
                                  //  isDense: false,
                                  fontWeight: false,
                                  readOnly: true,
                                  labelText: 'packing_charge'.tr,
                                  controller: productCtrlObj.packingChargeCtrl,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        //title: title != null ? Text(title) : null,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 0),
                                        content: PackingCharges(
                                          isDelivery: false,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                        /// Delivery
                        if (_orderCtrlObj.selectedOrderType?.name ==
                            AppValues.delivery)
                          Form(
                            key: deliveryFormKey,
                            child: Column(
                              children: [
                                AppFormField(
                                  fontWeight: false,
                                  validator: (String? v) {
                                    if (v!.isEmpty) return 'field_required'.tr;
                                    return null;
                                  },
                                  readOnly: true,
                                  labelText: 'search_customer'.tr,
                                  controller: contactCtrlObj.searchCustomerCtrl,
                                  onTap: () {
                                    Get.to(CustomerSearch());
                                    // Get.to(() {
                                    //   CustomerSearch();
                                    // });
                                  },
                                ),
                                // AppFormField(
                                //   fontWeight: false,
                                //   labelText: 'search_customer'.tr,
                                //   controller: contactCtrlObj.searchCustomerCtrl,
                                //   readOnly: true,
                                //   onTap: () async {
                                //     /// Search Customer
                                //     await showSearch(
                                //       context: context,
                                //       delegate: CustomerSearch(),
                                //     ).then((ContactDataModel?
                                //         _customerInfo) async {
                                //       logger.wtf(
                                //           'Customer Information search result => $_customerInfo');
                                //       if (_customerInfo != null &&
                                //           _customerInfo.contactId != null) {
                                //         contactCtrlObj.searchCustomerCtrl.text =
                                //             '${_customerInfo.name} (${_customerInfo.contactId})';
                                //
                                //         contactCtrlObj.contactId =
                                //             _customerInfo.contactId ?? '';
                                //         contactCtrlObj.nameCtrl.text =
                                //             _customerInfo.name ?? '';
                                //         contactCtrlObj.mobileNumberCtrl.text =
                                //             _customerInfo.mobile ?? '';
                                //         contactCtrlObj.cityCtrl.text =
                                //             _customerInfo.city ?? '';
                                //         // contactCtrlObj.streetCtrl.text = '${_customerInfo.}';
                                //         // contactCtrlObj.buildingNumCtrl.text = '${_customerInfo.}';
                                //         // contactCtrlObj.apartmentCtrl.text = '${_customerInfo.}';
                                //         contactCtrlObj.addressCtrl.text =
                                //             _customerInfo.addressLine1 ?? '';
                                //       } else if (_customerInfo != null) {
                                //         contactCtrlObj.searchCustomerCtrl.text =
                                //             'create_new_customer'.tr;
                                //         contactCtrlObj.nameCtrl.clear();
                                //         contactCtrlObj.mobileNumberCtrl.clear();
                                //         contactCtrlObj.cityCtrl.clear();
                                //         contactCtrlObj.streetCtrl.clear();
                                //         contactCtrlObj
                                //             .villaBuildingApartmentCtrl
                                //             .clear();
                                //         contactCtrlObj.addressCtrl.clear();
                                //       }
                                //     });
                                //   },
                                // ),

                                // name
                                AppFormField(
                                  fontWeight: false,
                                  validator: (String? v) {
                                    if (v!.isEmpty) return 'field_required'.tr;
                                    return null;
                                  },
                                  labelText: 'name'.tr,
                                  controller: contactCtrlObj.nameCtrl,
                                ),

                                // mobile phone
                                AppFormField(
                                  fontWeight: false,
                                  validator: (String? v) {
                                    if (v!.isEmpty) return 'field_required'.tr;
                                    return null;
                                  },
                                  labelText: 'mobile_number'.tr,
                                  controller: contactCtrlObj.mobileNumberCtrl,
                                  keyboardType: TextInputType.number,
                                ),

                                // city
                                AppFormField(
                                  fontWeight: false,
                                  //isDense: false,
                                  readOnly: true,
                                  labelText: 'city'.tr,
                                  controller: contactCtrlObj.cityCtrl,
                                  validator: (String? v) {
                                    if (v!.isEmpty) return 'field_required'.tr;
                                    return null;
                                  },
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        //title: title != null ? Text(title) : null,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 0),
                                        content: CityNames(),
                                      ),
                                    );
                                  },
                                ),
                                // AppFormField(
                                //   fontWeight: false,
                                //   validator: (String? v) {
                                //     if (v!.isEmpty) return 'field_required'.tr;
                                //     return null;
                                //   },
                                //   labelText: 'city'.tr,
                                //   controller: contactCtrlObj.cityCtrl,
                                // ),

                                // street
                                AppFormField(
                                  fontWeight: false,
                                  labelText: 'street'.tr,
                                  controller: contactCtrlObj.streetCtrl,
                                ),

                                // villa, building, apartment
                                AppFormField(
                                  fontWeight: false,
                                  labelText: 'villa'.tr,
                                  controller:
                                      contactCtrlObj.villaBuildingApartmentCtrl,
                                ),

                                // address
                                AppFormField(
                                  fontWeight: false,
                                  validator: (String? v) {
                                    if (v!.isEmpty) return 'field_required'.tr;
                                    return null;
                                  },
                                  labelText: 'address'.tr,
                                  controller: contactCtrlObj.addressCtrl,
                                ),

                                AppFormField(
                                  fontWeight: false,
                                  // isDense: false,
                                  readOnly: true,
                                  labelText: 'packing_charge'.tr,
                                  controller: productCtrlObj.packingChargeCtrl,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        //title: title != null ? Text(title) : null,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 0),
                                        content: PackingCharges(
                                          isDelivery: true,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                AppFormField(
                                  fontWeight: false,
                                  //isDense: false,
                                  readOnly: true,
                                  labelText: 'shipping'.tr,
                                  controller: productCtrlObj.shippingChargeCtrl,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        //title: title != null ? Text(title) : null,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 0),
                                        content: ShippingCharge(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                        SizedBox(height: 20),

                        /// Buttons
                        Row(
                          children: [
                            if (_orderCtrlObj.selectedOrderType != null &&
                                _orderCtrlObj.selectedOrderType?.name !=
                                    AppValues.dineIn)
                              Expanded(
                                child: CustomButton(
                                  margin: const EdgeInsets.all(5),
                                  onTap: () async {
                                    print(contactCtrlObj.contactId);
                                    if (_orderCtrlObj.selectedOrderType?.name ==
                                            AppValues.takeAway &&
                                        !takeAwayFormKey.currentState!
                                            .validate()) {
                                      //_orderCtrlObj.showButtonTable = false;
                                      //_orderCtrlObj.update();
                                      print('going to cart page');
                                      Get.to(CartPage());
                                      return;
                                    } else if (_orderCtrlObj
                                                .selectedOrderType?.name ==
                                            AppValues.delivery &&
                                        !deliveryFormKey.currentState!
                                            .validate()) {
                                      //  _orderCtrlObj.update();
                                      return;
                                    }
                                    if (contactCtrlObj
                                            .searchCustomerCtrl.text ==
                                        'create_new_customer'.tr)
                                      await contactCtrlObj.createContact();
                                    if (widget.isUpdate) {
                                      _orderCtrlObj
                                              .isServiceTypeSelectionValueUpdated =
                                          true;
                                      productCtrlObj.update();
                                      Get.back();
                                    } else {
                                      Get.to(() => HomePage());
                                    }
                                    // if (contactCtrlObj
                                    //     .searchCustomerCtrl.text.isNotEmpty) {
                                    //   _orderCtrlObj.isButtonDisabled = true;
                                    //   _orderCtrlObj.update();
                                    // }
                                    // if (_orderCtrlObj.isButtonDisabled ==
                                    //     true) {
                                    //   _orderCtrlObj.isButtonDisabled = false;
                                    //   _orderCtrlObj.update();
                                    // }
                                    // _orderCtrlObj.showButtonTable = false;

                                    _orderCtrlObj.isButtonDisabled = false;
                                    _orderCtrlObj.showButtonTable = false;
                                    print(_orderCtrlObj.showButtonTable);
                                    _orderCtrlObj.update();
                                  },
                                  btnTxt: 'submit'.tr,
                                  bgColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            // Expanded(
                            //   child: CustomButton(
                            //     margin: const EdgeInsets.all(5),
                            //     onTap: () {},
                            //     btnTxt: 'orders'.tr,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
