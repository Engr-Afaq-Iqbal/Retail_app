import 'package:bizmodo_emenu/Controllers/StockTransferController/stockTransferController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Config/utils.dart';
import '/Controllers/ProductController/all_products_controller.dart';
import 'ViewProductsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final PageController _pageController = PageController();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AllProductsController allProdCtrlObj = Get.find<AllProductsController>();
  ScrollController? _scrollController;

  @override
  void initState() {
    //allProdCtrlObj.searchProductList(term: '');
    allProdCtrlObj.getProductShowList();
    scrollControllerLis();
    super.initState();
  }

  void dispose() {
    super.dispose();
    _scrollController?.removeListener(scrollControllerLis);
  }

  scrollControllerLis() {
    _scrollController = ScrollController();
    if (_scrollController != null) {
      _scrollController?.addListener(() {
        if (_scrollController?.position.pixels ==
            _scrollController?.position.maxScrollExtent) {
          //contactCtrlObjj.isLoadMoreRunning.isTrue;
          Get.find<AllProductsController>().loadMoreSaleOrders();
          //Get.find<ContactController>().callFirstOrderPage();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton.small(
      //     child: Icon(Icons.add),
      //     backgroundColor:
      //         Theme.of(context).colorScheme.primary.withOpacity(0.5),
      //     onPressed: () {
      //       Get.to(AddProductsPage(
      //         isView: false,
      //       ));
      //     }),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Container(
            // width: isPortrait ? 200 : 300,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'searchItem'.tr,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                filled: true,
                fillColor: Theme.of(context).colorScheme.background,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              onChanged: (value) {
                Get.find<StockTransferController>()
                    .searchProductList(term: '${value}');
              },
            )),
        // actions: [buildItemsInCartButton()],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    ///SKU
                    Expanded(
                      flex: 1,
                      child: Text('sku'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                    ),

                    ///Product name
                    Expanded(
                      flex: 3,
                      child: Text('product_name'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                    ),

                    ///Price
                    Expanded(
                      flex: 1,
                      child: Text('price'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                    ),

                    Expanded(
                        flex: 1,
                        child: Text(
                          'stock'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                          'Pieces',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              Divider(
                height: 0,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
      body: Material(
        child: Stack(
          children: [
            GetBuilder(
              builder: (AllProductsController allProdCtrlObj) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await allProdCtrlObj.callFirstOrderPage();
                  },
                  child: (allProdCtrlObj.productShowListModel == null)
                      ? progressIndicator()
                      : Scrollbar(
                          controller: _scrollController,
                          interactive: true,
                          child: ListView.builder(
                            controller: _scrollController,
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 100),
                            itemCount: allProdCtrlObj
                                .productShowListModel?.data?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(ViewProductsPage(
                                    isView: true,
                                    productModelObjs:
                                        allProdCtrlObj.productShowListModel!,
                                    index: index,
                                  ));
                                },
                                child: Container(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ///SKU
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              ' ${allProdCtrlObj.productShowListModel?.data?[index].sku}',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),

                                          ///Product name
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              allProdCtrlObj
                                                      .productShowListModel
                                                      ?.data?[index]
                                                      .product ??
                                                  '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(fontSize: 10),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                            ),
                                          ),

                                          ///Price
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              double.parse(
                                                    '${allProdCtrlObj.productShowListModel?.data?[index].maxPrice ?? ''}',
                                                  ).toStringAsFixed(2) +
                                                  ' /-',
                                              textAlign: TextAlign.right,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),

                                          Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  double.parse(
                                                          '${allProdCtrlObj.productShowListModel?.data?[index].currentStock ?? '0.00'}')
                                                      .toStringAsFixed(2),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                        fontSize: 10,
                                                      ),
                                                ),
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  '${allProdCtrlObj.productShowListModel?.data?[index].unit ?? ''}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                        fontSize: 10,
                                                      ),
                                                ),
                                              )),
                                        ],
                                      ),

                                      Divider(
                                        thickness: 2,
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GetX(builder: (AllProductsController allProductCtrll) {
                // contactCtrlObj.callFirstOrderPage(page: 2);
                return allProductCtrll.isLoadMoreRunning.isTrue
                    ? progressIndicator()
                    : SizedBox();
              }),
            ),
          ],
        ),
      ),
      // GetBuilder<AllProductsController>(
      //     builder: (AllProductsController allProdCtrlObj) {
      //   if (allProdCtrlObj.productShowListModel == null)
      //     return progressIndicator();
      //   return RefreshIndicator(
      //     onRefresh: () async {
      //       await allProdCtrlObj.getProductShowList();
      //     },
      //     child: ListView.builder(
      //       padding: EdgeInsetsDirectional.only(
      //           top: 5, bottom: 5, start: 10, end: 10),
      //       physics: ScrollPhysics(),
      //       shrinkWrap: true,
      //       itemCount: allProdCtrlObj.productShowListModel?.data?.length,
      //       itemBuilder: (context, index) {
      //         return GestureDetector(
      //           onTap: () {
      //             // Get.to(ViewProductsPage(
      //             //   isView: true,
      //             //   productModelObjs: allProdCtrlObj.searchProductModel,
      //             //   index: index,
      //             // ));
      //           },
      //           child: Container(
      //             color: Theme.of(context).colorScheme.background,
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 // const SizedBox(height: 10),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     ///SKU
      //                     Expanded(
      //                       flex: 1,
      //                       child: Text(
      //                         ' ${allProdCtrlObj.productShowListModel?.data?[index].sku}',
      //                         style: Theme.of(context)
      //                             .textTheme
      //                             .titleSmall!
      //                             .copyWith(
      //                                 fontSize: 12,
      //                                 fontWeight: FontWeight.bold),
      //                       ),
      //                     ),
      //
      //                     ///Product name
      //                     Expanded(
      //                       flex: 3,
      //                       child: Text(
      //                         allProdCtrlObj.productShowListModel?.data?[index]
      //                                 .product ??
      //                             '',
      //                         style: Theme.of(context)
      //                             .textTheme
      //                             .titleMedium!
      //                             .copyWith(fontSize: 12),
      //                         overflow: TextOverflow.ellipsis,
      //                         softWrap: true,
      //                       ),
      //                     ),
      //
      //                     ///Price
      //                     Expanded(
      //                       flex: 1,
      //                       child: Text(
      //                         double.parse(
      //                               '${allProdCtrlObj.productShowListModel?.data?[index].sku}',
      //                             ).toStringAsFixed(2) +
      //                             ' /-',
      //                         style: Theme.of(context)
      //                             .textTheme
      //                             .titleMedium!
      //                             .copyWith(
      //                                 fontSize: 12,
      //                                 fontWeight: FontWeight.bold),
      //                       ),
      //                     ),
      //
      //                     Expanded(
      //                         flex: 1,
      //                         child: Center(
      //                           child: Text(
      //                             double.parse('${'0.00'}').toStringAsFixed(1),
      //                           ),
      //                         )),
      //                   ],
      //                 ),
      //
      //                 Divider(
      //                   thickness: 2,
      //                   height: 10,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         );
      //       },
      //     ),
      //   );
      // }),
    );
  }
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../Config/utils.dart';
// import '../../Controllers/OrderController/order_type_controller.dart';
// import '../../Controllers/Tax Controller/TaxController.dart';
// import '../../Models/ProductsModel/ProductModel.dart';
// import '/Components/custom_circular_button.dart';
// import '/Controllers/ProductController/all_products_controller.dart';
// import '/Controllers/ProductController/product_cart_controller.dart';
// import '/Models/ProductsModel/all_products_model.dart';
// import '/Pages/cart/cart_page.dart';
// import '/Services/storage_services.dart';
// import '/Theme/colors.dart';
// import '/Theme/style.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage();
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int categoryCurrentIndex = 0;
//   bool viewAllIsTrue = false;
//   final PageController _pageController = PageController();
//   TextEditingController searchController = TextEditingController();
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   List<ProductModel> productModelObjs = [];
//   final ProductCartController prodCartCtrlObj =
//       Get.find<ProductCartController>();
//   List<ProductModel>? listProducts;
//   AllProductsController allProdCtrlObj = Get.find<AllProductsController>();
//   final TaxController taxCtrlObj = Get.find<TaxController>();
//
//   showingallItems(allProdCtrlObj) {
//     productModelObjs.clear();
//     for (int i = 0;
//         i < allProdCtrlObj.allCategoriesProductsData?.categories.length;
//         i++) {
//       for (int j = 0;
//           j <
//               allProdCtrlObj
//                   .allCategoriesProductsData?.categories[i].products.length;
//           j++) {
//         productModelObjs.add(allProdCtrlObj
//             .allCategoriesProductsData?.categories[i].products[j]);
//       }
//     }
//
//     searchController.clear();
//     //categoryCurrentIndex = 12;
//     return null;
//   }
//
//   @override
//   void initState() {
//     homePageInitialApiBindings();
//
//     super.initState();
//   }
//
//   void homePageInitialApiBindings() async {
//     // all products
//     if (!AppStorage.isStorageHasProductsData()) {
//       allProdCtrlObj.fetchAllProducts();
//     } else {
//       allProdCtrlObj.getAllProductsFromStorage();
//     }
//
//     // // order service types
//     Get.find<OrderTypeSelectionController>().fetchOrderTypes();
//
//     // // all sales
//     // Get.find<OrderController>().fetchAllSales();
//     taxCtrlObj.fetchListTax();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // var locale = AppLocalizations.of(context)!;
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;
//
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         title: Container(
//             // width: isPortrait ? 200 : 300,
//             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
//             child: TextFormField(
//               textAlignVertical: TextAlignVertical.center,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 hintText: 'searchItem'.tr,
//                 contentPadding: EdgeInsets.symmetric(vertical: 0),
//                 filled: true,
//                 fillColor: Theme.of(context).backgroundColor,
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide.none,
//                   borderRadius: BorderRadius.circular(40),
//                 ),
//               ),
//               onChanged: (value) {
//                 if (viewAllIsTrue == false) {
//                   viewAllIsTrue = true;
//                 } else {
//                   viewAllIsTrue = true;
//                 }
//                 showingallItems(allProdCtrlObj);
//                 listProducts = productModelObjs
//                     .where((element) =>
//                         element.sku!.contains(value) ||
//                         element.name.contains(value))
//                     .toList();
//                 print('Searching from the model obj results');
//                 print(listProducts?.length);
//
//                 ///adding the search results into Model obj
//                 setState(() {
//                   productModelObjs.clear();
//
//                   productModelObjs = listProducts!;
//                 });
//               },
//               // onTap: () {
//               //   setState(() {
//               //     showingallItems(allProdCtrlObj);
//               //   });
//               // },
//             )),
//         // title: FadedScaleAnimation(
//         //   GestureDetector(
//         //     onTap: () {
//         //       Get.find<AllProductsController>().fetchAllProducts();
//         //     },
//         //     child:
//         //         SizedBox(height: 30, child: Image.asset(AppImages.eMenuLogo)),
//         //   ),
//         //   durationInMilliseconds: 400,
//         // ),
//         actions: [buildItemsInCartButton()],
//       ),
//       body: GetX<AllProductsController>(
//         builder: (AllProductsController allProdCtrlObj) => (allProdCtrlObj
//                     .isFetchingProduct.isFalse &&
//                 AppStorage.isStorageHasProductsData())
//             ? Container(
//                 color: Theme.of(context).colorScheme.background,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 100,
//                       child: ListView.builder(
//                           itemCount: allProdCtrlObj.allCategoriesProductsData
//                                   ?.categories.length ??
//                               0,
//                           itemBuilder: (context, index) {
//                             CategoryDataModel? category = allProdCtrlObj
//                                 .allCategoriesProductsData?.categories[index];
//
//                             return InkWell(
//                               onLongPress: () {},
//                               onTap: () {
//                                 setState(() {
//                                   categoryCurrentIndex = index;
//                                   viewAllIsTrue = false;
//                                   FocusScope.of(context).unfocus();
//                                 });
//                               },
//                               child: Container(
//                                 height: 120,
//                                 margin: const EdgeInsets.all(5.0),
//                                 child: Card(
//                                   margin: const EdgeInsets.all(0),
//                                   clipBehavior: Clip.hardEdge,
//                                   color: categoryCurrentIndex == index
//                                       ? Theme.of(context).primaryColor
//                                       : Theme.of(context)
//                                           .scaffoldBackgroundColor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Expanded(
//                                         flex: 7,
//                                         child: CachedNetworkImage(
//                                           imageUrl: category
//                                                   ?.products.first.imageUrl ??
//                                               "",
//                                           fit: BoxFit.cover,
//                                           height: 70,
//                                           width: 90,
//                                           placeholder: (context, url) =>
//                                               progressIndicator(
//                                                   width: 10, height: 10),
//                                           errorWidget: (context, url, error) =>
//                                               Icon(Icons.error),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 4,
//                                         child: Center(
//                                           child: Text(
//                                             category?.name ?? "".toUpperCase(),
//                                             style: TextStyle(
//                                               color:
//                                                   categoryCurrentIndex == index
//                                                       ? Colors.white
//                                                       : Colors.black,
//                                               fontSize: 12,
//                                             ),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                     ),
//                     Expanded(
//                       child: PageView(
//                         controller: _pageController,
//                         scrollDirection: Axis.horizontal,
//                         onPageChanged: (index) {
//                           setState(() {
//                             categoryCurrentIndex = index;
//                           });
//                         },
//                         children: [
//                           (allProdCtrlObj.allCategoriesProductsData != null &&
//                                   allProdCtrlObj.allCategoriesProductsData!
//                                       .categories.isNotEmpty)
//                               ? GridView.builder(
//                                   physics: BouncingScrollPhysics(),
//                                   shrinkWrap: true,
//                                   padding: EdgeInsetsDirectional.only(
//                                       top: 5, bottom: 5, start: 10, end: 10),
//                                   itemCount: productModelObjs
//                                       .length, //widget.category.products.length,
//                                   gridDelegate:
//                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: isPortrait
//                                         ? 2
//                                         : MediaQuery.of(context).size.width >
//                                                 900
//                                             ? 6
//                                             : 4,
//                                     crossAxisSpacing: 10,
//                                     mainAxisSpacing: 10,
//                                     childAspectRatio: 0.7,
//                                   ),
//                                   itemBuilder: (context, index) {
//                                     // ProductModel item = allProdCtrlObj
//                                     //     .allCategoriesProductsData!
//                                     //     .categories[0]
//                                     //     .products[index];
//
//                                     return Card(
//                                       clipBehavior: Clip.hardEdge,
//                                       color: Theme.of(context)
//                                           .scaffoldBackgroundColor,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(8)),
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           // prodCartCtrlObj.item?.value = item;
//                                           if (productModelObjs[index]
//                                               .modifier
//                                               .isNotEmpty) {
//                                             // _scaffoldKey.currentState!.openEndDrawer();
//                                             // itemInfoPageNav(isPortrait,
//                                             //     productModelObjs[index]);
//                                           } else {
//                                             //prodCartCtrlObj.updateCart(item, isAdd: true);
//                                             prodCartCtrlObj.updateCart(
//                                                 productModelObjs[index],
//                                                 isAdd: true);
//                                           }
//                                           setState(() {});
//                                         },
//                                         child: Stack(
//                                           children: [
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Expanded(
//                                                   child: Stack(
//                                                     children: [
//                                                       // product image
//
//                                                       CachedNetworkImage(
//                                                         imageUrl:
//                                                             productModelObjs[
//                                                                         index]
//                                                                     .imageUrl ??
//                                                                 "",
//                                                         imageBuilder: (context,
//                                                                 imageProvider) =>
//                                                             Container(
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             image:
//                                                                 DecorationImage(
//                                                               image:
//                                                                   imageProvider,
//                                                               fit: BoxFit.cover,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         placeholder: (context,
//                                                                 url) =>
//                                                             progressIndicator(
//                                                                 width: 10,
//                                                                 height: 10),
//                                                         errorWidget: (context,
//                                                                 url, error) =>
//                                                             Icon(Icons.error),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 const SizedBox(height: 10),
//
//                                                 /// TODO: need to show the quantity
//
//                                                 if (productModelObjs.isNotEmpty)
//                                                   Padding(
//                                                     padding: const EdgeInsets
//                                                             .symmetric(
//                                                         horizontal: 10),
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Text(
//                                                           ' ${productModelObjs[index].sku}',
//                                                           style: Theme.of(
//                                                                   context)
//                                                               .textTheme
//                                                               .titleSmall!
//                                                               .copyWith(
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   color:
//                                                                       blackColor),
//                                                         ),
//                                                         Text(
//                                                           double.parse(
//                                                                 '${productModelObjs[index].productVariations.first.variations.first.sellPriceIncTax}',
//                                                               ).toStringAsFixed(
//                                                                   2) +
//                                                               ' /-',
//                                                           style: Theme.of(
//                                                                   context)
//                                                               .textTheme
//                                                               .titleMedium!
//                                                               .copyWith(
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 const SizedBox(height: 10),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 )
//                               : progressIndicator(),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : progressIndicator(),
//       ),
//     );
//   }
//
//   Widget buildItemsInCartButton() {
//     return GetBuilder<ProductCartController>(
//         builder: (ProductCartController prodCartCtrlObj) {
//       return AppStyles.p10(
//         CustomButton(
//           onTap: () {
//             // if (prodCartCtrlObj.itemCartList.isNotEmpty || ) {
//             // _scaffoldKey.currentState!.openEndDrawer();
//             Get.to(() => CartPage());
//             // }
//           },
//           // padding: EdgeInsets.symmetric(horizontal: 15),
//           // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//           title: Text(
//             'cart'.tr + " (${prodCartCtrlObj.itemCartList.length})",
//             style: TextStyle(
//                 color: prodCartCtrlObj.itemCartList.isNotEmpty
//                     ? kWhiteColor
//                     : blackColor,
//                 fontSize: 16),
//             textAlign: TextAlign.center,
//             maxLines: 1,
//           ),
//
//           bgColor: prodCartCtrlObj.itemCartList.isNotEmpty
//               ? buttonColor
//               : Colors.grey.shade300,
//         ),
//       );
//     });
//   }
// }
