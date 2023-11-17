import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/CRMControllers/LeadsController/leadsController.dart';
import 'addSource.dart';
import 'allSourceTile.dart';

class AllSource extends StatefulWidget {
  const AllSource({super.key});

  @override
  State<AllSource> createState() => _AllSourceState();
}

class _AllSourceState extends State<AllSource> {
  ScrollController? crmScrollCtrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sources'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          backgroundColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.5),
          onPressed: () {
            Get.to(AddSource(isUpdate: false,));
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
                        child: AllSourceTile(),
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
