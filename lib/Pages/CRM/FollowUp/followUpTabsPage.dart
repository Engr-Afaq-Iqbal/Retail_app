import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:get/get.dart';
import 'package:bizmodo_emenu/Controllers/CRMControllers/FollowUpController/followUpController.dart';
import 'package:bizmodo_emenu/Pages/CRM/Leads/addFollowUp.dart';
import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:flutter/material.dart';


class FollowUpTabs extends StatefulWidget {
  const FollowUpTabs({Key? key}) : super(key: key);
  @override
  _FollowUpTabsState createState() => _FollowUpTabsState();
}

class _FollowUpTabsState extends State<FollowUpTabs> {

  @override
  initState() {
    // loadOrdersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Follow Ups'),
        actions: [
          CustomButton(
            title: Text('+ Add',style: TextStyle(color: kWhiteColor),),
            onTap: (){
              Get.to(AddFollowUp());
            },
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: DefaultTabController(
        length: FollowUpController.viewFollowUpsTabsList().length,
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
                  tabs:  FollowUpController.viewFollowUpsTabsList().map((_orderTab) {
                    return Tab(text: _orderTab.label);
                  }).toList(),
                ),
              ),
              Expanded(
                // child: OrdersListPage(),
                child: TabBarView(
                  children:  FollowUpController.viewFollowUpsTabsList()
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
