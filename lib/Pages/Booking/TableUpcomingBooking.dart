import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Config/DateTimeFormat.dart';
import '../../Config/utils.dart';
import '../../Controllers/Booking Controller/BookingController.dart';
import '../../Theme/colors.dart';
import '../../Theme/style.dart';
import 'booking_row.dart';

class TableUpcomingbooking extends StatefulWidget {
  @override
  State<TableUpcomingbooking> createState() => _TableUpcomingbookingState();
}

class _TableUpcomingbookingState extends State<TableUpcomingbooking> {
  @override
  void initState() {
    Get.find<BookingController>().fetchBookingList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.small(
            child: Icon(Icons.add),
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.5),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    child: BottomWidget(),
                  );
                },
              );
            }),
        body: GetBuilder<BookingController>(
            builder: (BookingController bookingCtrlObj) {
          if (bookingCtrlObj.bookingListModelObj?.bookings == null)
            return progressIndicator();
          return RefreshIndicator(
            onRefresh: () async {
              await Get.find<BookingController>().fetchBookingList();
            },
            child: ListView.builder(
                physics: ScrollPhysics(),
                itemCount:
                    bookingCtrlObj.bookingListModelObj?.bookings?.data?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  print(bookingCtrlObj.bookingListModelObj!.bookings!
                      .data![index].bookingStart!);
                  return (bookingCtrlObj.bookingListModelObj!.bookings!
                          .data![index].bookingStart!
                          .isAfter(DateTime.now()))
                      ? list_view(
                          customer_name: bookingCtrlObj.bookingListModelObj
                                  ?.bookings?.data?[index].customer?.name ??
                              '- - ',
                          persons_nbr: bookingCtrlObj.bookingListModelObj
                                  ?.bookings?.data?[index].noOfPerson ??
                              '- - ',
                          bookig_date: AppFormat.ddMMM12h(bookingCtrlObj
                              .bookingListModelObj
                              ?.bookings
                              ?.data?[index]
                              .bookingStart),
                          status: bookingCtrlObj.bookingListModelObj?.bookings
                                  ?.data?[index].bookingStatus
                                  ?.toUpperCase() ??
                              '- - ',
                          table_nbr: bookingCtrlObj.bookingListModelObj
                                  ?.bookings?.data?[index].table?.name
                                  .toString() ??
                              '- - ',
                        )
                      : SizedBox();
                }),
          );
        }));
  }
}

class list_view extends StatefulWidget {
  var customer_name;
  var bookig_date;
  var table_nbr;
  var persons_nbr;
  var status;
  list_view(
      {Key? key,
      this.customer_name,
      this.bookig_date,
      this.persons_nbr,
      this.status,
      this.table_nbr})
      : super(key: key);

  @override
  State<list_view> createState() => _list_viewState();
}

class _list_viewState extends State<list_view> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.customer_name,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Row(
                children: [
                  Text(
                    widget.table_nbr,
                  ),
                  SizedBox(width: 5),
                  Container(
                    height: 12,
                    width: 1,
                    color: Colors.black,
                  ),
                  SizedBox(width: 5),
                  Text(
                    widget.status,
                    style: AppStyles.orderMapAppBarTextStyle
                        .copyWith(color: kMainColor),
                  ),
                  // Text(
                  //   'Pending',
                  // )
                ],
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'booking_for'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 11.7, color: Colors.black),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.bookig_date,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 11.7,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
              Text(
                widget.persons_nbr + ' ' + 'persons'.tr,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 11.7, letterSpacing: 0.06, color: Colors.black),
              )
            ],
          ),
          Divider(
            color: Theme.of(context).cardColor,
            thickness: 8.0,
          ),
        ],
      ),
    );
  }
}
