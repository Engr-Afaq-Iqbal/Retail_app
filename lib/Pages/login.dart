import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Components/custom_circular_button.dart';
import '/Components/textfield.dart';
import '/Config/app_config.dart';
import '/Config/const.dart';
import '/Config/utils.dart';
import '/Controllers/AuthController/auth_controller.dart';
import '/Pages/forget_screen.dart';
import '/Services/socket_handlers.dart';
import '/Theme/colors.dart';
import 'Notification Services/notification_services.dart';
import 'Tabs/View/TabsPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authCtrl = Get.find<AuthController>();
  //NotificationServices notificationServices = NotificationServices();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadedScaleAnimation(
                      Container(
                        width: 100,
                        height: 100,
                        child: Image(image: AssetImage(AppImages.retailIcon)),
                      ),
                      durationInMilliseconds: 200,
                    ),
                    FadedScaleAnimation(
                      Text(
                        AppConfig.appName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black, fontSize: 18),
                      ),
                      durationInMilliseconds: 200,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        child: AppFormField(
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'user'.tr,
                          validator: (String? v) {
                            if (v!.isEmpty) return 'user_name_required'.tr;
                            return null;
                          },
                          title: 'user_name'.tr,
                          controller: authCtrl.userNameCtrl,
                        ),
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        width: 300,
                        child: AppFormField(
                          isPasswordField: true,
                          labelText: 'password'.tr,
                          validator: (String? v) {
                            if (v!.isEmpty) return 'password_required'.tr;
                            return null;
                          },
                          title: 'password'.tr,
                          controller: authCtrl.passwordCtrl,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => ForgetPasswordScreen());
                            },
                            child: Text(
                              'forget_password'.tr,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          SizedBox(width: 30),
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomButton(
                        onTap: () async {
                          if (!formKey.currentState!.validate()) return;

                          showProgress();

                          bool token = await authCtrl.getToken();
                          if (!token) {
                            stopProgress();
                            return;
                          }

                          bool login = await authCtrl.getLoginUserDetail();
                          if (!login) {
                            stopProgress();
                            return;
                          }

                          bool businessSetting =
                              await authCtrl.getBusinessSetting();
                          if (!businessSetting) {
                            stopProgress();
                            return;
                          }

                          if (socketService == null)
                            socketService = SocketService();

                          socketService!.emitUser();

                          // notificationServices.requestNotificationPermission();
                          // notificationServices.firebaseInit();
                          // notificationServices
                          //     .getDeviceToken()
                          //     .then((value) async {
                          //   print('Token Value');
                          //   print(value);
                          //   authCtrl.token = value;
                          //   bool? tokenStoring =
                          //       await authCtrl.sendTokenToServer();
                          //   if (!tokenStoring!) {
                          //     stopProgress();
                          //     return;
                          //   }
                          // });

                          // Get.offAll(OrderTypeSelection());
                          Get.offAll(TabsPage());
                        },
                        btnTxt: 'continue'.tr,
                        padding: const EdgeInsets.all(12.5),
                        btnTxtAxisSize: MainAxisSize.min,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
