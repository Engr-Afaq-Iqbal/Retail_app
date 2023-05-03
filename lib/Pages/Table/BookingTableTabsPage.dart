// import 'package:bizmodo_emenu/Pages/Table/TablesPage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '/Pages/Booking/tab_bar_booking.dart';
//
// class BookingTableTabPage extends StatefulWidget {
//   const BookingTableTabPage({Key? key}) : super(key: key);
//
//   @override
//   State<BookingTableTabPage> createState() => _BookingTableTabPageState();
// }
//
// class _BookingTableTabPageState extends State<BookingTableTabPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DefaultTabController(
//         length: 2,
//         child: Column(
//           children: [
//             Container(
//               height: 35,
//               width: MediaQuery.of(context).size.width,
//               color: Colors.white,
//               child: TabBar(
//                 indicatorWeight: 3,
//                 tabs: [
//                   Tab(text: 'table_drop'.tr),
//                   Tab(text: 'booking_tab'.tr),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   // TableBottomSheet(),
//                   TablesPage(isForBookedTables: true),
//                   BookingTabs(),
//                   //BookingPage(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
