// import 'package:bizmodo_emenu/Theme/style.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '/Theme/colors.dart';
//
// class TablePastBooking extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         // onTap: () => Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => OrderMapPage(),
//         //   ),
//         // ),
//         child: ListView(
//           children: <Widget>[
//             list_view(
//               customer_name: 'ahmed'.tr,
//               persons_nbr: '7',
//               bookig_date: '8 Jun, 10.07 pm',
//               status: 'rebook'.tr,
//               table_nbr: '05',
//             ),
//             Divider(
//               color: Theme.of(context).cardColor,
//               thickness: 8.0,
//             ),
//             list_view(
//               customer_name: 'ahmed'.tr,
//               persons_nbr: '3',
//               bookig_date: '8 Jun, 11.00 am',
//               status: 'rebook'.tr,
//               table_nbr: '08',
//             ),
//             Divider(
//               color: Theme.of(context).cardColor,
//               thickness: 8.0,
//             ),
//             list_view(
//               customer_name: 'ahmed'.tr,
//               persons_nbr: '2',
//               bookig_date: '17 Jun, 9.00 am',
//               status: 'rebook'.tr,
//               table_nbr: '07',
//             ),
//             Divider(
//               color: Theme.of(context).cardColor,
//               thickness: 8.0,
//             ),
//             list_view(
//               customer_name: 'ahmed'.tr,
//               persons_nbr: '5',
//               bookig_date: '9 Jun, 11.40 am',
//               status: 'rebook'.tr,
//               table_nbr: '01',
//             ),
//             Divider(
//               color: Theme.of(context).cardColor,
//               thickness: 8.0,
//             ),
//             list_view(
//               customer_name: 'ahmed'.tr,
//               persons_nbr: '3',
//               bookig_date: '8 Jun, 11.00 pm',
//               status: 'rebook'.tr,
//               table_nbr: '02',
//             ),
//             Divider(
//               color: Theme.of(context).cardColor,
//               thickness: 8.0,
//             ),
//             list_view(
//               customer_name: 'ahmed'.tr,
//               persons_nbr: '3',
//               bookig_date: '8 Jun, 11.00 am',
//               status: 'rebook'.tr,
//               table_nbr: '06',
//             ),
//             Divider(
//               color: Theme.of(context).cardColor,
//               thickness: 8.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class list_view extends StatefulWidget {
//   var customer_name;
//   var bookig_date;
//   var table_nbr;
//   var persons_nbr;
//   var status;
//   list_view(
//       {Key? key,
//       this.customer_name,
//       this.bookig_date,
//       this.persons_nbr,
//       this.status,
//       this.table_nbr})
//       : super(key: key);
//
//   @override
//   State<list_view> createState() => _list_viewState();
// }
//
// class _list_viewState extends State<list_view> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 widget.customer_name,
//                 style: Theme.of(context)
//                     .textTheme
//                     .caption!
//                     .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
//               ),
//               Row(
//                 children: [
//                   Text(
//                     widget.table_nbr,
//                   ),
//                   SizedBox(width: 5),
//                   Container(
//                     height: 12,
//                     width: 1,
//                     color: Colors.black,
//                   ),
//                   SizedBox(width: 5),
//                   Text(
//                     widget.status,
//                     style: AppStyles.orderMapAppBarTextStyle.copyWith(color: kMainColor),
//                   ),
//                   // Text(
//                   //   'Pending',
//                   // )
//                 ],
//               )
//             ],
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     'booking_for'.tr,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline6!
//                         .copyWith(fontSize: 11.7, color: Colors.black),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                     widget.bookig_date,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline6!
//                         .copyWith(fontSize: 11.7, fontWeight: FontWeight.bold, color: Colors.black),
//                   )
//                 ],
//               ),
//               Text(
//                 widget.persons_nbr + 'personss'.tr,
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline6!
//                     .copyWith(fontSize: 11.7, letterSpacing: 0.06, color: Colors.black),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/utils.dart';
import '/Controllers/Booking Controller/BookingController.dart';
import '/Pages/booking/tableUpcomingbooking.dart';
import '../../Config/DateTimeFormat.dart';

class TablePastbooking extends StatefulWidget {
  @override
  State<TablePastbooking> createState() => _TablePastbookingState();
}

class _TablePastbookingState extends State<TablePastbooking> {
  @override
  void initState() {
    Get.find<BookingController>().fetchBookingList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<BookingController>(
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
              return (bookingCtrlObj
                      .bookingListModelObj!.bookings!.data![index].bookingStart!
                      .isBefore(DateTime.now()))
                  ? list_view(
                      customer_name: bookingCtrlObj.bookingListModelObj
                              ?.bookings?.data?[index].customer?.name ??
                          '- - ',
                      persons_nbr: bookingCtrlObj.bookingListModelObj?.bookings
                              ?.data?[index].noOfPerson ??
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
                      table_nbr: bookingCtrlObj.bookingListModelObj?.bookings
                              ?.data?[index].table?.name
                              .toString() ??
                          '- - ',
                    )
                  : SizedBox();
            }),
      );
    }));
  }
}
