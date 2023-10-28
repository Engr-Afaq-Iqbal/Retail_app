import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:bizmodo_emenu/Pages/Profile_View/profile_view.dart';
import 'package:bizmodo_emenu/Theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../Controllers/DashboardController/dashboardController.dart';
import '../Pages/AppMenu/AppMenuPage.dart';
import '../Pages/Notifications/notifications.dart';
import '../Services/storage_services.dart';

class CurvedContainer extends StatefulWidget {
  @override
  State<CurvedContainer> createState() => _CurvedContainerState();
}

class _CurvedContainerState extends State<CurvedContainer> {
  DashboardController dashBoardCtrl = Get.find<DashboardController>();
  TextEditingController controller = TextEditingController();

  ///Date time range picker
  // Future<void> _showDateRangePicker() async {
  //   List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
  //     context: context,
  //     startInitialDate: DateTime.now(),
  //     startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
  //     startLastDate: DateTime.now().add(
  //       const Duration(days: 3652),
  //     ),
  //     endInitialDate: DateTime.now(),
  //     endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
  //     endLastDate: DateTime.now().add(
  //       const Duration(days: 3652),
  //     ),
  //     is24HourMode: false,
  //     isShowSeconds: false,
  //     minutesInterval: 1,
  //     secondsInterval: 1,
  //     type: OmniDateTimePickerType.dateAndTime,
  //     borderRadius: const BorderRadius.all(Radius.circular(16)),
  //     constraints: const BoxConstraints(
  //       maxWidth: 350,
  //       maxHeight: 650,
  //     ),
  //     transitionBuilder: (context, anim1, anim2, child) {
  //       return FadeTransition(
  //         opacity: anim1.drive(
  //           Tween(
  //             begin: 0,
  //             end: 1,
  //           ),
  //         ),
  //         child: child,
  //       );
  //     },
  //     transitionDuration: const Duration(milliseconds: 200),
  //     barrierDismissible: true,
  //     selectableDayPredicate: (dateTime) {
  //       // Disable 25th Feb 2023
  //       if (dateTime == DateTime(2023, 2, 25)) {
  //         return false;
  //       } else {
  //         return true;
  //       }
  //     },
  //   );
  //
  //   dashBoardCtrl.startDateCtrl.text = dateTimeList![0].toString();
  //   dashBoardCtrl.endDateCtrl.text = dateTimeList[1].toString();
  //   dashBoardCtrl.fetchDashboardData();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _MyClipper(),
      child: Container(
        height: 210,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      //height: 150,
                      width: MediaQuery.of(context).size.width * 0.75,
                      // width: isPortrait ? 200 : 300,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'searchItem'.tr,
                          hintStyle: TextStyle(fontSize: 10),
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.background,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onChanged: (value) {},
                      )),

                  GestureDetector(
                    onTap: () {
                      Get.to(() => Notifications());
                    },
                    child: Icon(
                      Icons.notification_add_outlined,
                      color: kWhiteColor,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(AppMenuPage(),);
                    },
                    child: Icon(
                      Icons.menu_outlined,
                      color: kWhiteColor,
                    ),
                  ),
                  // Icon(
                  //   Icons.add,
                  //   color: kWhiteColor,
                  // )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.to(ProfileView());
                },
                child: Row(
                  children: [
                    // ClipRect(
                    //   child: CircleAvatar(
                    //     backgroundColor: kWhiteColor,
                    //     radius: 32,
                    //   ),
                    // ),

                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          AppStorage.getLoggedUserData()
                                  ?.staffUser
                                  .media
                                  ?.displayUrl ??
                              ''),
                      // child: Image.network(
                      //   AppStorage.getLoggedUserData()
                      //           ?.staffUser
                      //           .media
                      //           ?.displayUrl ??
                      //       "",
                      //   // height: 100,
                      //   // width: 100,
                      // ),
                    ),
                    // Container(
                    //   height: 35,
                    //   width: 100,
                    //   decoration: BoxDecoration(shape: BoxShape.circle),
                    //   child: ClipOval(
                    //     child: FadedScaleAnimation(
                    //       CachedNetworkImage(
                    //         imageUrl:
                    //             '${AppStorage.getLoggedUserData()?.staffUser.media?.displayUrl ?? ''}',
                    //       ),
                    //       durationInMilliseconds: 400,
                    //     ),
                    //     // CachedNetworkImage(
                    //     //   imageUrl: AppStorage.getLoggedUserData()
                    //     //           ?.staffUser
                    //     //           .media
                    //     //           ?.fileName ??
                    //     //       "",
                    //     //   imageBuilder: (context, imageProvider) => Container(
                    //     //     height: MediaQuery.of(context).size.height * 0.3,
                    //     //     width: MediaQuery.of(context).size.width * 0.3,
                    //     //     decoration: BoxDecoration(
                    //     //       image: DecorationImage(
                    //     //         image: imageProvider,
                    //     //         fit: BoxFit.cover,
                    //     //       ),
                    //     //     ),
                    //     //   ),
                    //     //   placeholder: (context, url) =>
                    //     //       progressIndicator(width: 100, height: 100),
                    //     //   errorWidget: (context, url, error) => Icon(Icons.error),
                    //     // ),
                    //   ),
                    // ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${AppStorage.getLoggedUserData()?.staffUser.firstName ?? ''} ${AppStorage.getLoggedUserData()?.staffUser.lastName ?? ''}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: kWhiteColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
