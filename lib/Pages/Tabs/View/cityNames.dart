import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/ContactController/ContactController.dart';

class CityNames extends StatefulWidget {
  const CityNames({Key? key}) : super(key: key);

  @override
  State<CityNames> createState() => _CityNamesState();
}

class _CityNamesState extends State<CityNames> {
  List<String> cityNames = [
    'Abu Dhabi',
    'Al Ain',
    'Al Ruwais',
    'Dubai',
    'Sharjah',
    'Khor fakkan',
    'Ajman',
    'Umm Al Quwain',
    'Ras Al Khaimah',
    'Fujairah',
    'Dibba',
  ];

  final ContactController contactCtrlObj = Get.find<ContactController>();
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.height * 0.63,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select City',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cityNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: GestureDetector(
                      onTap: () {
                        contactCtrlObj.cityCtrl.text = cityNames[index];
                        print(cityNames[index]);
                        Get.back();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            cityNames[index],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(),
                          ),
                          Divider(
                            thickness: 0.5,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
