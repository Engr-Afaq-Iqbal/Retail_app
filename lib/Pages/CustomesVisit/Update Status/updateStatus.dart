import 'dart:io';
import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Controllers/CustomerVisits/CustomerVisitsController.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../../Components/textfield.dart';
import '../../../Config/DateTimeFormat.dart';
import '../../../Config/utils.dart';
import '../../../Controllers/StockTransferController/stockTransferController.dart';
import '../../../Services/storage_services.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';
import 'meetDetailsView.dart';

class UpdateStatus extends StatefulWidget {
  const UpdateStatus({Key? key}) : super(key: key);

  @override
  State<UpdateStatus> createState() => _UpdateStatusState();
}

class _UpdateStatusState extends State<UpdateStatus> {
  CustomerVisitsController custVisitsCtrlObj =
      Get.find<CustomerVisitsController>();
  String? statusValue;
  File? image;
  String frontPath = 'No file chosen';

  Future pickContactImage() async {
    try {
      //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final imageTemporary = File(image.path);
        frontPath = image.path;
        setState(() {
          this.image = imageTemporary;
        });
      } else {
        return showToast("No Image picked");
      }
    } on PlatformException catch (ex) {
      print('Failed to pick Image: $ex');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headings(txt: 'Update Status (#2022/0001)'),
            Divider(),
            SizedBox(
              height: 10,
            ),
            headings(txt: 'Did you meet with the contact?'),
            GetBuilder<CustomerVisitsController>(
                builder: (CustomerVisitsController customerVisitsCtrlObj) {
              return Row(
                children: [
                  Expanded(
                    // height: 20,
                    // width: M,
                    child: CheckboxListTile(
                        value: customerVisitsCtrlObj.meetYes,
                        onChanged: (bool? value) {
                          setState(() {
                            customerVisitsCtrlObj.meetYes = value!;
                            customerVisitsCtrlObj.meetNo = false;
                            customerVisitsCtrlObj.update();
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'Yes',
                          style: TextStyle(color: blackColor),
                        )),
                  ),
                  Expanded(
                    // height: 20,
                    // width: 20,
                    child: CheckboxListTile(
                        value: customerVisitsCtrlObj.meetNo,
                        onChanged: (bool? value) {
                          setState(() {
                            customerVisitsCtrlObj.meetNo = value!;
                            customerVisitsCtrlObj.meetYes = false;
                            customerVisitsCtrlObj.update();
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'No',
                          style: TextStyle(color: blackColor),
                        )),
                  ),
                ],
              );
            }),
            if (custVisitsCtrlObj.meetNo == true)
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headings(txt: 'Reason:'),
                      AppFormField(
                        width: width * 0.885,
                        controller: custVisitsCtrlObj.meetNoReason,
                        labelText: 'Please Select',
                      ),
                    ],
                  ),
                ],
              ),
            //if (custVisitsCtrlObj.valueSecond == true)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headings(
                        txt: 'Take photo of the contact or visited place:*'),
                    Row(
                      children: [
                        CustomButton(
                          title: Text(
                            'Choose File',
                            style: TextStyle(color: kWhiteColor),
                          ),
                          height: 20,
                          borderRadius: 5,
                          onTap: () {
                            pickContactImage();
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          frontPath,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                headings(txt: 'Visited On:'),
                SizedBox(
                  width: 5,
                ),
                Text('05/11/2023 08:21')
              ],
            ),
            SizedBox(
              height: 15,
            ),
            MeetDetailsView(),
            SizedBox(
              height: 15,
            ),
            IntrinsicHeight(
              child: Container(
                width: width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kWhiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        headings(txt: 'Visited address:'),
                        SizedBox(
                          width: 5,
                        ),
                        CustomButton(
                          title: Text(
                            'Get current location',
                            style: TextStyle(color: kWhiteColor),
                          ),
                          height: 20,
                          borderRadius: 5,
                          onTap: () {},
                        )
                      ],
                    ),
                    Text('Southwest 17th Way, Christian Gardens'),
                    SizedBox(
                      height: 10,
                    ),
                    headings(txt: 'Discussions with the contact:'),
                    AppFormField(
                      controller: custVisitsCtrlObj.discussionCtrl,
                      labelText: '',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          title: Text(
                            'Update',
                            style: TextStyle(color: kWhiteColor),
                          ),
                          onTap: () {},
                          bgColor: primaryColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomButton(
                          title: Text(
                            'Close',
                            style: TextStyle(color: kWhiteColor),
                          ),
                          onTap: () {
                            Get.back();
                          },
                          bgColor: buttonColor,
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text headings({required String txt}) {
    return Text(
      txt,
      style: appBarHeaderStyle,
      softWrap: true,
      maxLines: 2,
    );
  }
}
