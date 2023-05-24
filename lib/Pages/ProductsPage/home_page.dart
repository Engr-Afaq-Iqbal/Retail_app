import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Components/custom_circular_button.dart';
import '/Controllers/ProductController/all_products_controller.dart';
import '/Controllers/ProductController/product_cart_controller.dart';
import '/Pages/cart/cart_page.dart';
import '/Services/storage_services.dart';
import '/Theme/colors.dart';
import '/Theme/style.dart';
import '../../Config/utils.dart';
import '../../Controllers/OrderController/order_type_controller.dart';
import '../../Models/ProductsModel/ProductModel.dart';
import '../item_info.dart';
import 'AddProductsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int categoryCurrentIndex = 0;
  bool viewAllIsTrue = true;
  bool isSelected = false;
  final PageController _pageController = PageController();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<ProductModel> productModelObjs = [];
  final ProductCartController prodCartCtrlObj =
      Get.find<ProductCartController>();
  List<ProductModel>? listProducts;
  AllProductsController allProdCtrlObj = Get.find<AllProductsController>();

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

    showingallItems(allProdCtrlObj);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          backgroundColor: primaryColor.withOpacity(0.5),
          onPressed: () {
            Get.to(AddProductsPage());
          }),
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
                      child: Text('SKU', style: appBarHeaderStyle),
                    ),

                    ///Product name
                    Expanded(
                      flex: 3,
                      child: Text('Product Name', style: appBarHeaderStyle),
                    ),

                    ///Price
                    Expanded(
                      flex: 1,
                      child: Text('Price', style: appBarHeaderStyle),
                    ),

                    Expanded(
                        flex: 1,
                        child: Text(
                          'Stock',
                          style: appBarHeaderStyle,
                        )),
                  ],
                ),
              ),
              Divider(
                height: 0,
                color: primaryColor,
              ),
            ],
          ),
        ),
      ),
      body: GetX<AllProductsController>(
        builder: (AllProductsController allProdCtrlObj) => (allProdCtrlObj
                    .isFetchingProduct.isFalse &&
                AppStorage.isStorageHasProductsData())
            ? Container(
                color: Theme.of(context).colorScheme.background,
                child: Row(
                  children: [
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
                          (allProdCtrlObj.allCategoriesProductsData != null)
                              ? ListView.builder(
                                  padding: EdgeInsetsDirectional.only(
                                      top: 5, bottom: 5, start: 10, end: 10),
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: productModelObjs.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(AddProductsPage(
                                          isView: true,
                                          productModelObjs: productModelObjs,
                                          index: index,
                                        ));
                                        // prodCartCtrlObj.item?.value = item;
                                        // if (productModelObjs[index]
                                        //     .modifier
                                        //     .isNotEmpty) {
                                        //   // _scaffoldKey.currentState!.openEndDrawer();
                                        //   itemInfoPageNav(isPortrait,
                                        //       productModelObjs[index]);
                                        // } else {
                                        //   //prodCartCtrlObj.updateCart(item, isAdd: true);
                                        //   prodCartCtrlObj.updateCart(
                                        //       productModelObjs[index],
                                        //       isAdd: true);
                                        // }
                                      },
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ///SKU
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    ' ${productModelObjs[index].sku}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),

                                                ///Product name
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    productModelObjs[index]
                                                        .name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(fontSize: 12),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: true,
                                                  ),
                                                ),

                                                ///Price
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    double.parse(
                                                          '${productModelObjs[index].productVariations.first.variations.first.sellPriceIncTax}',
                                                        ).toStringAsFixed(2) +
                                                        ' /-',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),

                                                Expanded(
                                                    flex: 1,
                                                    child: Center(
                                                      child: Text(
                                                        '${productModelObjs[index].quantity}',
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
                                )
                              : progressIndicator()
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
