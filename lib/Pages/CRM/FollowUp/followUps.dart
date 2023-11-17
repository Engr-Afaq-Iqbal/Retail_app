import 'package:bizmodo_emenu/Pages/CRM/Leads/ViewLeads/viewFollowUp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/CRMControllers/FollowUpController/followUpController.dart';
import 'followUpsTile.dart';

class FollowUps extends StatelessWidget {
  const FollowUps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton.small(
      //     child: Icon(Icons.add),
      //     backgroundColor:
      //     Theme.of(context).colorScheme.primary.withOpacity(0.5),
      //     onPressed: () {
      //       // Get.to(AddFollowUp());
      //     }),
      body: Stack(
        children: [
          GetBuilder(
            builder: (FollowUpController followUpsCtrl) {
              return RefreshIndicator(
                onRefresh: () async {
                  //await crmCtrl.callFirstOrderPage();
                },
                child: Scrollbar(
                  controller: followUpsCtrl.followUpTabScrollCtrl,
                  child: ListView.builder(
                    controller: followUpsCtrl.followUpTabScrollCtrl,
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
                            child: FollowUpsTile()
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
