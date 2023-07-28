import 'package:get/get.dart';

import '../../Pages/Orders/Controller/OrderController.dart';
import '../../Pages/Tabs/Controllers/BottomNavBarController.dart';
import '../AllKitchenController/allKitchenController.dart';
import '../AllSalesController/allSalesController.dart';
import '../AllSalesController/quotationController.dart';
import '../AuthController/auth_controller.dart';
import '../ContactController/ContactController.dart';
import '../CustomerVisits/CustomerVisitsController.dart';
import '../DashboardController/dashboardController.dart';
import '../OrderController/order_type_controller.dart';
import '../ProductsRetailController/productsRetailsController.dart';
import '../ReceiptsController/receiptsController.dart';
import '../SalesReturnController/saleReturnController.dart';
import '../StockTransferController/stockTransferController.dart';
import '../ThemeController/themeController.dart';
import '../Upload Controller/uploadController.dart';
import '/Controllers/AllPrinterController/AllPrinterController.dart';
import '/Controllers/Booking%20Controller/BookingController.dart';
import '/Controllers/FundsController/fundsController.dart';
import '/Controllers/ListUserController/ListUserController.dart';
import '/Controllers/Notifications/NotificationsController.dart';
import '/Controllers/ProductController/PaymentController.dart';
import '/Controllers/ProductController/all_products_controller.dart';
import '/Controllers/ProductController/product_cart_controller.dart';
import '/Controllers/ServiceStaffController/ServiceStaffController.dart';
import '/Controllers/Tax%20Controller/TaxController.dart';
import '/Controllers/exception_controller.dart';
import '/Controllers/register/RegisterController.dart';

class AppController {
  Future syncApplication() async {
    await Get.find<AuthController>().getLoginUserDetail();
    await Get.find<AuthController>().getBusinessSetting();
    await Get.find<RegisterController>().fetchRegisterStatus();
    // Get.find<AllPrinterController>().fetchAllPrinters();
    Get.find<TaxController>().fetchListTax();
    Get.find<OrderController>().fetchSaleOrders(1);
    Get.find<ContactController>().fetchCustomerInfo('');
    await Get.find<OrderTypeSelectionController>().fetchOrderTypes();
    await Get.find<AllProductsController>().fetchAllProducts();
  }

  Future syncProducts() async {
    await Get.find<AllProductsController>().fetchAllProducts();
  }

  static void initializeControllers() {
    Get.put(ExceptionController());
    Get.put(ThemeController());
    Get.put(AuthController());
    Get.put(DashboardController());
    Get.put(NotificationsController());
    Get.put(AllPrinterController());
    Get.put(OrderTypeSelectionController());
    Get.put(ContactController());
    Get.put(OrderController());
    Get.put(TaxController());
    Get.put(RegisterController());
    Get.put(PaymentController());
    Get.put(ProductCartController());
    Get.put(AllProductsController());
    Get.put(BottomNavBarController());
    Get.put(BookingController());
    Get.put(ServiceStaffController());
    Get.put(ListUserController());
    Get.put(StockTransferController());
    Get.put(CustomerVisitsController());
    Get.put(AllSalesController());
    Get.put(ProductsRetailController());
    Get.put(SaleReturnController());
    Get.put(AllKitchenController());
    Get.put(ReceiptsController());
    Get.put(QuotationController());
    Get.put(UploadController());
    Get.put(FundsController());

    // Get.put(PrintController());
  }

// static void disposeControllers() {
// }
}
