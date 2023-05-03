import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Config/const.dart';
import '/Pages/Orders/Controller/OrderController.dart';
import 'OrderedCartItemTile.dart';

class OrderedItemsCartPage extends StatelessWidget {
  const OrderedItemsCartPage({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: AppConst.dividerLineLight()),
        SliverPadding(
          padding: const EdgeInsets.only(top: 10.0),
          sliver: SliverToBoxAdapter(child: Text('orders'.tr)),
        ),
        GetBuilder<OrderController>(builder: (OrderController orderCtrlObj) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return OrderedCartItemTile(
                  sellLineItem: orderCtrlObj.singleOrderData!.sellLines[index],
                );
              },
              childCount: orderCtrlObj.singleOrderData?.sellLines.length,
            ),
          );
        }),
      ],
    );

    // return Scaffold(
    //   body: NestedScrollView(
    //     headerSliverBuilder: (context, isInnerScrollView) => [
    //       // SliverAppBar(
    //       //   backgroundColor: Colors.transparent,
    //       //   title: Text('cart'.tr),
    //       //   actions: [
    //       //     AppStyles.p12p5(
    //       //         CustomButton(btnTxt: 'Add Item', onTap: () => Get.to(() => HomePage())))
    //       //   ],
    //       // ),
    //     ],
    //     body:
    //   ),
    // );
  }
}
