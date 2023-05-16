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
import '../../Controllers/Tax Controller/TaxController.dart';
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
    taxCtrlObj.fetchListTax();
    showingallItems(allProdCtrlObj);
  }

  @override
  Widget build(BuildContext context) {
    // var locale = AppLocalizations.of(context)!;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          backgroundColor: primaryColor.withOpacity(0.5),
          onPressed: () {
            Get.to(AddProductsPage());
            // showModalBottomSheet(
            //   isScrollControlled: true,
            //   context: context,
            //   builder: (context) {
            //     return Container(
            //       child: AddProductsPage(),
            //     );
            //   },
            // );
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
        actions: [buildItemsInCartButton()],
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
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: productModelObjs.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
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
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                                Text(
                                                  ' ${productModelObjs[index].sku}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),

                                                ///Product name
                                                Text(
                                                  productModelObjs[index].name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(fontSize: 12),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                ),

                                                ///Price
                                                Text(
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
                                                              FontWeight.bold),
                                                ),

                                                Text('Stock'),
                                              ],
                                            ),

                                            Divider(
                                              thickness: 2,
                                              height: 3,
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
