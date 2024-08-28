import 'package:dono/pages/add_product_screen.dart';
import 'package:dono/pages/confirmation.dart';
import 'package:dono/pages/shop_home.dart';
import 'package:dono/pages/item_list_page.dart';

import 'package:dono/pages/shop_login.dart';

import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case ShopLogin.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const ShopLogin());
    case RegistrationConfirmationPage.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const RegistrationConfirmationPage());
    case ShopHome.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => ShopHome());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Error 404"),
                ),
              ));
  }
}
