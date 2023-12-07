// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// import '/Config/utils.dart';
// import '/Controllers/ContactController/ContactController.dart';
// import '/Models/order_type_model/customer_contact_model.dart';
// import '../../Theme/colors.dart';
//
// class CustomerSearch extends SearchDelegate<ContactDataModel?> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [TextButton(child: Text('clear'.tr), onPressed: () => query = '')];
//   }
//
//   final ScrollController _scrollController = ScrollController();
//   bool _atBottom = false;
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       tooltip: 'back'.tr,
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return FutureBuilder<ContactModel?>(
//       // We will put the api call here
//       future: searchCustomer(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError)
//           return Center(child: Text('${snapshot.error}'));
//         else if (snapshot.hasData)
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15.0, top: 15),
//                 child: Text(
//                     'suggesstions'.tr /*, style: theme.style16W800Orange*/),
//               ),
//               createNewCustomTile(context),
//               Expanded(
//                 child: ListView.builder(
//                   controller: _scrollController,
//                   itemCount: snapshot.data!.contactDataList.length,
//                   itemBuilder: (context, index) {
//                     // _scrollController.addListener(() {
//                     //   if (_scrollController.position.pixels ==
//                     //       _scrollController.position.maxScrollExtent) {
//                     //     print('you have reached at end');
//                     //   }
//                     // });
//                     if (index == 15) {
//                       print('move to new page');
//                     }
//                     return Column(
//                       children: [
//                         ListTile(
//                           // we will display the data returned from our future here
//                           title: Text(
//                             '${snapshot.data!.contactDataList[index].name} (${snapshot.data!.contactDataList[index].contactId})',
//                           ),
//                           onTap: () {
//                             close(
//                                 context, snapshot.data!.contactDataList[index]);
//                           },
//                         ),
//                         Divider(
//                           height: 0,
//                           color: kLightTextColor.withOpacity(0.4),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         else
//           return progressIndicator();
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         if (query == '')
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Text(
//               'search_by'.tr, /*style: theme.style12W400*/
//             ),
//           ),
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Text(
//             'available'.tr, /*style: theme.style16W800Orange*/
//           ),
//         ),
//         GetBuilder(builder: (ContactController contactCtrlObj) {
//           return (contactCtrlObj.customerContacts != null)
//               ? Expanded(
//                   child: ListView.builder(
//                     itemCount:
//                         contactCtrlObj.customerContacts!.contactDataList.length,
//                     itemBuilder: (context, index) {
//                       // if (index ==
//                       //     contactCtrlObj.customerContacts!.contactDataList
//                       //         .length) return createNewCustomTile(context);
//                       return ListTile(
//                         // we will display the data returned from our future here
//                         title: Text(
//                           '${contactCtrlObj.customerContacts!.contactDataList[index].name} (${contactCtrlObj.customerContacts!.contactDataList[index].contactId})',
//                         ),
//                         onTap: () {
//                           close(
//                             context,
//                             contactCtrlObj
//                                 .customerContacts?.contactDataList[index],
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 )
//               : SizedBox();
//         }),
//       ],
//     );
//   }
//
//   Future<ContactModel?> searchCustomer() async {
//     try {
//       debugPrint('Search Query' + query);
//       ContactController contactCtrlObj = Get.find<ContactController>();
//       return contactCtrlObj.fetchCustomerInfo(query);
//       // if (rpObjC.availableSkills != null && rpObjC.availableSkills!.isNotEmpty) {
//       //   List<AdminSkillModel> results = rpObjC.availableSkills!
//       //       .where((AdminSkillModel _sk) =>
//       //           _sk.title.toLowerCase().contains(_searchText.toLowerCase()))
//       //       .toList();
//       //
//       //   results.removeWhere((_sk) => _sk.title.toLowerCase().contains('others'));
//       //   logr.d(results);
//       //   if (results.isEmpty) {
//       //     results = [
//       //       AdminSkillModel(
//       //         id: rpObjC.availableSkills!
//       //             .firstWhere((AdminSkillModel _sk) => _sk.title.toLowerCase().contains('others'))
//       //             .id,
//       //         title: '$_searchText',
//       //       ),
//       //     ];
//       //     return results;
//       //   } else {
//       //     return results;
//       //   }
//       // } else {
//       //   // return _searchText;
//       // }
//     } on PlatformException catch (e) {
//       if (e.code == 'not_available') {
//         return throw ('Please enter more info!');
//       }
//       print('Error in PlatformException => ${e.code}');
//       return throw ('${e.code}');
//     } catch (e) {
//       print('Error => $e');
//       return throw ('Something bad happen!');
//     }
//   }
//
//   createNewCustomTile(BuildContext context) {
//     return ListTile(
//       // we will display the data returned from our future here
//       title: Text(
//         'create_new_customer'.tr,
//         style: TextStyle(color: primaryColor),
//       ),
//       onTap: () {
//         close(
//           context,
//           ContactDataModel(
//             id: -1,
//             businessId: -1,
//             type: 'Customer',
//             name: 'Create New Customer',
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '/Config/utils.dart';
import '/Pages/CreateNewCustomer/showCustomerDetails.dart';
import '../../Controllers/ContactController/ContactController.dart';
import '../../Models/order_type_model/customer_contact_model.dart';
import '../../Theme/colors.dart';
import '../CreateNewCustomer/createNewCustomer.dart';
import '../CreateOrder/createOrderPage.dart';
import '../Receipts/receipts.dart';
import '../SalesView/SalesViewDetails/AddSalesAndQuotation.dart';
import '../SalesView/SalesViewDetails/SalesView.dart';

class CustomerSearch extends StatefulWidget {
  final int? dashBoardId;
  CustomerSearch({Key? key, this.dashBoardId}) : super(key: key);

  @override
  State<CustomerSearch> createState() => _CustomerSearchState();
}

class _CustomerSearchState extends State<CustomerSearch> {
  ScrollController? _scrollController;
  String? query;
  ContactController contactCtrlObj = Get.find<ContactController>();

  void initState() {
    contactCtrlObj.callFirstOrderPage();
    scrollControllerLis();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController?.removeListener(scrollControllerLis);
    contactCtrlObj.clearAllContactCtrl();
    super.dispose();
  }

  scrollControllerLis() {
    _scrollController = ScrollController();
    if (_scrollController != null) {
      _scrollController?.addListener(() {
        if (_scrollController?.position.pixels ==
            _scrollController?.position.maxScrollExtent) {
          //contactCtrlObj.isLoadMoreRunning.isTrue;
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
        title: TextFormField(
          //controller: searchCtrl,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'enter_some_text'.tr,
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            query = value;
            contactCtrlObj.fetchCustomerInfo(query);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                ),
                child: Text(
                    'suggesstions'.tr /*, style: theme.style16W800Orange*/),
              ),
              //createNewCustomTile(context),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: (widget.dashBoardId == 1)
          ? FloatingActionButton.small(
              child: Icon(Icons.add),
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
              onPressed: () {
                Get.to(CreateNewCustomer());
                // showDialog(
                //   context: context,
                //   builder: (context) => AlertDialog(
                //     contentPadding:
                //         const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                //     content: CreateNewCustomer(),
                //   ),
                // );
              })
          : null,
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
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      //  Get.close(0);

                                      contactCtrlObj.id = contactCtrlObj
                                          .customerContacts!
                                          .contactDataList[index]
                                          .id
                                          .toString();
                                      contactCtrlObj.contactId = contactCtrlObj
                                          .customerContacts!
                                          .contactDataList[index]
                                          .contactId;
                                      contactCtrlObj.searchCustomerCtrl.text =
                                          '${contactCtrlObj.customerContacts!.contactDataList[index].name} (${contactCtrlObj.customerContacts!.contactDataList[index].contactId})';
                                      contactCtrlObj.mobileNumberCtrl.text =
                                          contactCtrlObj
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
                                      if (widget.dashBoardId == 1) {
                                        Get.to(ShowCustomerDetails(
                                            contactApi: contactCtrlObj
                                                .customerContacts!
                                                .contactDataList[index]
                                                .id
                                                .toString()));
                                      } else if (widget.dashBoardId == 2) {
                                        Get.to(CreateOrderPage());
                                      } else if (widget.dashBoardId == 3) {
                                        Get.to(SalesView(
                                          isSalesReturn: true,
                                        ));
                                        // Get.to(Return());
                                      } else if (widget.dashBoardId == 4) {
                                        Get.to(Receipts());
                                        contactCtrlObj.update();
                                        // Get.close(2);
                                      } else if (widget.dashBoardId == 5) {
                                        Get.to(AddSalesAndQuotation());
                                      }
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 45,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Text(
                                          '${contactCtrlObj.customerContacts!.contactDataList[index].supplierBusinessName != null ? contactCtrlObj.customerContacts!.contactDataList[index].supplierBusinessName : contactCtrlObj.customerContacts!.contactDataList[index].name} (${contactCtrlObj.customerContacts!.contactDataList[index].contactId})',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                    color: kLightTextColor.withOpacity(0.2),
                                  ),
                                ],
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

  Future<ContactModel?> searchCustomer() async {
    try {
      //debugPrint('Search Query' + query);
      ContactController contactCtrlObj = Get.find<ContactController>();
      return contactCtrlObj.fetchCustomerInfo(query);
    } on PlatformException catch (e) {
      if (e.code == 'not_available') {
        return throw ('Please enter more info!');
      }
      print('Error in PlatformException => ${e.code}');
      return throw ('${e.code}');
    } catch (e) {
      print('Error => $e');
      return throw ('Something bad happen!');
    }
  }

  createNewCustomTile(BuildContext context) {
    return ListTile(
      // we will display the data returned from our future here
      title: Text(
        'create_new_customer'.tr,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
      onTap: () {
        ContactDataModel(
          id: -1,
          businessId: -1,
          type: 'Customer',
          name: 'Create New Customer',
        );
        contactCtrlObj.nameCtrl.clear();
        contactCtrlObj.mobileNumberCtrl.clear();
        contactCtrlObj.searchCustomerCtrl.text = 'create_new_customer'.tr;
        Get.close(1);
        // close(
        //   context,
        //   ContactDataModel(
        //     id: -1,
        //     businessId: -1,
        //     type: 'Customer',
        //     name: 'Create New Customer',
        //   ),
        // );
      },
    );
  }
}
