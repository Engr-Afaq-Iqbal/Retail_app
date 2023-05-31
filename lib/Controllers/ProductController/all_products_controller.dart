import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Config/utils.dart';
import '../../Models/ProductsModel/SearchProductModel.dart';
import '/Models/ProductsModel/all_products_model.dart';
import '/Services/api_services.dart';
import '/Services/api_urls.dart';
import '/Services/storage_services.dart';

class AllProductsController extends GetxController {
  RxBool isFetchingProduct = false.obs;
  CategoriesProductsModel? allCategoriesProductsData;

  Future<void> fetchAllProducts() async {
    isFetchingProduct.value = true;
    String? response =
        await ApiServices.getMethod(feedUrl: ApiUrls.allProducts);
    if (response == null) return;
    await AppStorage.setProductsData(response);
    getAllProductsFromStorage(res: response);
  }

  void getAllProductsFromStorage({res}) async {
    allCategoriesProductsData = AppStorage.getProductsData(res: res);
    isFetchingProduct.value = false;
  }

  List<SearchProductModel>? searchProductModel;

  /// Searching Product
  Future searchProductList({String? pageUrl, String? term}) async {
    await ApiServices.getMethod(
            feedUrl: pageUrl ??
                '${ApiUrls.searchProductListApi}?location_id${AppStorage.getBusinessDetailsData()?.businessData?.locations.first.id}=&term=${term}')
        .then((_res) {
      update();
      if (_res == null) return null;
      searchProductModel = searchProductModelFromJson(_res);
      update();
    }).onError((error, stackTrace) {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      update();
    });
  }
}
