import '../Config/app_config.dart';

class ApiUrls {
  //Endpoints
  // login / get access token
  static String oauthToken = "oauth/token";
  // fetch user profile data
  static String getLoggedInUserDetail = "connector/api/user/loggedin";
  static String businessDetails = "connector/api/business-details";

  // find customer
  static String contactApi = "connector/api/contactapi";

  // update customer
  static String updateContactApi = "connector/api/contactapi/update/";

  //Get Specified Contact Api
  static String getSpecifiedContactApi = "connector/api/contactapi/";

  // fetch tables information and list
  static String getTables = "connector/api/table";
  // table status update
  static String updateTableStatus = "connector/api/table/status/update";
  // Products
  static String allProducts = "connector/api/product";

  ///Product list Api
  static String productListApi = "connector/api/product/list?";

  static String unitListApi = "connector/api/unit";

  //Funds Transfer API
  static String fundsTransferAPI = "connector/api/account/fund-transfer";

  // fetch the order types
  static String getOrderTypes = "connector/api/types-of-service";
  // create order
  static String createOrder = "connector/api/orders";

  // Add Sell Api
  static String addSellApi = "connector/api/sell/create";

  static String createOrderApi = "${AppConfig.baseUrl}connector/api/orders";
  static String updateOrder = "connector/api/sell/";
  static String sellUpdateOrder =
      "connector/api/sell/update/"; // Samar'sCreated

  // Register
  static String registersDetails = "connector/api/cash-register";
  static String openedRegisterRecords =
      "connector/api/cash-register/close-register";
  static String openRegister = "connector/api/cash-register";
  static String closeRegister = "connector/api/cash-register/close";
  // static String activeOrder = "connector/api/orders/suspended/list";
  static String allOrders = "connector/api/sell";
  static String markOrdersEndpoint = "connector/api/order/marked/cooked";

  ///create New Booking API
  static String createNewBookingAPI = "connector/api/booking";

  ///Getting Booking List API
  static String bookingListAPI = "connector/api/booking/list";

  ///Service Staff API
  static String newserviceStaffAPI = "connector/api/staff-service";

  ///Change Password API
  static String changePasswordAPI = "connector/api/update-password";

  ///ListUser API
  static String listUsersAPI = "connector/api/user";

  ///list Tax Api
  static String listTaxAPI = "connector/api/tax";

  ///Notifications Api
  static String listNotificationsAPI = "connector/api/notifications";

  ///User Firebase Token Api
  static String userFirebaseTokenApi = "connector/api/user-firebase-token";

  ///Notification marked as complete Api
  static String notificationMarkedApi = "connector/api/notification/marked";

  ///View Stock Transfer Api
  static String viewStockTransfer = "connector/api/stock-transfer";

  ///Status Stock Transfer Api
  static String statusStockTransfer = "connector/api/stock-transfer/status";

  ///View Stock Adjustment Api
  static String viewStockAdjustment = "connector/api/stock-adjustment";

  ///Customer Visits List
  static String viewCustomerVisits = "connector/api/visit";

  ///Create Customer Visits
  static String createCustomerVisits = "connector/api/visit/store";

  ///Update Customer Visit Status
  static String updateCustomerVisitsStatusApi =
      "connector/api/visit/status/update";

  ///Delete Customer Visits
  static String deleteCustomerVisits = "connector/api/visit/destroy/";

  ///Dashboard Data Api
  static String dashboardDataApi = "connector/api/home/get-totals";

  ///Update Customer Visit
  static String updateCustomerVisitApi = "connector/api/visit/update";

  ///Checkout Api
  static String checkOutApi = "connector/api/checkout";

  ///CheckIn Api
  static String checkInApi = "connector/api/checkin";

  ///Sale return List api
  static String saleReturnListApi = "connector/api/list-sell-return";

  ///Add Sale Return
  static String addSaleReturnApi = "connector/api/sell-return";

  ///Create Sale Return New Api
  static String createSaleReturnApi = "connector/api/sell-return/create";

  ///Multiple Payment Api
  static String multiPaymentApi = "connector/api/multiple/payment";

  ///Show Product List Api
  static String showProductListApi = "connector/api/product/show";

  ///Show Product List Api
  static String showProductsApi = "connector/api/product/list";

  ///All Kitchen Api
  static String allKitchenApi = "connector/api/all/kitchen";

  ///Create New Product
  static String createNewProductApi = "connector/api/product/create";

  ///Create Stock Transfer
  static String createStockTransferApi = "connector/api/stock-transfer/store";

  ///Update Stock Transfer
  static String updateStockTransferApi = "connector/api/stock-transfer/update/";

  ///Create Stock Adjustment
  static String createStockAdjustmentApi =
      "connector/api/stock-adjustment/create";

  ///Searh product list Api
  static String searchProductListApi = "connector/api/product/search";

  ///Product list Api
  static String uploadApi = "connector/api/user/google/file";

  ///List Quotation Api
  static String listQuotationApi = "connector/api/sells/quotations";

  ///Show Details Quotation Api
  static String showDetailsQuotationApi = "connector/api/sells/quotations/show";

  ///Create Quotations Api
  static String createQuotationApi = "connector/api/sells/quotations/store";

  ///Create Quotations Api
  static String editSaleReturnApi = "connector/api/sell-return/edit/";

  ///Store Settings Api
  static String storeSettingsAPI = "connector/api/app/setting/store";

  /// order payment
  static String orderPaymentAPI = "connector/api/order/payment/";

  /// Payment Account Api
  static String paymentAccountApi = "connector/api/payment-accounts";

  ///Register Apis
  static String openRegisterAPI = "connector/api/cash-register";

  static String closeRegisterAPI = "connector/api/cash-register/close";

  static String registersDetailsAPI = "connector/api/cash-register";

  static String openedRegisterRecordsAPI =
      "connector/api/cash-register/close-register";

  static String updateStockTransferStatusApi =
      "connector/api/stock-transfers/update-status/";
}
