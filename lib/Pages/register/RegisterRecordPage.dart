import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Config/const.dart';
import '/Theme/colors.dart';
import '../booking/booking_row.dart';
import '../booking/tablePastbooking.dart';
import '../booking/tableUpcomingbooking.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int currentIndex = 0;

  /// TODO: show register data, print register (should receive print page from server in html), close register option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: appBarBottomLine(),
        title: Text('booking'.tr),
        centerTitle: true,
      ),
      body: Container(
        child: Row(
          children: [
            Container(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.5,
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: DefaultTabController(
                length: 2,
                child: Builder(
                  // <---- Use a Builder Widget to get the context this this DefaultTabController
                  builder: (ctx) {
                    // Here we need to use ctx instead of context otherwise it will give null
                    final TabController? tabController = DefaultTabController.of(ctx);

                    tabController?.addListener(() {
                      if (!tabController.indexIsChanging) {
                        // When the tab has changed we are changing our currentIndex to the new index
                        setState(() => currentIndex = tabController.index);
                      }
                    });

                    return Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        title: TabBar(
                          indicatorColor: primaryColor,
                          labelStyle: TextStyle(fontSize: 16),
                          labelColor: primaryColor,
                          unselectedLabelStyle: TextStyle(fontSize: 16),
                          unselectedLabelColor: primaryColor.withOpacity(0.5),
                          tabs: [
                            Tab(icon: Text('upcomming'.tr)),
                            Tab(icon: Text('pastt'.tr)),
                          ],
                        ),
                        //title: Text('Tabs Demo'),
                      ),
                      body: TabBarView(
                        children: [
                          TableUpcomingbooking(),
                          TablePastbooking(),
                          // _buildWidgetA(),
                          // _buildWidgetB(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.grey.withOpacity(0.5),
              width: 1,
            ),
            Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.29,
                  maxWidth: MediaQuery.of(context).size.width * 0.29,
                ),
                //height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width * 0.29,
                // color: strikeThroughColor,
                child: BottomWidget())
          ],
        ),
      ),
    );
  }
}
