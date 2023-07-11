import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Components/counter_with_add_remove_button.dart';
import '/Config/DateTimeFormat.dart';
import '/Controllers/ProductController/product_cart_controller.dart';
import '/Models/ProductsModel/ProductModel.dart';
import '/Pages/cart/CartItemDeleteButton.dart';

class CartItemTile extends StatelessWidget {
  final ProductModel product;
  CartItemTile(this.product, {Key? key}) : super(key: key);

  final ProductCartController prodCartCtrlObj =
      Get.find<ProductCartController>();

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
                borderRadius: BorderRadius.circular(8),
                child: FadedScaleAnimation(
                  child: CachedNetworkImage(imageUrl: '${product.imageUrl}'),
                  fadeDuration: const Duration(milliseconds: 400),
                ),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${product.name}',
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
                    removeTabFun: () {
                      if (product.quantity > 1) {
                        prodCartCtrlObj.removeItemQuantity(product);
                      } else if (product.quantity == 1) {
                        prodCartCtrlObj.deleteFromCart(product);
                      }
                    },
                    counter: '${product.quantity}',
                    addTabFun: () {
                      if (product.quantity != 0) {
                        prodCartCtrlObj.addItemQuantity(product);
                      }
                    },
                  ),
                  Spacer(),
                  Text(
                    AppFormat.doubleToStringUpTo2(
                            '${product.productVariations.first.variations.first.sellPriceIncTax}') ??
                        '-',
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  // product total Price
                  Text(
                    AppFormat.doubleToStringUpTo2(
                            '${product.productTotalPrice}') ??
                        '-',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: product.modifier.length,
                itemBuilder: (context, modifierIndex) {
                  ProductModel prodMod =
                      product.modifier[modifierIndex].productModifier;
                  return Container(
                    margin: const EdgeInsets.all(2.5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black26)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${prodMod.name.capitalize}'),
                        Wrap(
                          children: prodMod.variations
                              .map(
                                (modVar) => Text(
                                  ' - ${modVar.name} ( ${product.quantity * modVar.productVariationQuantity} )',
                                ),
                              )
                              .toList(),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: 2.5,
          right: 2.5,
          child: CartItemDeleteButton(
            onDeleteAction: () {
              // if (isForUpdate) {
              //   prodCartCtrlObj?.deleteFromOrderItems(orderCtrlObj.singleOrderData.sellLine);
              // } else {
              prodCartCtrlObj.deleteFromCart(product);
              // }
            },
          ),
        ),
      ],
    );
  }
}
