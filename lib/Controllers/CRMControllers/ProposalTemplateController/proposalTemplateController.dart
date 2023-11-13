import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Config/utils.dart';

class ProposalTemplateController extends GetxController{

  File? imageFile;
  TextEditingController ccCtrl = TextEditingController();
  TextEditingController bccCtrl = TextEditingController();
  TextEditingController subjectCtrl = TextEditingController();
  TextEditingController emailBodyCtrl = TextEditingController();
  TextEditingController attachmentCtrl = TextEditingController();

  Future attachmentImage() async {
    try {
      //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      final XFile? image =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      int? fileSizeInBytes = await image?.length();
      double fileSizeInKB = fileSizeInBytes! / 1024;
      double fileSizeInMB = fileSizeInKB / 1024;
      print('size ${fileSizeInMB}');
      print(fileSizeInMB);
      if (image != null && fileSizeInMB <= 5) {
        final imageTemporary = File(image.path);
        imageFile = imageTemporary;
        attachmentCtrl.text = imageFile?.path.toString() ?? '';
          update();

      } else if (fileSizeInMB > 1) {
        return showToast("File size is greater than 5MB");
      } else {
        return showToast('no_image_picked'.tr);
      }
    } on PlatformException catch (ex) {
      print('Failed to file: $ex');
    }
  }


}