import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:bizmodo_emenu/Models/ProductsModel/ProductVariationAndModifierModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Components/custom_circular_button.dart';
import '/Components/multi_selection_chip.dart';
import '/Controllers/ProductController/all_products_controller.dart';
import '/Controllers/ProductController/product_cart_controller.dart';
import '/Models/ProductsModel/ProductModel.dart';
import '../Config/utils.dart';
import '../Theme/colors.dart';

class ItemInfoPage extends StatefulWidget {
  final ProductModel item;

  ItemInfoPage(this.item);
  @override
  _ItemInfoPageState createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  final AllProductsController allProductsController =
      Get.find<AllProductsController>();

  List<ModifierModel> productModifiersAndVariations = [];
  // Map<String, ModifierModel> theProductModifiersAndVariations = {};

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: FadedSlideAnimation(
          child: Column(
            children: [
              Align(alignment: Alignment.topRight, child: CloseButton()),

              /// Item Image
              CachedNetworkImage(
                  imageUrl: widget.item.imageUrl ?? "",
                  height: Get.height * 0.3,
                  fit: BoxFit.contain),

              /// Modifiers
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // TODO: Product Name, Product Price ...

                      /// Item Description
                      if (widget.item.productDescription != null)
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('description'.tr),
                              Text('${widget.item.productDescription}'),
                            ],
                          ),
                        ),
                      // Modifiers
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          itemCount: widget.item.modifier.length,
                          itemBuilder: (context, _modifierIndex) {
                            final ProductModel _modifier = widget
                                .item.modifier[_modifierIndex].productModifier;

                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadedScaleAnimation(
                                  child: CachedNetworkImage(
                                    imageUrl: _modifier.imageUrl ?? "",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        progressIndicator(
                                            width: 10, height: 10),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  fadeDuration:
                                      const Duration(milliseconds: 400),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${_modifier.name.capitalize}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (_modifier.variations.isNotEmpty)
                                        MultiSelectChip(
                                          initChoices: <VariationModel>[],
                                          chipsDataList: _modifier.variations,
                                          onSelectionChanged: (value) {
                                            try {
                                              productModifiersAndVariations
                                                  .removeWhere((e) =>
                                                      e.productModifier.id ==
                                                      _modifier.id);
                                            } catch (_e) {}
                                            // theProductModifiersAndVariations[_modifier.id] =
                                            //     _modifier.copyWith(variations: value);

                                            productModifiersAndVariations.add(
                                              widget
                                                  .item.modifier[_modifierIndex]
                                                  .copyWith(
                                                productModifier:
                                                    _modifier.copyWith(
                                                  variations: value,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      // GridView.builder(
                                      //   shrinkWrap: true,
                                      //   physics: const NeverScrollableScrollPhysics(),
                                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      //     crossAxisCount: isPortrait ? 3 : 4,
                                      //     crossAxisSpacing: 10,
                                      //     mainAxisSpacing: 10,
                                      //   ),
                                      //   itemCount: _modifier.variations.length,
                                      //   itemBuilder: (context, variationIndex) {
                                      //     final VariationModel? _variation =
                                      //         _modifier.variations[variationIndex];
                                      //
                                      //     return GestureDetector(
                                      //       onTap: () {
                                      //         // setState(() {
                                      //         //   if (selectedModifier == index) {
                                      //         //     selectedModifier = -1;
                                      //         //   } else {
                                      //         //     selectedModifier = index;
                                      //         //   }
                                      //         // });
                                      //       },
                                      //       child: Container(
                                      //         padding: const EdgeInsets.all(5.0),
                                      //         decoration: BoxDecoration(
                                      //           borderRadius: BorderRadius.circular(8),
                                      //           // color: selectedModifier == index
                                      //           //     ? Theme.of(context).colorScheme.primary
                                      //           //     : Theme.of(context).scaffoldBackgroundColor,
                                      //         ),
                                      //         child: Text('${_variation?.name}'),
                                      //       ),
                                      //     );
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      // Add to cart button
                      CustomButton(
                        onTap: () {
                          // productModifiersAndVariations.forEach((value) {
                          //   value.productModifier.variations.forEach((element) {
                          //     logger.d(
                          //         '${value.productModifier.name}, ${element.name} => ${element.productVariationQuantity}');
                          //   });
                          // });
                          Get.find<ProductCartController>().updateCart(
                            widget.item.copyWith(
                                modifier: productModifiersAndVariations),
                            isAdd: true,
                          );
                          Get.back(result: true);
                        },
                        padding: EdgeInsets.all(20),
                        bgColor: Theme.of(context).colorScheme.primary,
                        title: Text(
                          'add'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 16, color: kWhiteColor),
                        ),
                      ),
                      // Text(
                      //   "Add On",
                      //   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      // ),
                      // if (widget.item.modifier.isNotEmpty)
                      //   GridView.builder(
                      //     physics: NeverScrollableScrollPhysics(),
                      //     itemCount: widget.item.modifier.length,
                      //     shrinkWrap: true,
                      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: isPortrait ? 3 : 4,
                      //       crossAxisSpacing: 10,
                      //       mainAxisSpacing: 10,
                      //     ),
                      //     itemBuilder: (BuildContext context, int index) {
                      //       final ProductModel? modifier =
                      //           widget.item.modifier[index].productModifier;
                      //
                      //       return GestureDetector(
                      //         onTap: () {
                      //           setState(() {
                      //             if (selectedModifier == index) {
                      //               selectedModifier = -1;
                      //             } else {
                      //               selectedModifier = index;
                      //             }
                      //           });
                      //         },
                      //         child: Container(
                      //           padding: const EdgeInsets.all(5.0),
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(8),
                      //             color: selectedModifier == index
                      //                 ? Theme.of(context).colorScheme.primary
                      //                 : Theme.of(context).scaffoldBackgroundColor,
                      //           ),
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //             children: [
                      //               Expanded(
                      //                 child: FadedScaleAnimation(
                      //                   CachedNetworkImage(
                      //                     imageUrl: modifier?.imageUrl ?? "",
                      //                     imageBuilder: (context, imageProvider) => Container(
                      //                       decoration: BoxDecoration(
                      //                         image: DecorationImage(
                      //                           image: imageProvider,
                      //                           fit: BoxFit.cover,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     placeholder: (context, url) => SizedBox(
                      //                       width: 10,
                      //                       height: 10,
                      //                       child: CircularProgressIndicator(
                      //                         color: primaryColor,
                      //                         strokeWidth: 1,
                      //                       ),
                      //                     ),
                      //                     errorWidget: (context, url, error) => Icon(Icons.error),
                      //                   ),
                      //                   durationInMilliseconds: 400,
                      //                 ),
                      //               ),
                      //               SizedBox(height: 2.5),
                      //               Text(modifier?.name ?? ""),
                      //             ],
                      //           ),
                      //         )
                      //         /*Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Container(
                      //             decoration: BoxDecoration(
                      //                 color:
                      //                     selectedModifier == index ? primaryColor : Colors.white,
                      //                 borderRadius: BorderRadius.circular(10),
                      //                 border: Border.all(width: 1, color: Colors.grey)),
                      //             child: Padding(
                      //               padding:
                      //                   const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      //               child: Column(
                      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                 children: [
                      //                   Text(
                      //                     modifier?.productModifier.name ?? "",
                      //                     style: TextStyle(color: Colors.grey),
                      //                   ),
                      //                   Text(
                      //                     "\$ 1.0",
                      //                     style: TextStyle(color: Colors.grey),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         )*/
                      //         ,
                      //       );
                      //     },
                      //   ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          fadeCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }
}
