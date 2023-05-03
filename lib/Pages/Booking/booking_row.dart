import 'package:bizmodo_emenu/Pages/Booking/searchCustomer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../Components/bottom_bar.dart';
import '../../Components/textfield.dart';
import '../../Config/DateTimeFormat.dart';
import '../../Config/enums.dart';
import '../../Config/utils.dart';
import '../../Controllers/Booking Controller/BookingController.dart';
import '../../Controllers/ContactController/ContactController.dart';
import '../../Controllers/ProductController/product_cart_controller.dart';
import '../../Controllers/ServiceStaffController/ServiceStaffController.dart';
import '../../Controllers/TableSelectionController/table_management_controller.dart';
import '../../Theme/colors.dart';

class Cat {
  final String? title;

  Cat(this.title);
}

class BottomWidget extends StatefulWidget {
  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message codewaa: ${message.messageId}");
}

class _BottomWidgetState extends State<BottomWidget> {
  int forIndex = 0;
  int dateIndex = 0;
  int timeIndex = 0;
  DateTime startDate = DateTime.now();

  final BookingController bookingCtrl = Get.find<BookingController>();
  final TableSelectionController tableCtrlObj =
      Get.find<TableSelectionController>();

  final ServiceStaffController serviceStaffCtrlObj =
      Get.find<ServiceStaffController>();
  final ContactController contactCtrlObj = Get.find<ContactController>();
  final ProductCartController productCartControllerObj =
      Get.find<ProductCartController>();
  List<String> customersList = [];

  Future<List<String>> getFreeTable() async {
    customersList = [];
    // if (tableCtrlObj.tableRecord() != null)
    for (var _itr in tableCtrlObj.tableRecord()!) {
      //if (tableCtrlObj.tableRecord()?[i].status == TableStatus.FREE)checkTableAvailability() &&
      if (isTableAvailable(_itr.id)) {
        print(isTableAvailable(_itr.id));
        print(_itr.name);
        customersList.add(_itr.name);
      }
    }

    // await Future.delayed(Duration.zero);
    return customersList;
  }

  ///function to check availabilty of the table
  bool isTableAvailable(int tableId) {
    for (int i = 0;
        i < bookingCtrl.bookingListModelObj!.bookings!.data!.length;
        i++) {
      if (bookingCtrl.bookingListModelObj!.bookings!.data?[i].bookingStart!
                  .compareTo(startDate) ==
              0 &&
          bookingCtrl.bookingListModelObj?.bookings?.data?[i].tableId ==
              tableId) {
        print("Both dates and table are same");
        return false;
      }
    }
    return true;
  }

  ///Function to get Service Staff Data
  List<String> getServiceStaff() {
    List<String> serviceStaffList = [];
    if (serviceStaffCtrlObj.serviceStaffModel != null &&
        serviceStaffCtrlObj.serviceStaffModel!.isNotEmpty)
      for (int i = 0; i < serviceStaffCtrlObj.serviceStaffModel!.length; i++) {
        serviceStaffList.add(
            '${serviceStaffCtrlObj.serviceStaffModel?[i].firstName}' ?? '');
      }
    print(serviceStaffList);
    return serviceStaffList;
  }

  ///Date time range picker
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

