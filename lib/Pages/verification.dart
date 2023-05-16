import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Components/colorButton.dart';
import '/Components/textfield.dart';
import 'ProductsPage/home_page.dart';

class Verification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'enter_verification_code'.tr,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          color: Colors.blueGrey.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'sent_at_given_number'.tr,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          color: Colors.blueGrey.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Row(
                      children: [
                        Text('enter_verification_code'.tr,
                            style: TextStyle(
                              color: Colors.grey[600],
                            )),
                      ],
                    ),
                    AppFormField(
                      title: "5 7 8 4 1 0",
                      controller: TextEditingController(),
                    )
                  ],
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Row(
                      children: [
                        ColorButton('submit_capitall'.tr),
                      ],
                    )),
                Spacer(),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        curve: Curves.linearToEaseOut,
      ),
    );
  }
}
