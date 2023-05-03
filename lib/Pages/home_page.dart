import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Components/custom_circular_button.dart';
import '/Controllers/ProductController/all_products_controller.dart';
import '/Controllers/ProductController/product_cart_controller.dart';
import '/Models/ProductsModel/all_products_model.dart';
import '/Pages/cart/cart_page.dart';
import '/Services/storage_services.dart';
import '/Theme/colors.dart';
import '/Theme/style.dart';
import '../Config/utils.dart';
import '../Controllers/OrderController/order_type_controller.dart';
import '../Controllers/Tax Controller/TaxController.dart';
import '../Models/ProductsModel/ProductModel.dart';
import 'item_info.dart';
import 'items_page.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int categoryCurrentIndex = 0;
  bool viewAllIsTrue = false;
  final PageController _pageController = PageController();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<ProductModel> productModelObjs = [];
  final ProductCartController prodCartCtrlObj =
      Get.find<ProductCartController>();
  List<ProductModel>? listProducts;
  AllProductsController allProdCtrlObj = Get.find<AllProductsController>();
  final TaxController taxCtrlObj = Get.find<TaxController>();

  showingallItems(allProdCtrlObj) {
    productModelObjs.clear();
    for (int i = 0;
        i < allProdCtrlObj.allCategoriesProductsData?.categories.length;
        i++) {
      for (int j = 0;
          j <
              allProdCtrlObj
                  .allCategoriesProductsData?.categories[i].products.length;
          j++) {
        productModelObjs.add(allProdCtrlObj
            .allCategoriesProductsData?.categories[i].products[j]);
      }
    }

    searchController.clear();
    //categoryCurrentIndex = 12;
    return null;
  }

  @override
  void initState() {
    homePageInitialApiBindings();

    super.initState();
  }

  void homePageInitialApiBindings() async {
    // all products
    if (!AppStorage.isStorageHasProductsData()) {
      allProdCtrlObj.fetchAllProducts();
    } else {
      allProdCtrlObj.getAllProductsFromStorage();
    }

    // // order service types
    Get.find<OrderTypeSelectionController>().fetchOrderTypes();

    // // all sales
    // Get.find<OrderController>().fetchAllSales();
    taxCtrlObj.fetchListTax();
  }

  @override
  Widget build(BuildContext context) {
    // var locale = AppLocalizations.of(context)!;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      key: _scaffoldKey,
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
                fillColor: Theme.of(context).backgroundColor,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              onChanged: (value) {
                if (viewAllIsTrue == false) {
                  viewAllIsTrue = true;
                } else {
                  viewAllIsTrue = true;
                }
                showingallItems(allProdCtrlObj);
                listProducts = productModelObjs
                    .where((element) =>
                        element.sku!.contains(value) ||
                        element.name.contains(value))
                    .toList();
                print('Searching from the model obj results');
                print(listProducts?.length);

                ///adding the search results into Model obj
                setState(() {
                  productModelObjs.clear();

                  productModelObjs = listProducts!;
                });
              },
              // onTap: () {
              //   setState(() {
              //     showingallItems(allProdCtrlObj);
              //   });
              // },
            )),
        // title: FadedScaleAnimation(
        //   GestureDetector(
        //     onTap: () {
        //       Get.find<AllProductsController>().fetchAllProducts();
        //     },
        //     child:
        //         SizedBox(height: 30, child: Image.asset(AppImages.eMenuLogo)),
        //   ),
        //   durationInMilliseconds: 400,
        // ),
        actions: [buildItemsInCartButton()],
      ),
      body: GetX<AllProductsController>(
        builder: (AllProductsController allProdCtrlObj) => (allProdCtrlObj
                    .isFetchingProduct.isFalse &&
                AppStorage.isStorageHasProductsData())
            ? Container(
                color: Theme.of(context).backgroundColor,
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: ListView.builder(
                          itemCount: allProdCtrlObj.allCategoriesProductsData
                                  ?.categories.length ??
                              0,
                          itemBuilder: (context, index) {
                            CategoryDataModel? category = allProdCtrlObj
                                .allCategoriesProductsData?.categories[index];

                            return InkWell(
                              onLongPress: () {},
                              onTap: () {
                                setState(() {
                                  categoryCurrentIndex = index;
                                  viewAllIsTrue = false;
                                  FocusScope.of(context).unfocus();
                                });
                              },
                              child: Container(
                                height: 120,
                                margin: const EdgeInsets.all(5.0),
                                child: Card(
                                  margin: const EdgeInsets.all(0),
                                  clipBehavior: Clip.hardEdge,
                                  color: categoryCurrentIndex == index
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context)
                                          .scaffoldBackgroundColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: CachedNetworkImage(
                                          imageUrl: category
                                                  ?.products.first.imageUrl ??
                                              "",
                                          fit: BoxFit.cover,
                                          height: 70,
                                          width: 90,
                                          placeholder: (context, url) =>
                                              progressIndicator(
                                                  width: 10, height: 10),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Center(
                                          child: Text(
                                            category?.name ?? "".toUpperCase(),
                                            style: TextStyle(
                                              color:
                                                  categoryCurrentIndex == index
                                                      ? Colors.white
                                                      : Colors.black,
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index) {
                          setState(() {
                            categoryCurrentIndex = index;
                          });
                        },
                        children: [
                          // if (allProdCtrlObj.allCategoriesProductsData !=
                          //         null &&
                          //     allProdCtrlObj.allCategoriesProductsData!
                          //         .categories.isNotEmpty)
                          //   ItemsPage(
                          //     category: allProdCtrlObj
                          //         .allCategoriesProductsData!
                          //         .categories[categoryCurrentIndex],
                          //   )
                          // else
                          //   Text('items_are_not_available'.tr),

                          (allProdCtrlObj.allCategoriesProductsData != null &&
                                  allProdCtrlObj.allCategoriesProductsData!
                                      .categories.isNotEmpty)
                              ? !viewAllIsTrue
                                  ? ItemsPage(
                                      category: allProdCtrlObj
                                          .allCategoriesProductsData!
                                          .categories[categoryCurrentIndex],
                                    )
                                  : GridView.builder(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsetsDirectional.only(
                                          top: 5,
                                          bottom: 5,
                                          start: 10,
                                          end: 10),
                                      itemCount: productModelObjs
                                          .length, //widget.category.products.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: isPortrait
                                            ? 2
                                            : MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    900
                                                ? 6
                                                : 4,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 0.7,
                                      ),
                                      itemBuilder: (context, index) {
                                        // ProductModel item = allProdCtrlObj
                                        //     .allCategoriesProductsData!
                                        //     .categories[0]
                                        //     .products[index];

                                        return Card(
                                          clipBehavior: Clip.hardEdge,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: GestureDetector(
                                            onTap: () {
                                              // prodCartCtrlObj.item?.value = item;
                                              if (productModelObjs[index]
                                                  .modifier
                                                  .isNotEmpty) {
                                                // _scaffoldKey.currentState!.openEndDrawer();
                                                itemInfoPageNav(isPortrait,
                                                    productModelObjs[index]);
                                              } else {
                                                //prodCartCtrlObj.updateCart(item, isAdd: true);
                                                prodCartCtrlObj.updateCart(
                                                    productModelObjs[index],
                                                    isAdd: true);
                                              }
                                              setState(() {});
                                            },
                                            child: Stack(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Stack(
                                                        children: [
                                                          // product image

                                                          CachedNetworkImage(
                                                            imageUrl: productModelObjs[
                                                                        index]
                                                                    .imageUrl ??
                                                                "",
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            placeholder: (context,
                                                                    url) =>
                                                                progressIndicator(
                                                                    width: 10,
                                                                    height: 10),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                          ),

                                                          // product shade effect if item in cart
                                                          GetBuilder(
                                                            builder:
                                                                (ProductCartController
                                                                    prodCartCtrlObj) {
                                                              return prodCartCtrlObj
                                                                      .isItemInCart(
                                                                          productModelObjs[index]
                                                                              .id)
                                                                  ? Opacity(
                                                                      opacity:
                                                                          0.8,
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.vertical(top: Radius.circular(10)),
                                                                          gradient: LinearGradient(
                                                                              begin: Alignment.bottomCenter,
                                                                              end: Alignment.center,
                                                                              colors: [
                                                                                Theme.of(context).primaryColor,
                                                                                Colors.transparent,
                                                                              ],
                                                                              stops: [
                                                                                0.2,
                                                                                0.75,
                                                                              ]),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : SizedBox
                                                                      .shrink();
                                                            },
                                                          ),
                                                          // counts of and item if in cart
                                                          GetBuilder(builder:
                                                              (ProductCartController
                                                                  prodCartCtrlObj) {
                                                            return prodCartCtrlObj
                                                                    .isItemInCart(
                                                                        productModelObjs[index]
                                                                            .id)
                                                                ? Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomCenter,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              0.0),
                                                                      child:
                                                                          Container(
                                                                        padding: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                6,
                                                                            horizontal:
                                                                                6),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                if (prodCartCtrlObj.countItemInCart(productModelObjs[index].id).compareTo('1') == 0) {
                                                                                  print('in if function');
                                                                                  setState(() {
                                                                                    // prodCartCtrlObj
                                                                                    //     .deleteFromProdPage(
                                                                                    //         item);
                                                                                  });
                                                                                  // prodCartCtrlObj.itemCartList
                                                                                  //     .clear();
                                                                                } else {
                                                                                  prodCartCtrlObj.updateCart(productModelObjs[index], isAdd: false);
                                                                                }
                                                                              },
                                                                              child: Icon(Icons.remove, color: Colors.white, size: 16),
                                                                            ),

                                                                            SizedBox(width: 8),
                                                                            CircleAvatar(
                                                                              radius: 10,
                                                                              backgroundColor: primaryColor,
                                                                              child: Text(
                                                                                prodCartCtrlObj.countItemInCart(productModelObjs[index].id),
                                                                                style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 10, color: kWhiteColor),
                                                                              ),
                                                                            ),
                                                                            SizedBox(width: 8),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  prodCartCtrlObj.updateCart(productModelObjs[index], isAdd: true);
                                                                                  //   foodItems[index].count++;
                                                                                });
                                                                              },
                                                                              child: Icon(Icons.add, color: Colors.white, size: 16),
                                                                            ),
                                                                            // GestureDetector(
                                                                            //   onTap: () {
                                                                            //     setState(() {
                                                                            //       foodItems[index].count++;
                                                                            //     });
                                                                            //   },
                                                                            //   child: Icon(Icons.add, color: Colors.white, size: 16),
                                                                            // ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : SizedBox
                                                                    .shrink();
                                                          }),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),

                                                    /// TODO: need to show the quantity

                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        productModelObjs[index]
                                                                .name ??
                                                            "",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1!
                                                            .copyWith(
                                                                fontSize: 12),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: true,
                                                      ),
                                                    ),
                                                    if (productModelObjs
                                                        .isNotEmpty)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              ' ${productModelObjs[index].sku}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                            ),
                                                            Text(
                                                              double.parse(
                                                                    '${productModelObjs[index].productVariations.first.variations.first.sellPriceIncTax}',
                                                                  ).toStringAsFixed(
                                                                      2) +
                                                                  ' /-',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle1!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    const SizedBox(height: 10),
                                                  ],
                                                ),

                                                // product details page button
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // prodCartCtrlObj.item?.value = item;
                                                      // item = widget.category.products[index];
                                                      // setState(() {});

                                                      // _scaffoldKey.currentState!.openEndDrawer();
                                                      itemInfoPageNav(
                                                          isPortrait,
                                                          productModelObjs[
                                                              index]);
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      height: 20,
                                                      width: 30,
                                                      child: Icon(
                                                        Icons.info,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                              : progressIndicator(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : progressIndicator(),
      ),
    );
  }

  Widget buildItemsInCartButton() {
    return GetBuilder<ProductCartController>(
        builder: (ProductCartController prodCartCtrlObj) {
      return AppStyles.p10(
        CustomButton(
          onTap: () {
            // if (prodCartCtrlObj.itemCartList.isNotEmpty || ) {
            // _scaffoldKey.currentState!.openEndDrawer();
            Get.to(() => CartPage());
            // }
          },
          // padding: EdgeInsets.symmetric(horizontal: 15),
          // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          title: Text(
            'cart'.tr + " (${prodCartCtrlObj.itemCartList.length})",
            style: TextStyle(
                color: prodCartCtrlObj.itemCartList.isNotEmpty
                    ? kWhiteColor
                    : blackColor,
                fontSize: 16),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),

          bgColor: prodCartCtrlObj.itemCartList.isNotEmpty
              ? buttonColor
              : Colors.grey.shade300,
        ),
      );
    });
  }

  itemInfoPageNav2(item) {
    Get.to(() => ItemInfoPage(item));
  }

  itemInfoPageNav(isPortrait, item) {
    if (isPortrait)
      Get.to(() => Material(child: ItemInfoPage(item)));
    else
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: ItemInfoPage(item),
        ),
      );
  }
}
