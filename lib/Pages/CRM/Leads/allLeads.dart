import 'package:bizmodo_emenu/Pages/CRM/Leads/addLeads.dart';
import 'package:bizmodo_emenu/Pages/CRM/Leads/viewLead.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/CRMControllers/LeadsController/leadsController.dart';
import 'allLeadsTile.dart';

class AllLeads extends StatefulWidget {
  const AllLeads({super.key});

  @override
  State<AllLeads> createState() => _AllLeadsState();
}

class _AllLeadsState extends State<AllLeads> {
  ScrollController? crmScrollCtrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('leads'.tr),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          backgroundColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.5),
          onPressed: () {
            Get.to(AddLeads());
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
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return IntrinsicHeight(
                        child: GestureDetector(
                            onTap: () {
                              Get.to(ViewLead());
                            },
                            child: AllLeadsTile(
                              // pastOrder: leadsCtrl
                              //     .allSaleOrders!.saleOrdersData[index],
                            )),
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
