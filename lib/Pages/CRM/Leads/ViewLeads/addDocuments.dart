import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Components/textfield.dart';
import '../../../../Controllers/CRMControllers/LeadsController/leadsController.dart';
import '../../../../Theme/colors.dart';
import '../../../../const/dimensions.dart';


class AddDocuments extends StatefulWidget {
  const AddDocuments({super.key});

  @override
  State<AddDocuments> createState() => _AddDocumentsState();
}

class _AddDocumentsState extends State<AddDocuments> {
  LeadsController leadsCtrl = Get.find<LeadsController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Note'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              color: kWhiteColor,
              boxShadow: [BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 3,
                  color: kHintColor.withOpacity(0.2)
              )]
          ),
          child: IntrinsicHeight(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title(txt: 'Heading:*'),
                      SizedBox(
                        width: width * 0.85,
                        height: height * 0.07,
                        child: AppFormField(

                          isDense: true,
                          controller: leadsCtrl.docHeadingCtrl,
                        ),
                      ),
                    ],
                  ),

                  //Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title(txt: 'Description:'),
                      AppFormField(
                        maxLines: 4,
                        controller: leadsCtrl.docDescCtrl,
                      ),
                    ],
                  ),

                  //Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title(txt: 'Documents:'),
                      AppFormField(
                        maxLines: 4,
                        controller: leadsCtrl.docDocumentsCtrl,
                        readOnly: true,
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Checkbox(
                        value: leadsCtrl.isPrivateCheckedDocs,
                        onChanged: (bool? value) {
                          setState(() {
                            leadsCtrl.isPrivateCheckedDocs = value!;
                          });
                        },
                      ),
                      // SizedBox(width: 5,),
                      title(txt: 'Is Private?'),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        title: Text('Close',style: TextStyle(color: kWhiteColor),),
                        onTap: () => Get.back(),
                      ),
                      SizedBox(width: 10,),
                      CustomButton(
                        title: Text('Save',style: TextStyle(color: kWhiteColor),),
                        onTap: (){
                          Get.back();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  title({String? txt}){
    return Text('$txt', style: TextStyle(fontWeight: FontWeight.bold),);
  }
}
