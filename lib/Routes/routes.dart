import 'package:flutter/material.dart';

import '../Pages/ProductsPage/home_page.dart';
import '/Pages/login.dart';
import '../Pages/Table/TablesPage.dart';

class PageRoutes {
  static const String homePage = 'home_page';
  static const String loginPage = 'login_page';
  static const String tableSelectionPage = 'tableSelectionPage';
  static const String orderInfoPage = 'ordersinfo_page';
  static const String chatPage = 'chat_page';
  static const String track = 'track_order';

  Map<String, WidgetBuilder> routes() {
    return {
      homePage: (context) => HomePage(),
      tableSelectionPage: (context) => TablesPage(),
      loginPage: (context) => LoginPage(),
    };
  }
}
