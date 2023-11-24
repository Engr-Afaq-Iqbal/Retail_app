import 'package:bizmodo_emenu/Controllers/RepairController/ListInvoicesController/listInvoicesController.dart';
import 'package:bizmodo_emenu/Pages/Repair/AddJobSheet/AddJobSheetWidgets/addDeviceModelDialog.dart';
import 'package:bizmodo_emenu/Pages/Repair/RepairSettings/RepairSettingsOptions/SettingDeviceModels/settingDeviceModelTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingDeviceModel extends StatelessWidget {
  final String? status;
  const SettingDeviceModel({super.key, this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Models'),
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          backgroundColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.5),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                //title: title != null ? Text(title) : null,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 0),
                content: AddDeviceModelDialog(),
              ),
            );
          }),
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
                            child: SettingDeviceModelsTile()
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
