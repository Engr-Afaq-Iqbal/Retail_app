import 'package:bizmodo_emenu/Controllers/RepairController/JobSheetsControllers/JobSheetController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../AddJobSheet/addJobSheet.dart';


class JobSheetsTabs extends StatefulWidget {
  const JobSheetsTabs({Key? key}) : super(key: key);
  @override
  _JobSheetsTabsState createState() => _JobSheetsTabsState();
}

class _JobSheetsTabsState extends State<JobSheetsTabs> {

  @override
  initState() {
    // loadOrdersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Sheets'),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          backgroundColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.5),
          onPressed: () {
            Get.to(AddJobSheet());
          }),
      body: DefaultTabController(
        length: JobSheetController.viewJobSheetTabsList().length,
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Column(
            children: [
              Container(
                height: 35,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: TabBar(
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2, // Adjust the thickness of the underline
                      color: Theme.of(context)
                          .colorScheme
                          .primary, // Color of the underline
                    ),
                  ),
                  automaticIndicatorColorAdjustment: true,
                  tabs:  JobSheetController.viewJobSheetTabsList().map((_orderTab) {
                    return Tab(text: _orderTab.label);
                  }).toList(),
                ),
              ),
              Expanded(
                // child: OrdersListPage(),
                child: TabBarView(
                  children:  JobSheetController.viewJobSheetTabsList()
                      .map((_orderTab) => _orderTab.page)
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
