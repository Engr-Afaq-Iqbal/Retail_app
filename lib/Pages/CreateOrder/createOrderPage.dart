import 'package:bizmodo_emenu/Pages/CreateOrder/searchProducts.dart';
import 'package:bizmodo_emenu/Theme/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controllers/ContactController/ContactController.dart';
import '../../Theme/colors.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  ContactController contactCtrlObjj = Get.find<ContactController>();
  bool cannotSupply = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Customer Name:'),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: CheckboxListTile(
                        value: cannotSupply,
                        onChanged: (bool? value) {
                          setState(() {
                            cannotSupply = value!;
                            //customerVisitsCtrlObj.update();
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'Cannot Supply',
                          style: TextStyle(color: blackColor),
                        )),
                  ),
                ],
              ),
              Center(
                child: Text(
                  '${contactCtrlObjj.nameCtrl.text} (${contactCtrlObjj.contactId})',
                  style: appBarHeaderStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Product Name',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Stock',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Qty',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Amount',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    )
                  ],
                ),
              ),
              SearchProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
