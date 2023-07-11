import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:bizmodo_emenu/Config/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controllers/ThemeController/themeController.dart';
import '../../Theme/colors.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  final ThemeController themeController = Get.find();
  int themeColors = 0xFF11cdef;
  String selectedColor = 'FF008080';
  var colorTheme = Colors.deepPurple;

  addColorToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeColor', selectedColor);
  }

  List<String> colorsCode = [
    'FF008080',
    'ffFF0000',
    'FFFFFF00',
    'FF0000FF',
    'FF008000',
    'FF90EE90',
    'FFFFC0CB',
    'FFFFBF00',
    'FF4B0082',
    'FF964B00',
  ];
  List<String> colorsNames = [
    'Default Color',
    'Red Color',
    'Yellow Color',
    'Blue Color',
    'Green Color',
    'Light Green Color',
    'Pink Color',
    'Amber Color',
    'Indigo Color',
    'Brown Color',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Change Theme',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  itemCount: colorsCode.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, int index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                              radius: 15,
                              backgroundColor: Color(
                                  int.parse(colorsCode[index], radix: 16))),
                          title: Text('${colorsNames[index]}'),
                          onTap: () {
                            colorTheme = createMaterialColor(
                                Color(int.parse(colorsCode[index], radix: 16)));
                            selectedColor = colorsCode[index];
                            print(selectedColor);
                            print(colorTheme);
                          },
                        ),
                        Divider(
                          height: 0,
                        ),
                      ],
                    );
                  }),
              CustomButton(
                onTap: () async {
                  showProgress();
                  addColorToSF();
                  themeController.setThemeColor(color: selectedColor);
                  themeController.setPrimaryColor(colorTheme);
                },
                title: Text(
                  'Save',
                  style: TextStyle(color: kWhiteColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
