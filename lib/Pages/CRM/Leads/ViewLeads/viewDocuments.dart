import 'package:bizmodo_emenu/Config/DateTimeFormat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewDocument extends StatefulWidget {
  const ViewDocument({Key? key}) : super(key: key);

  @override
  State<ViewDocument> createState() => _ViewDocumentState();
}

class _ViewDocumentState extends State<ViewDocument> {
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
                  'View Document & Notes',
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
              'bodyyy testing',
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
              'Documents',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(),
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Icon(Icons.download, color: Theme.of(context).primaryColor,),
                SizedBox(width: 5,),
                Text(
                  'test.png',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                Icon(Icons.edit_outlined),
                SizedBox(width: 10,),
                Text(
                  'Haseeb Syed',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                ),
                SizedBox(width: 10,),
                Text('${
                AppFormat.dateOnly(DateTime.now())
                }'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
