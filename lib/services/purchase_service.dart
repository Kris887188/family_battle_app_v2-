import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseService extends ChangeNotifier {
  late InAppPurchase _iap;
  List<ProductDetails> products = [];
  String? status;

  Future<void> init(InAppPurchase iap) async {
    _iap = iap;
    final available = await _iap.isAvailable();
    if (!available) return;

    const ids = {'standard_plan', 'pro_plan'};
    final response = await _iap.queryProductDetails(ids);
    products = response.productDetails;

    _iap.purchaseStream.listen((updates) {
      for (var u in updates) {
        if (u.status == PurchaseStatus.purchased) {
          status = u.productID;
          notifyListeners();
        }
      }
    });
    notifyListeners();
  }

  void buy(ProductDetails product) {
    final param = PurchaseParam(productDetails: product);
    _iap.buyNonConsumable(purchaseParam: param);
  }
}