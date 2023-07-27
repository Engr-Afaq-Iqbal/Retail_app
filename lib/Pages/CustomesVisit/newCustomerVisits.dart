import 'package:bizmodo_emenu/Pages/CreateNewCustomer/showCustomerDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/custom_circular_button.dart';
import '../../Controllers/CustomerVisits/CustomerVisitsController.dart';
import '../CreateOrder/createOrderPage.dart';
import '../Return/return.dart';
import '/Config/utils.dart';
import '../../Controllers/ContactController/ContactController.dart';
import '../../Theme/colors.dart';

class NewCustomerVisit extends StatefulWidget {
  final int? dashBoardId;
  NewCustomerVisit({Key? key, this.dashBoardId}) : super(key: key);
  @override
  State<NewCustomerVisit> createState() => _NewCustomerVisitState();
}

class _NewCustomerVisitState extends State<NewCustomerVisit> {
  ScrollController? _scrollController;
  String? query;
  ContactController contactCtrlObjj = Get.find<ContactController>();
  CustomerVisitsController customerVisitsCtrlObj =
      Get.find<CustomerVisitsController>();
  void initState() {
    contactCtrlObjj.callFirstOrderPage();
    scrollControllerLis();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.removeListener(scrollControllerLis);
    contactCtrlObjj.clearAllContactCtrl();
    super.dispose();
  }

  scrollControllerLis() {
    _scrollController = ScrollController();
    if (_scrollController != null) {
      _scrollController?.addListener(() {
        if (_scrollController?.position.pixels ==
            _scrollController?.position.maxScrollExtent) {
          //contactCtrlObjj.isLoadMoreRunning.isTrue;
          Get.find<ContactController>().loadMoreSaleOrders();
          //Get.find<ContactController>().callFirstOrderPage();
        }
      });
    }
  }

  TextEditingController searchCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('customer_visits'.tr),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  //controller: searchCtrl,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'search_customer'.tr,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (value) {
                    query = value;
                    contactCtrlObjj.fetchCustomerInfo(query);
                  },
                ),
                //createNewCustomTile(context),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: (widget.dashBoardId == 1)
      //     ? FloatingActionButton.small(
      //         child: Icon(Icons.add),
      //         backgroundColor:
      //             Theme.of(context).colorScheme.primary.withOpacity(0.5),
      //         onPressed: () {
      //           Get.to(CreateNewCustomer());
      //           // showDialog(
      //           //   context: context,
      //           //   builder: (context) => AlertDialog(
      //           //     contentPadding:
      //           //         const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
      //           //     content: CreateNewCustomer(),
      //           //   ),
      //           // );
      //         })
      //     : null,
      body: Material(
        child: Stack(
          children: [
            GetBuilder(
              builder: (ContactController contactCtrlObj) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await contactCtrlObj.callFirstOrderPage();
                  },
                  child: (contactCtrlObj.customerContacts == null)
                      ? progressIndicator()
                      : Scrollbar(
                          controller: _scrollController,
                          interactive: true,
                          child: ListView.builder(
                            controller: _scrollController,
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 100),
                            itemCount: contactCtrlObj
                                    .customerContacts?.contactDataList.length ??
                                0,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            //  Get.close(0);
                                            Get.to(ShowCustomerDetails(
                                                contactApi: contactCtrlObj
                                                    .customerContacts!
                                                    .contactDataList[index]
                                                    .id
                                                    .toString()));
                                            contactCtrlObj.id = contactCtrlObj
                                                .customerContacts!
                                                .contactDataList[index]
                                                .id
                                                .toString();
                                            contactCtrlObj.contactId =
                                                contactCtrlObj
                                                    .customerContacts!
                                                    .contactDataList[index]
                                                    .contactId;
                                            contactCtrlObj
                                                    .searchCustomerCtrl.text =
                                                '${contactCtrlObj.customerContacts!.contactDataList[index].name} (${contactCtrlObj.customerContacts!.contactDataList[index].contactId})';
                                            contactCtrlObj.mobileNumberCtrl
                                                .text = contactCtrlObj
                                                    .customerContacts!
                                                    .contactDataList[index]
                                                    .mobile ??
                                                '';
                                            contactCtrlObj.nameCtrl.text =
                                                contactCtrlObj
                                                        .customerContacts!
                                                        .contactDataList[index]
                                                        .name ??
                                                    '';
                                            if (widget.dashBoardId == 2) {
                                              Get.to(CreateOrderPage());
                                            } else if (widget.dashBoardId ==
                                                3) {
                                              Get.to(Return());
                                            } else if (widget.dashBoardId ==
                                                4) {
                                              contactCtrlObj.update();
                                              Get.close(2);
                                              //Get.to(Receipts());
                                            }
                                          },
                                          child: Text(
                                            '${contactCtrlObj.customerContacts!.contactDataList[index].name} (${contactCtrlObj.customerContacts!.contactDataList[index].contactId})',
                                          ),
                                        ),
                                        Divider(
                                          height: 0,
                                          color:
                                              kLightTextColor.withOpacity(0.2),
                                        ),
                                      ],
                                    ),

                                    //check-in check-out button
                                    CustomButton(
                                      onTap: (contactCtrlObj
                                                      .customerContacts!
                                                      .contactDataList[index]
                                                      .customerStatus ==
                                                  '0' &&
                                              contactCtrlObj.isDisable == true)
                                          ? null
                                          : () {
                                              contactCtrlObj.id = contactCtrlObj
                                                  .customerContacts!
                                                  .contactDataList[index]
                                                  .id
                                                  .toString();
                                              if (contactCtrlObj
                                                      .customerContacts!
                                                      .contactDataList[index]
                                                      .customerStatus ==
                                                  '0') {
                                                debugPrint(
                                                    'going for check-in');
                                                showProgress();

                                                customerVisitsCtrlObj
                                                    .checkInFunction();
                                                // customerVisitsCtrlObj
                                                //     .checkPermission();
                                                // customerVisitsCtrlObj
                                                //     .createCustomerVisits();
                                              } else if (contactCtrlObj
                                                      .customerContacts!
                                                      .contactDataList[index]
                                                      .customerStatus ==
                                                  '1') {
                                                debugPrint(
                                                    'going for check-out');
                                                showProgress();
                                                customerVisitsCtrlObj
                                                    .checkOutFunction();
                                                //  Get.to(UpdateStatus(index: index));
                                              }
                                            },
                                      bgColor:
                                          Theme.of(context).colorScheme.primary,
                                      title: Text(
                                        '${contactCtrlObj.customerContacts!.contactDataList[index].customerStatus == '0' ? 'check_in'.tr : 'check_out_visit'.tr}',
                                        style: TextStyle(color: kWhiteColor),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GetX(builder: (ContactController contactCtrlObj) {
                // contactCtrlObj.callFirstOrderPage(page: 2);
                return contactCtrlObj.isLoadMoreRunning.isTrue
                    ? progressIndicator()
                    : SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
