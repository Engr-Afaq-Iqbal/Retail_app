import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/Services/storage_services.dart';
import '/Theme/style.dart';

class BusinessLogoWidget extends StatelessWidget {
  final bool isJustLogo;
  const BusinessLogoWidget({this.isJustLogo = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Business Logo => ${AppStorage.getBusinessDetailsData()?.businessData?.logo}');
    return Row(
      children: [
        FadedScaleAnimation(
          child: CachedNetworkImage(
            cacheKey: 'bizmodo_business_logo',
            imageUrl:
                '${AppStorage.getBusinessDetailsData()?.businessData?.logo}',
            height: 50,
            errorWidget: (_, __, ___) => SizedBox(),
          ),
          fadeDuration: Duration(milliseconds: 400),
        ),
        if (!isJustLogo)
          Expanded(
              child: Text(
            '${AppStorage.getBusinessDetailsData()?.businessData?.name}',
            style: appBarHeaderStyle,
          )),
      ],
    );
  }
}

// class BusinessLogoWidget extends StatelessWidget {
//   const BusinessLogoWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FadedScaleAnimation(
//       child: CachedNetworkImage(
//         imageUrl: '${AppStorage.getBusinessDetailsData()?.businessData?.logo}',
//         // height: 35,
//       ),
//       fadeDuration: Duration(milliseconds: 400),
//     );
//   }
// }
