import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Pages/Booking/TablePastBooking.dart';
import '/Pages/Booking/TableUpcomingBooking.dart';

class BookingTabs extends StatefulWidget {
  const BookingTabs({Key? key}) : super(key: key);
  @override
  _BookingTabsState createState() => _BookingTabsState();
}

class _BookingTabsState extends State<BookingTabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            height: 35,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: TabBar(
              tabs: [
                Tab(text: 'upcomming'.tr),
                Tab(text: 'pastt'.tr),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                TableUpcomingbooking(),
                TablePastbooking(),
                //BookingPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
