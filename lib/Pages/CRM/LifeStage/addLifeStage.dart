import 'package:bizmodo_emenu/Controllers/CRMControllers/SourceController/sourceController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../../../Components/custom_circular_button.dart';
import '../../../Components/textfield.dart';
import '../../../Config/const.dart';
import '../../../Theme/colors.dart';
import '../../../Theme/style.dart';
import '../../../const/dimensions.dart';

class AddLifeStage extends StatefulWidget {
  final bool isUpdate;
  const AddLifeStage({super.key, this.isUpdate = false});

  @override
  State<AddLifeStage> createState() => _AddLifeStageState();
}

class _AddLifeStageState extends State<AddLifeStage> {

  SourceController sourceCtrl = Get.find<SourceController>();
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('Add Life Stage'),),
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
                  title(txt: 'Life Stage:*'),
                  SizedBox(
                    width: width * 0.85,
                    height: height * 0.07,
                    child: AppFormField(
                      labelText: 'Life Stage',
                      isDense: true,
                      controller: sourceCtrl.sourceCtrl,
                    ),
                  ),
                  title(txt: 'Description:*'),
                  SizedBox(
                    width: width * 0.85,
                    // height: height * 0.07,
                    child: AppFormField(
                      isLabel: true,
                      maxLines: 5,
                      labelText: 'Description',
                      isDense: true,
                      controller: sourceCtrl.descriptionCtrl,
                    ),
                  ),

                  if(widget.isUpdate)
                  title(txt: 'Color:*'),
                  if(widget.isUpdate)
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Pick a color!'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: pickerColor,
                                onColorChanged: changeColor,
                                showLabel: true, // optional
                                pickerAreaHeightPercent: 0.8, // optional
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('Save'),
                                onPressed: () {
                                  setState(() => currentColor = pickerColor);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      width: width * 0.85,
                      height: 25,
                      color: currentColor,
                    ),
                  ),
                  if(widget.isUpdate)
                  SizedBox(height: 20,),
                  if(widget.isUpdate)
                  title(txt: 'Image:*'),
                  if(widget.isUpdate)
                  Row(
                    children: [
                      CustomButton(
                        title: Text('Choose File',style: TextStyle(color: kWhiteColor),),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        onTap: (){
                        },
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'No file chosen'
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  AppConst.dividerLine(color: kHintColor.withOpacity(0.2)),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        title: Text(widget.isUpdate == true ? 'Update' :'Save',style: TextStyle(color: kWhiteColor),),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        onTap: (){
                        },
                      ),
                      SizedBox(width: 5,),
                      CustomButton(
                        title: Text('Close',style: TextStyle(color: kWhiteColor),),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        onTap: (){
                          Get.back();
                        },
                      )
                    ],
                  )
                ],),
            )
          ],
        ),
      ),
    );
  }
}
