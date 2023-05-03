import 'package:bizmodo_emenu/Components/counter_with_add_remove_button.dart';
import 'package:bizmodo_emenu/Controllers/ProductController/product_cart_controller.dart';
import 'package:bizmodo_emenu/Models/order_type_model/SellLineModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../CartItemDeleteButton.dart';

class OrderedCartItemTile extends StatelessWidget {
  final SellLine sellLineItem;
  OrderedCartItemTile({Key? key, required this.sellLineItem}) : super(key: key);

  final ProductCartController prodCartCtrlObj =
      Get.find<ProductCartController>();
  // final ProductCartController prodCartCtrlObj = Get.find<ProductCartController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                // if (prodCartCtrlObj.item != null) {
                //   Get.to(() => ItemInfoPage(prodCartCtrlObj.item!.value!));
                // }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                    imageUrl: '${sellLineItem.product?.imageUrl}'),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${sellLineItem.product?.name}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14),
                ),
                SizedBox(width: 8),
              ],
            ),
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  // Buttons for Increment / Decrement Item with counter information
                  CounterWithAddRemoveButton(
                    removeTabFun: (sellLineItem.quantity != null)
                        ? () {
                            if (sellLineItem.quantity > 1) {
                              prodCartCtrlObj
                                  .removeOrderedItemQuantity(sellLineItem);
                            } else if (sellLineItem.quantity == 1) {
                              prodCartCtrlObj
                                  .deleteOrderedItemFromCart(sellLineItem);
                            }
                          }
                        : null,
                    counter: '${sellLineItem.quantity}',
                    addTabFun: (sellLineItem.quantity != null)
                        ? () {
                            if (sellLineItem.quantity != 0) {
                              prodCartCtrlObj
                                  .addOrderedItemQuantity(sellLineItem);
                            }
                          }
                        : null,
                  ),
                  Spacer(),

                  // product total Price
                  Text(
                    prodCartCtrlObj.saleItemTotalAmount(
                      sellLineItem.unitPriceIncTax,
                      sellLineItem.quantity,
                    ),
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              // ListView.builder(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemCount: sellLineItem.variations?.variations.length,
              //   itemBuilder: (context, modifierIndex) {
              //     ProductModel prodMod = sellLineItem.variations?.variations[modifierIndex];
              //     return Container(
              //       margin: const EdgeInsets.all(2.5),
              //       padding: const EdgeInsets.all(5),
              //       decoration: BoxDecoration(
              //         border: Border(bottom: BorderSide(color: Colors.black26)),
              //       ),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text('${prodMod.name.capitalize}'),
              //           Wrap(
              //             children: prodMod.variations
              //                 .map(
              //                   (modVar) => Text(
              //                     ' - ${modVar.name} ( ${product.quantity * modVar.productVariationQuantity} )',
              //                   ),
              //                 )
              //                 .toList(),
              //           )
              //         ],
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
        Positioned(
          top: 2.5,
          right: 2.5,
          child: CartItemDeleteButton(
            onDeleteAction: () {
              prodCartCtrlObj.deleteOrderedItemFromCart(sellLineItem);
              //prodCartCtrlObj.deleteFromOrderItems(sellLineItem.id);
            },
          ),
        ),
      ],
    );
  }
}
