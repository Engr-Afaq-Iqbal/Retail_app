import 'package:bizmodo_emenu/Pages/CRM/Leads/ViewLeads/viewFollowUp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controllers/CRMControllers/LeadsController/leadsController.dart';
import '../addFollowUp.dart';
import 'followUpTabTile.dart';

class FollowUpTab extends StatelessWidget {
  const FollowUpTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          backgroundColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.5),
          onPressed: () {
            Get.to(AddFollowUp());
          }),
      body: Stack(
        children: [
          GetBuilder(
            builder: (LeadsController leadsCtrl) {
              return RefreshIndicator(
                onRefresh: () async {
                  //await crmCtrl.callFirstOrderPage();
                },
                child: Scrollbar(
                  controller: leadsCtrl.followUpTabScrollCtrl,
                  child: ListView.builder(
                    controller: leadsCtrl.followUpTabScrollCtrl,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return IntrinsicHeight(
                        child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  //title: title != null ? Text(title) : null,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 0),
                                  content: ViewFollowUp(),
                                ),
                              );
                            },
                            child: FollowUpTabTile()
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
