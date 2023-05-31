import 'package:bizmodo_emenu/Components/custom_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
  var colorTheme = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Theme',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xFFFF0000),
                ),
                title: Text('Red Theme'),
                onTap: () {
                  colorTheme = Colors.red;
                },
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xFFFFFF00),
                ),
                title: Text('Yellow Theme'),
                onTap: () {
                  colorTheme = Colors.yellow;
                },
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: primaryColor,
                ),
                title: Text('Purple Theme'),
                onTap: () {
                  colorTheme = Colors.purple;
                },
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blue,
                ),
                title: Text('Blue Theme'),
                onTap: () {
                  colorTheme = Colors.blue;
                },
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0x4b008200),
                ),
                title: Text('Dark Green Theme'),
                onTap: () {
                  colorTheme = Colors.green;
                },
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xee82ee00),
                ),
                title: Text('Light Green Theme'),
                onTap: () {
                  colorTheme = Colors.lightGreen;
                },
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.pink,
                ),
                title: Text('Pink Theme'),
                onTap: () {
                  colorTheme = Colors.pink;
                },
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.amber,
                ),
                title: Text('Amber Theme'),
                onTap: () {
                  colorTheme = Colors.amber;
                },
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.teal,
                ),
                title: Text('Teal Theme'),
                onTap: () {
                  colorTheme = Colors.teal;
                },
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.indigo,
                ),
                title: Text('Indigo Theme'),
                onTap: () {
                  colorTheme = Colors.indigo;
                },
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.brown,
                ),
                title: Text('Brown Theme'),
                onTap: () {
                  colorTheme = Colors.brown;
                },
              ),
              Divider(
                height: 0,
              ),
              CustomButton(
                onTap: () async {
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
