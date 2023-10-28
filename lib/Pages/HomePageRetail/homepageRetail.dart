import 'package:bizmodo_emenu/Config/utils.dart';
import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../Config/DateTimeFormat.dart';
import '../../Controllers/DashboardController/dashboardController.dart';
import '../../Controllers/FundsController/fundsController.dart';
import '../../Controllers/ProductController/all_products_controller.dart';
import '../../Models/Dashboard/limited_stocks.dart';
import '../../Models/Dashboard/my_accounts.dart';
import '../../Services/storage_services.dart';
import '../../const/CurvedContainer.dart';
import '../CustomesVisit/newCustomerVisits.dart';
import '../FundsTransfer/fundsTransfer.dart';
import '../Orders/View/OrdersTabPage.dart';
import '../Return/return.dart';
import '../SalesView/SalesViewDetails/SalesView.dart';
import '../Upload/upload.dart';
import '../ProductsPage/ItemsPage.dart';
import '../order_type/search_customer_page.dart';

class HomePageRetail extends StatefulWidget {
  const HomePageRetail({Key? key}) : super(key: key);

  @override
  State<HomePageRetail> createState() => _HomePageRetailState();
}

class _HomePageRetailState extends State<HomePageRetail> {
  DashboardController dashBoardCtrl = Get.find<DashboardController>();
  Future<void> _showDateRangePicker() async {
    List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
      context: context,
      startInitialDate: DateTime.now(),
      startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      startLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      endInitialDate: DateTime.now(),
      endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      endLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      type: OmniDateTimePickerType.dateAndTime,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );

    dashBoardCtrl.startDateCtrl.text = dateTimeList![0].toString();
    dashBoardCtrl.endDateCtrl.text = dateTimeList[1].toString();
    dashBoardCtrl.fetchDashboardData();
    setState(() {});
  }

  @override
  void initState() {
    if (!AppStorage.isStorageHasProductsData()) {
      Get.find<AllProductsController>().fetchAllProducts();
    } else {
      Get.find<AllProductsController>().getAllProductsFromStorage();
    }
    dashBoardCtrl.fetchDashboardData();
    // Get.find<AllProductsController>().fetchUnitList();
    Get.find<FundsController>().fetchPaymentAccountList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              CurvedContainer(),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: kWhiteColor,
                ),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // number of columns
                    mainAxisSpacing: 2.0, // space between rows
                    crossAxisSpacing: 0.0, // space between columns
                    childAspectRatio: 1.0, // width/height ratio of items
                  ),
                  itemCount: dashBoardCtrl.iconList.length,
                  itemBuilder: (context, index) {
                    return GridTile(
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              dashBoardCtrl.iconList[index],
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            onPressed: () {
                              // handle icon tap
                              if (index == 0) {
                                //Get.to(AddItem());
                                Get.to(ItemsPage());
                              }
                              if (index == 1) {
                                Get.to(CustomerSearch(
                                  dashBoardId: 1,
                                ));
                              }
                              if (index == 2) {
                                Get.to(CustomerSearch(
                                  dashBoardId: 2,
                                ));
                                //Get.to(CreateOrderPage());
                              }
                              if (index == 3) {
                                // Get.to(CustomerSearch(
                                //   dashBoardId: 3,
                                // ));
                                Get.to(Return());
                              }
                              if (index == 4) {
                                Get.to(CustomerSearch(
                                  dashBoardId: 4,
                                ));
                                // Get.to(Receipts());
                              }
                              if (index == 5) {
                                // Get.to(SalesTabPage());

                                Get.to(SalesView());
                              }
                              if (index == 6) {
                                Get.to(OrdersTabPage());
                              }
                              if (index == 7) {
                                //Get.to(CustomerVisits());
                                Get.to(NewCustomerVisit());
                              }
                              if (index == 8) {
                                Get.to(Upload());
                              }
                              if (index == 9) {
                                Get.to(FundsTransfer());
                              }
                            },
                          ),
                          Expanded(
                            child: Text(
                              dashBoardCtrl.iconsNames[index].tr,
                              style: TextStyle(color: blackColor, fontSize: 9),
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showDateRangePicker();
                      },
                      child: Icon(
                        Icons.calendar_month_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GetBuilder<DashboardController>(
                  builder: (DashboardController dashboardCtrlObj) {
                if (dashboardCtrlObj.homeTabModel == null) {
                  return progressIndicator();
                } else
                  return Container(
                    height: height * 0.55,
                    width: width * 0.85,
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // number of columns
                        mainAxisSpacing: 10.0, // space between rows
                        crossAxisSpacing: 10.0, // space between columns
                        childAspectRatio: 1.0, // width/height ratio of items
                      ),
                      itemCount: dashBoardCtrl.names.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (index == 8) {
                             print("8");
                               Get.to(MyAccounts());
                            } else if (index == 9) {
                              print("9");
                              Get.to(limitedStocks());
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.02,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppFormat.doubleToStringUpTo2(dashboardCtrlObj
                                            .namesData[index]) ==
                                        null
                                    ? SizedBox(
                                        height: 20,
                                      )
                                    : SizedBox(),
                                Center(
                                  child: Text(dashBoardCtrl.names[index].tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: kWhiteColor, fontSize: 9),
                                      textAlign: TextAlign.center),
                                ),
                                Text(
                                  AppFormat.doubleToStringUpTo2(dashboardCtrlObj
                                              .namesData[index]) !=
                                          null
                                      ? AppFormat.doubleToStringUpTo2(
                                          dashboardCtrlObj.namesData[index])!
                                      : " ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: kCardBackgroundColor,fontSize: 9),
                                )
                              ],
                            ),
                          ),
                        );
                      },
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
