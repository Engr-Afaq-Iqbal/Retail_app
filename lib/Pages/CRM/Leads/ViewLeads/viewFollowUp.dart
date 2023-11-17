import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewFollowUp extends StatefulWidget {
  const ViewFollowUp({Key? key}) : super(key: key);

  @override
  State<ViewFollowUp> createState() => _ViewFollowUpState();
}

class _ViewFollowUpState extends State<ViewFollowUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.45,
      // height: MediaQuery.of(context).size.height * 0.4,
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Follow Up Log'.tr,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              ],
            ),
            Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              'test',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              'Mr. Afaq Iqbal',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              'No Log Found!',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
