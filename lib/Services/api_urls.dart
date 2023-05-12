class ApiUrls {
  //Endpoints
  // login / get access token
  static String oauthToken = "oauth/token";
  // fetch user profile data
  static String getLoggedInUserDetail = "connector/api/user/loggedin";
  static String businessDetails = "connector/api/business-details";

  // find customer
  static String contactApi = "connector/api/contactapi";
  // fetch tables information and list
  static String getTables = "connector/api/table";
  // table status update
  static String updateTableStatus = "connector/api/table/status/update";
  // Products
  static String allProducts = "connector/api/product";

  // fetch the order types
  static String getOrderTypes = "connector/api/types-of-service";
  // create order
  static String createOrder = "connector/api/orders";
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
}
