import 'package:bizmodo_emenu/Pages/CRM/Proposals/viewProposal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/CRMControllers/LeadsController/leadsController.dart';
import '../Proposal Template/createProposalTemplate.dart';
import 'allProposalsTile.dart';


class AllProposals extends StatefulWidget {
  const AllProposals({super.key});

  @override
  State<AllProposals> createState() => _AllProposalsState();
}

class _AllProposalsState extends State<AllProposals> {
  ScrollController? crmScrollCtrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proposals'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          backgroundColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.5),
          onPressed: () {
            Get.to(CreateProposalTemplate(title: 'Proposal Send',));
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
                              Get.to(ViewProposal());
                            },
                            child: AllProposalsTile()),
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
