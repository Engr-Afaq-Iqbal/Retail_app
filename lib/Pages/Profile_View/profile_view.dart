import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/custom_circular_button.dart';
import '../../Components/textfield.dart';
import '../../Config/utils.dart';
import '../../Controllers/ListUserController/ListUserController.dart';
import '../../Services/storage_services.dart';
import '../../Theme/colors.dart';
import '../../Theme/style.dart';
import 'UserInformation.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ListUserController listUserCtrl = ListUserController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'profile'.tr,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(20),
          //constraints: BoxConstraints(maxHeight: double.infinity),
          // height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width, //* 0.20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: kWhiteColor,
            //  boxShadow: [settingsPageBoxShadow()],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.02),
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: AppStorage.getLoggedUserData()
                          ?.staffUser
                          .media
                          ?.displayUrl ??
                      "",
                  imageBuilder: (context, imageProvider) => Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      progressIndicator(width: 10, height: 10),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(height: h * 0.02),
              Text(
                '${AppStorage.getLoggedUserData()?.staffUser.firstName ?? ''} ${AppStorage.getLoggedUserData()?.staffUser.lastName ?? ''}',
                style: appBarHeaderStyle,
              ),
              Text(
                '${AppStorage.getLoggedUserData()?.staffUser.username ?? ''}',
                style: hintGreyStyle,
              ),
              SizedBox(height: h * 0.03),
              Divider(),
              profileDetails(
                  context: context,
                  icons: Icons.call,
                  txt:
                      '${AppStorage.getLoggedUserData()?.staffUser.contactNo ?? '- -'}'),
              Divider(),
              profileDetails(
                  context: context,
                  icons: Icons.email,
                  txt:
                      '${AppStorage.getLoggedUserData()?.staffUser.email ?? '- -'}'),
              Divider(),
              profileDetails(
                context: context,
                icons: Icons.location_on,
                txt:
                    '${AppStorage.getLoggedUserData()?.staffUser.address ?? '- -'}',
              ),
              Divider(),
              SizedBox(height: h * 0.02),
              CustomButton(
                title: Expanded(
                  child: Center(
                    child: Text(
                      'update_password'.tr,
                      // overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize:
                            MediaQuery.of(context).size.width <= 900 ? 12 : 14,
                      ),
                    ),
                  ),
                ),
                // btnTxt: 'update_password'.tr,
                bgColor: Theme.of(context).colorScheme.primary,
                onTap: () {
                  _showPasswordDialog();
                },
              ),
              UserInformation()
            ],
          ),
        ),
      ),
    );
  }

  Row profileDetails({context, icons, txt}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icons, color: Colors.black),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            txt,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12),
          ),
        ),
      ],
    );
  }

  _showPasswordDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('change_password'.tr),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.33,
                child: Column(
                  children: [
                    AppFormField(
                      labelText: 'old_password'.tr,
                      validator: (String? v) {
                        if (v!.isEmpty) return 'old_password'.tr;
                        return null;
                      },
                      title: 'old_password'.tr,
                      controller: listUserCtrl.currentPasswordCtrl,
                    ),
                    AppFormField(
                      labelText: 'new_password'.tr,
                      validator: (String? v) {
                        if (v!.isEmpty) return 'new_password'.tr;
                        return null;
                      },
                      title: 'new_password'.tr,
                      controller: listUserCtrl.newPasswordCtrl,
                    ),
                    AppFormField(
                      labelText: 'confirm_password'.tr,
                      validator: (String? v) {
                        if (v!.isEmpty) return 'confirm_password'.tr;
                        return null;
                      },
                      title: 'confirm_password'.tr,
                      controller: listUserCtrl.confirmPasswordCtrl,
                    ),
                    CustomButton(
                      btnTxt: 'update_password'.tr,
                      bgColor: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        if (listUserCtrl.newPasswordCtrl.text ==
                            listUserCtrl.confirmPasswordCtrl.text) {
                          showProgress();
                          listUserCtrl.changePassword();
                        } else {
                          showToast('Password not matched');
                        }
                      },
                    )
                  ],
                ),
              )

              // AppFormField(
              //   controller: pasController,),

              );
        });
  }
}
