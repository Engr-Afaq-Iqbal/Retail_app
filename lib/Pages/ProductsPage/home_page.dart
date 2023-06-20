import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/Components/custom_circular_button.dart';
import '/Controllers/ProductController/all_products_controller.dart';
import '/Controllers/ProductController/product_cart_controller.dart';
import '/Pages/cart/cart_page.dart';
import '/Theme/colors.dart';
import '/Theme/style.dart';
import '../../Config/utils.dart';
import '../item_info.dart';
import 'AddProductsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AllProductsController allProdCtrlObj = Get.find<AllProductsController>();

  @override
  void initState() {
    allProdCtrlObj.searchProductList(term: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.5),
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
                allProdCtrlObj.searchProductList(term: '${value}');
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
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
      body: GetBuilder<AllProductsController>(
          builder: (AllProductsController allProdCtrlObj) {
        if (allProdCtrlObj.searchProductModel == null)
          return progressIndicator();
        return RefreshIndicator(
          onRefresh: () async {
            await allProdCtrlObj.searchProductList(term: '');
          },
          child: ListView.builder(
            padding: EdgeInsetsDirectional.only(
                top: 5, bottom: 5, start: 10, end: 10),
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: allProdCtrlObj.searchProductModel?.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(AddProductsPage(
                    isView: true,
                    // productModelObjs: allProdCtrlObj.searchProductModel,
                    // index: index,
                  ));
                },
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///SKU
                          Expanded(
                            flex: 1,
                            child: Text(
                              ' ${allProdCtrlObj.searchProductModel?[index].subSku}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),

                          ///Product name
                          Expanded(
                            flex: 3,
                            child: Text(
                              allProdCtrlObj.searchProductModel?[index].name ??
                                  '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),

                          ///Price
                          Expanded(
                            flex: 1,
                            child: Text(
                              double.parse(
                                    '${allProdCtrlObj.searchProductModel?[index].sellingPrice}',
                                  ).toStringAsFixed(2) +
                                  ' /-',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),

                          Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  double.parse(
                                          '${allProdCtrlObj.searchProductModel?[index].qtyAvailable ?? '0.00'}')
                                      .toStringAsFixed(1),
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
        );
      }),
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
