import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class IAPProviderModel extends ChangeNotifier {
  InAppPurchase inAppPurchase = InAppPurchase.instance;
  bool available = true;
  late StreamSubscription subscription;
  final String myProductId = 'upgrade_to_no_ads';

  bool _isPurchased = false;

  bool get isPurchased => _isPurchased;

  set isPurchased(bool value) {
    _isPurchased = value;
    notifyListeners();
  }

  List _purchases = [];

  List get purchases => _purchases;

  set purchases(List value) {
    _purchases = value;
    notifyListeners();
  }

  List _products = [];

  List get products => _products;

  set products(List value) {
    _products = value;
    notifyListeners();
  }

  void initialize() async {
    available = await inAppPurchase.isAvailable();
    if (available) {
      await _getProducts();
      // await _getPastPurchases();
      verifyPurchase();
      subscription = inAppPurchase.purchaseStream.listen((data) {
        purchases.addAll(data);
        verifyPurchase();
      });
    }
  }

  void verifyPurchase() {
    PurchaseDetails purchase = hasPurchased(myProductId);
    if (purchase!=PurchaseDetails(
        productID: '',
        verificationData: PurchaseVerificationData(
            serverVerificationData: '',
            localVerificationData: '',
            source: ''),
        transactionDate: '',status: PurchaseStatus.error
    )&&purchase.status == PurchaseStatus.purchased) {
      if (purchase.pendingCompletePurchase) {
        inAppPurchase.completePurchase(purchase);
        isPurchased = true;
      }
    }
  }

  PurchaseDetails hasPurchased(String productID) {
    return purchases.firstWhere((purchase) => purchase.productID == productID,
        orElse: () => PurchaseDetails(
          productID: '',
          verificationData: PurchaseVerificationData(
              serverVerificationData: '',
              localVerificationData: '',
              source: ''),
          transactionDate: '',status: PurchaseStatus.error
        ));
  }

  Future<void> _getProducts() async {
    Set<String> ids = Set.from([myProductId]);
    ProductDetailsResponse response =
        await inAppPurchase.queryProductDetails(ids);
    products = response.productDetails;
  }

  Future<void> _getPastPurchases() async {

  }
}
