import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/CRMControllers/LeadsController/leadsController.dart';
import 'addFollowUpCategory.dart';
import 'followUpCategoryTile.dart';


class AllFollowUpCategory extends StatefulWidget {
  const AllFollowUpCategory({super.key});

  @override
  State<AllFollowUpCategory> createState() => _AllFollowUpCategoryState();
}

class _AllFollowUpCategoryState extends State<AllFollowUpCategory> {
  ScrollController? crmScrollCtrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followup Category'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          backgroundColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.5),
          onPressed: () {
            Get.to(AddFollowUpCategory(isUpdate: false,));
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
                  controller: crmScrollCtrl,
                  child: ListView.builder(
                    controller: crmScrollCtrl,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return IntrinsicHeight(
                        child: FollowUpCategoryTile(),
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
