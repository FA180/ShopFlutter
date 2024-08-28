import 'package:dono/models/shop_owners.dart';

import 'package:flutter/material.dart';

class ShopOwnerProvider extends ChangeNotifier {
  ShopOwner? _shopOwner;

  ShopOwner? get shopOwner => _shopOwner;

  void setShopOwner(ShopOwner shopOwner) {
    _shopOwner = shopOwner;
    notifyListeners();
  }

  void clearShopOwner() {
    _shopOwner = null;
    notifyListeners();
  }
}
