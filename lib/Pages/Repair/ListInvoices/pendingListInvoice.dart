import 'package:bizmodo_emenu/Controllers/RepairController/ListInvoicesController/listInvoicesController.dart';
import 'package:bizmodo_emenu/Pages/Repair/ListInvoices/pendingListInvoiceTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingListInvoice extends StatelessWidget {
  final String? status;
  const PendingListInvoice({super.key, this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton.small(
      //     child: Icon(Icons.add),
      //     backgroundColor:
      //     Theme.of(context).colorScheme.primary.withOpacity(0.5),
      //     onPressed: () {
      //       // Get.to(AddJobSheet());
      //     }),
      body: Stack(
        children: [
          GetBuilder(
            builder: (ListInvoicesController listInvCtrl) {
              return RefreshIndicator(
                onRefresh: () async {
                  //await crmCtrl.callFirstOrderPage();
                },
                child: Scrollbar(
                  controller: listInvCtrl.listInvoicesTabScrollCtrl,
                  child: ListView.builder(
                    controller: listInvCtrl.listInvoicesTabScrollCtrl,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return IntrinsicHeight(
                        child: GestureDetector(
                            onTap: () {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) => AlertDialog(
                              //     //title: title != null ? Text(title) : null,
                              //     contentPadding: const EdgeInsets.symmetric(
                              //         vertical: 15, horizontal: 0),
                              //     content: ViewFollowUp(),
                              //   ),
                              // );
                            },
                            child: PendingListInvoiceTile(status: status,)
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
