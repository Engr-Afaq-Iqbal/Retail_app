import 'package:get/get.dart';

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
}