    bookingCtrl.dateTimeController.text =
        '${AppFormat.dateDDMMYY(dateTimeList![0])}   To   ${AppFormat.dateDDMMYY(dateTimeList[1])}';
    bookingCtrl.startDateCtrl.text = '${dateTimeList[0]}';
    bookingCtrl.endDateCtrl.text = '${dateTimeList[1]}';
    startDate = dateTimeList[0];
    setState(() {
      bookingCtrl.secondMethod = false;
      bookingCtrl.selectStartDateCtrl.clear();
      bookingCtrl.selectStartTimeCtrl.clear();
      dateIndex = 0;
      timeIndex = 0;
    });
  }

  ///function to check the availibility of the Table for the specific time interval
  // bool checkTableAvailability({bool compTable = true}) {
  // for (int i = 0;
  //     i < (bookingCtrl.bookingListModelObj?.bookings?.data?.length ?? 0);
  //     i++) {
  //   print('Start Booking Date => $startDate');
  //   print(
  //       'Start Booking Date Compare with booking list => ${bookingCtrl.bookingListModelObj!.bookings!.data?[i].bookingStart!.compareTo(startDate)}');
  //   print('Selected Table ID => ${bookingCtrl.tableId}');
  //   print(
  //       'Booked Table ID => ${bookingCtrl.bookingListModelObj?.bookings?.data?[i].tableId}');
  //   if (bookingCtrl.bookingListModelObj!.bookings!.data?[i].bookingStart!
  //           .compareTo(startDate) !=
  //       0) {
  //     return true;
  //   }
  //   if (!compTable) {
  //     return false;
  //   }
  //
  //   if (bookingCtrl.tableId != null &&
  //       bookingCtrl.bookingListModelObj?.bookings?.data?[i].tableId ==
  //           bookingCtrl.tableId) {
  //     print("Both dates and table are same");
  //     showToast('Have another booking at this time');
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
  // }

  final List<Cat> cat = [
    Cat('pe'.tr),
    Cat('per'.tr),
    Cat('pers'.tr),
    Cat('perso'.tr),
    Cat('person'.tr),
    Cat('person6'.tr),
    Cat('person7'.tr),
    Cat('person8'.tr),
    Cat('person9'.tr),
    Cat('person10'.tr),
    Cat('person11'.tr),
    Cat('person12'.tr),
    Cat('person13'.tr),
    Cat('person14'.tr),
    Cat('person15'.tr),
  ];

  @override
  void initState() {
    // TODO: implement initState
    tableCtrlObj.fetchTables();
    serviceStaffCtrlObj.fetchingServiceStaff();
    bookingCtrl.clearAllCtrl();
    contactCtrlObj.clearAllContactCtrl();
    bookingCtrl.fetchBookingList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> time = [
      "09:00 am",
      "10:00 am",
      "11:00 am",
      "12:00 pm",
      "13:00 pm",
      "14:00 pm",
      "15:00 pm",
      "16:00 pm",
      "17:00 pm",
      "18:00 pm",
      "19:00 pm",
      "20:00 pm",
      "21:00 pm",
      "22:00 pm",
      "23:00 pm",
      "00:00 am"
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30),
            Text(
              'tabletext'.tr.toUpperCase(),
              style: Theme.of(context).textTheme.caption!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 1.5),
            ),
            SizedBox(height: 25),
            AppFormField(
              prefixIcon: Icon(Icons.person),
              // isDense: true,
              readOnly: true,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    title: Text('search_customer'.tr),
                    content: SearchCustomerBooking(),
                  ),
                );
              },
              padding: EdgeInsets.only(bottom: 5),
              labelText: 'search_customer'.tr,
              title: 'search_customer'.tr,
              maxLines: 1,
              controller: contactCtrlObj.customerNameCtrl,
              //width: MediaQuery.of(context).size.width * 0.27,
            ),

            SizedBox(height: 20),
            Text(
              'booking'.tr,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            // SizedBox(height: 20),
            Container(
              height: 35.0,
              //margin: EdgeInsets.only(left: 12),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: cat.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          forIndex = index;
                          bookingCtrl.noOfPersonsCtrl.text = '${index + 1}';
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 5),
                          height: 33.3,
                          width: 83.3,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: forIndex == index
                                  ? primaryColor
                                  : Colors.white,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color:
                                forIndex == index ? primaryColor : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            cat[index].title!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: forIndex == index ? 13 : 12.0,
                                    color: forIndex == index
                                        ? Colors.white
                                        : Colors.black),
                          )),
                    );
                  }),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'select_date'.tr,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            // SizedBox(height: 20),
            Container(
              height: 35.0,
              // margin: EdgeInsets.only(left: 12),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: bookingCtrl.dateList().length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          dateIndex = index;
                          bookingCtrl.secondMethod = true;
                          bookingCtrl.dateTimeController.text =
                              'select_date_range'.tr;
                          bookingCtrl.selectStartDateCtrl.text =
                              AppFormat.dateYYMMDD(
                                  bookingCtrl.dateList()[index]);
                          if (timeIndex == 16) {
                            bookingCtrl.autoEndDateCtrl.text =
                                AppFormat.dateYYMMDD(
                                    bookingCtrl.dateList()[index + 1]);
                          } else {
                            bookingCtrl.autoEndDateCtrl.text =
                                AppFormat.dateYYMMDD(
                                    bookingCtrl.dateList()[index]);
                          }

                          // bookingCtrl.endDateCtrl.text =
                          //     bookingCtrl.dateList()[index];
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 5),
                          height: 33.3,
                          width: 83.3,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: dateIndex == index
                                  ? primaryColor
                                  : Colors.white,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: dateIndex == index
                                ? primaryColor
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppFormat.dateMonthOnly(
                                bookingCtrl.dateList()[index]),
                            //dateValues[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontSize: dateIndex == index ? 13 : 12.0,
                                    color: dateIndex == index
                                        ? Colors.white
                                        : Colors.black),
                          )),
                    );
                  }),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'select_time'.tr,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            // SizedBox(height: 20),
            Container(
              height: 35.0,
              //margin: EdgeInsets.only(left: 12),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: time.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          timeIndex = index;
                          bookingCtrl.secondMethod = true;
                          bookingCtrl.dateTimeController.text =
                              'select_date_range'.tr;
                          bookingCtrl.selectStartTimeCtrl.text = time[index];
                          if (index == 15) {
                            bookingCtrl.autoEndTimeCtrl.text = "01:00 am";
                          } else {
                            bookingCtrl.autoEndTimeCtrl.text = time[index + 1];
                          }

                          if (time[index] == "00:00 am") {
                            dateIndex = dateIndex + 1;
                          }
                          print(dateIndex);
                        });
                      },
                      child: Container(
                          height: 33.3,
                          width: 83.3,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: timeIndex == index
                                    ? primaryColor
                                    : Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: timeIndex == index
                                ? primaryColor
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            time[index],
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontSize: timeIndex == index ? 13 : 12.0,
                                    color: timeIndex == index
                                        ? Colors.white
                                        : Colors.black),
                          )),
                    );
                  }),
            ),

            SizedBox(height: 20),
            Text(
              'date_time_range'.tr,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),

            AppFormField(
              prefixIcon: Icon(Icons.calendar_month),
              // isDense: true,
              readOnly: true,
              onTap: _showDateRangePicker,
              padding: EdgeInsets.only(bottom: 5),
              //labelText: 'select_date_range'.tr,
              //labelText: 'date_time_range'.tr,
              // title: 'date_time_range'.tr + ':*',
              maxLines: 1,
              controller: bookingCtrl.dateTimeController,
              //width: MediaQuery.of(context).size.width * 0.27,
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    // width: MediaQuery.of(context).size.width * 0.1,
                    child: GetBuilder<TableSelectionController>(
                        builder: (TableSelectionController tableCtrlObj) {
                      return DropdownButtonHideUnderline(
                        child: FutureBuilder<List<String>>(
                            future: getFreeTable(),
                            builder: (context, snapshot) {
                              return DropdownButton2(
                                isExpanded: true,
                                hint: Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      'select_table'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontSize: 12, color: blackColor),
                                    )),
                                items: snapshot.data?.map((e) {
                                  return DropdownMenuItem(
                                      value: e, child: Text(e));
                                }).toList(),
                                value: bookingCtrl.tableIDName,
                                dropdownDirection:
                                    DropdownDirection.textDirection,
                                dropdownMaxHeight:
                                    MediaQuery.of(context).size.height * 0.6,
                                dropdownPadding: EdgeInsets.only(left: 5),
                                buttonPadding:
                                    EdgeInsets.only(left: 5, right: 5),
                                onChanged: (String? value) {
                                  setState(() {
                                    bookingCtrl.tableIDName = value!;
                                    bookingCtrl.tableId = tableCtrlObj
                                        .tableRecord()?[
                                            customersList.indexOf(value)]
                                        .id;
                                    print(bookingCtrl.tableId);
                                  });
                                },
                                buttonHeight: 40,
                                buttonWidth:
                                    MediaQuery.of(context).size.width * 0.46,
                                buttonDecoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: primaryColor.withOpacity(0.6)),
                                    borderRadius: BorderRadius.circular(10)),
                                itemHeight: 40,
                                itemPadding: EdgeInsets.zero,
                                itemHighlightColor: primaryColor,
                              );
                            }),
                      );
                    })),
                Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    // width: MediaQuery.of(context).size.width * 0.1,
                    child: GetBuilder<ServiceStaffController>(builder:
                        (ServiceStaffController serviceStaffController) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                'service_staff'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 12, color: blackColor),
                              )),
                          items: getServiceStaff().map((e) {
                            return DropdownMenuItem(value: e, child: Text(e));
                          }).toList(),
                          value: bookingCtrl.serviceStaff,
                          dropdownDirection: DropdownDirection.textDirection,
                          dropdownMaxHeight:
                              MediaQuery.of(context).size.height * 0.6,
                          dropdownPadding: EdgeInsets.only(left: 5),
                          buttonPadding: EdgeInsets.only(left: 5, right: 5),
                          onChanged: (String? value) {
                            setState(() {
                              bookingCtrl.serviceStaff = value;
                              bookingCtrl.serviceStaffCtrl.text =
                                  serviceStaffCtrlObj
                                      .serviceStaffModel![
                                          getServiceStaff().indexOf(value!)]
                                      .id
                                      .toString();
                              print(bookingCtrl.serviceStaffCtrl.text);
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: MediaQuery.of(context).size.width * 0.46,
                          buttonDecoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: primaryColor.withOpacity(0.6)),
                              borderRadius: BorderRadius.circular(10)),
                          itemHeight: 40,
                          itemPadding: EdgeInsets.zero,
                          itemHighlightColor: primaryColor,
                        ),
                      );
                    })),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'add_note'.tr,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            //   SizedBox(height: 20),
            Container(
              height: 100,
              //margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: TextField(
                    style: TextStyle(color: blackColor),
                    controller: bookingCtrl.bookingNoteCtrl,
                    decoration: InputDecoration(
                        hintText: 'for_my_aniversery'.tr,
                        hintStyle:
                            TextStyle(fontSize: 12, color: Colors.grey[400]),
                        border: InputBorder.none)),
              ),
            ),
            SizedBox(height: 20),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: BottomBar(
                text: 'book_a_table'.tr,
                onTap: () {
                  if (bookingCtrl.tableIDName == null) {
                    showToast('Select Booking Table');
                  } else if (bookingCtrl.serviceStaff == null) {
                    showToast('Select Service Staff');
                  } else if (/*checkTableAvailability() == */ true) {
                    if (bookingCtrl.secondMethod == true) {
                      bookingCtrl.startDateCtrl.text =
                          bookingCtrl.selectStartDateCtrl.text +
                              ' ' +
                              bookingCtrl.selectStartTimeCtrl.text;
                      bookingCtrl.endDateCtrl.text =
                          bookingCtrl.autoEndDateCtrl.text +
                              ' ' +
                              bookingCtrl.autoEndTimeCtrl.text;
                    }

                    print('table booked');

                    ///function to create booking
                    bookingCtrl.createNewBooking();

                    // productCartControllerObj.sendNotificationofOrderCompletion(
                    //   token: productCartControllerObj.token,
                    //   id: AppStorage.getLoggedUserData()!
                    //       .staffUser
                    //       .id
                    //       .toString(),
                    //   body: 'Booking Created Successfully ',
                    //   title: 'Booking Created',
                    // );

                    ///make table status change:
                    tableCtrlObj.changeTableStatus(
                        bookingCtrl.tableId!, TableStatus.RESERVED);

                    setState(() {
                      bookingCtrl.clearAllCtrl();
                      forIndex = 0;
                      dateIndex = 0;
                      timeIndex = 0;
                    });
                    Navigator.pop(context, true);
                  } else {
                    setState(() {
                      bookingCtrl.clearAllCtrl();
                      forIndex = 0;
                      dateIndex = 0;
                      timeIndex = 0;
                    });
                    Navigator.pop(context, true);
                  }

                  //progressIndicator();
                  //Get.find<BookingController>().fetchBookingList();
                },
                //onTap: () => Navigator.pushNamed(context, PageRoutes.tablebooked),
              ),
            )
          ],
        ),
      ),
    );
  }
}
