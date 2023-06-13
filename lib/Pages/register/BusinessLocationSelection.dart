import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Services/storage_services.dart';
import '/Controllers/register/RegisterController.dart';
import '/Models/business_n_register/BusinessModel.dart';

class BusinessLocationSelection extends StatelessWidget {
  BusinessLocationSelection({Key? key}) : super(key: key);

  final RegisterController regCtrlObj = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount:
            AppStorage.getBusinessDetailsData()!.businessData!.locations.length,
        itemBuilder: (context, index) {
          BusinessLocationModel _bizLoc = AppStorage.getBusinessDetailsData()!
              .businessData!
              .locations[index];
          return ListTile(
            onTap: () {
              regCtrlObj.businessLocationCtrl.text = '${_bizLoc.name}';
              regCtrlObj.selectBusinessLocation = _bizLoc;
              Get.back();
            },
            title: Text('${_bizLoc.name}'),
          );
        },
      ),
    );
  }
}
