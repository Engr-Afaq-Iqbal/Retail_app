import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Controllers/Notifications/NotificationsController.dart';
import '../../Theme/colors.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationsController notificationCtrlObj =
      Get.find<NotificationsController>();

  @override
  void initState() {
    // notificationCtrlObj.fetchNotificationsList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notifications'),
      ),
      body: GetBuilder(
          builder: (NotificationsController notificationsController) {
        // if (notificationsController.notificationShowingModelObj?.data == null)
        return progressIndicator();
        // return RefreshIndicator(
        //   onRefresh: () async {
        //     await Get.find<NotificationsController>().fetchNotificationsList();
        //   },
        //   child: ListView.builder(
        //     itemCount: notificationsController
        //         .notificationShowingModelObj?.data?.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return GestureDetector(
        //         onTap: () {
        //           if (notificationsController
        //                   .notificationShowingModelObj?.data?[index].readAt ==
        //               null) {
        //             notificationsController.notificationId =
        //                 notificationsController
        //                         .notificationShowingModelObj?.data?[index].id ??
        //                     '';
        //             notificationsController.notificationMarked();
        //             setState(() async {
        //               await Get.find<NotificationsController>()
        //                   .fetchNotificationsList();
        //             });
        //           }
        //         },
        //         child: Container(
        //           color: notificationsController.notificationShowingModelObj
        //                       ?.data?[index].readAt ==
        //                   null
        //               ? kLightTextColor.withOpacity(0.3)
        //               : null,
        //           padding: const EdgeInsets.only(
        //             left: 15.0,
        //             top: 10,
        //             right: 15,
        //           ),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Text(
        //                     notificationsController.notificationShowingModelObj
        //                             ?.data?[index].msg
        //                             .toString() ??
        //                         '',
        //                     style: TextStyle(
        //                         color: Theme.of(context).colorScheme.primary),
        //                   ),
        //                   Icon(
        //                     notificationsController.notificationShowingModelObj
        //                                 ?.data?[index].readAt ==
        //                             null
        //                         ? Icons.mark_email_unread_outlined
        //                         : Icons.email_outlined,
        //                     color: notificationsController
        //                                 .notificationShowingModelObj
        //                                 ?.data?[index]
        //                                 .readAt ==
        //                             null
        //                         ? Theme.of(context).colorScheme.primary
        //                         : kLightTextColor,
        //                   ),
        //                 ],
        //               ),
        //               Text(
        //                 notificationsController.notificationShowingModelObj
        //                         ?.data?[index].createdAt
        //                         .toString() ??
        //                     '',
        //                 style: TextStyle(fontSize: 11, color: kLightTextColor),
        //               ),
        //               SizedBox(
        //                 height: 10,
        //               ),
        //               Divider(
        //                 height: 0.1,
        //               ),
        //             ],
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // );
      }),
    );
  }
}
