import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Components/custom_circular_button.dart';
import '../../../Components/textfield.dart';
import '../../../Controllers/CRMControllers/SettingsController/settingsController.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';
import '../../../const/dimensions.dart';

class SettingsCRM extends StatefulWidget {
  const SettingsCRM({super.key});

  @override
  State<SettingsCRM> createState() => _SettingsCRMState();
}

class _SettingsCRMState extends State<SettingsCRM> {

  SettingsController settingsCtrl = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall, ),
                  color: kWhiteColor,
                  boxShadow: [BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 3,
                      color: kHintColor.withOpacity(0.2)
                  )]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: settingsCtrl.enableOrderRequest,
                        onChanged: (bool? value) {
                          setState(() {
                            settingsCtrl.enableOrderRequest = value!;
                          });
                        },
                      ),
                      // SizedBox(width: 5,),
                      title(txt: 'Enable Order Request'),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  title(txt: 'Order Request Prefix:*'),
                  SizedBox(
                    width: width * 0.85,
                    height: height * 0.07,
                    child: AppFormField(
                      labelText: 'Order Request Prefix',
                      isDense: true,
                      controller: settingsCtrl.orderRequestPrefixCtrl,
                    ),
                  ),

                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        title: Text('Update',style: TextStyle(color: kWhiteColor),),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        onTap: (){
                          Get.back();
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
