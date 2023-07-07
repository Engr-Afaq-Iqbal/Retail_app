import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../Config/const.dart';
import '/Services/storage_services.dart';

class BusinessLogoWidget extends StatelessWidget {
  const BusinessLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(AppImages.retailLogo);
    //   FadedScaleAnimation(
    //   CachedNetworkImage(
    //     imageUrl: '${AppStorage.getBusinessDetailsData()?.businessData?.logo}',
    //     // height: 35,
    //   ),
    //   durationInMilliseconds: 400,
    // );
  }
}
