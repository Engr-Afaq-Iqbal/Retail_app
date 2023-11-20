import 'package:bizmodo_emenu/Controllers/CRMControllers/LeadsController/leadsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'addFirstContainer.dart';
import 'addSecondContainer.dart';
import 'addThirdContainer.dart';


class AddJobSheet extends StatefulWidget {
  const AddJobSheet({super.key});

  @override
  State<AddJobSheet> createState() => _AddJobSheetState();
}

class _AddJobSheetState extends State<AddJobSheet> {
  LeadsController leadsCtrl = Get.find<LeadsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Job Sheet'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            AddFirstContainer(),
            SizedBox(height: 10,),
            AddSecondContainer(),
            SizedBox(height: 10,),
            AddThirdContainer(),
          ],
        ),
      ),
    );
  }
}
