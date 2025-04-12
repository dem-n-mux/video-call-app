// ignore_for_file: camel_case_types, file_names, avoid_print, depend_on_referenced_packages, use_build_context_synchronously, unused_field

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hokoo_flutter/view/utils/settings/app_colors.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import '../view/utils/settings/app_images.dart';
import 'consumable_store.dart';

class CustomInAppPurchase extends StatefulWidget {
  const CustomInAppPurchase({Key? key}) : super(key: key);

  @override
  State<CustomInAppPurchase> createState() => _CustomInAppPurchaseState();
}

class _CustomInAppPurchaseState extends State<CustomInAppPurchase> {
  final bool _kAutoConsume = Platform.isIOS || true;
  static const String _kConsumableId = 'p100';
  static const List<String> _kProductIds = <String>[
    _kConsumableId,
    // _kUpgradeId,
    // _kSilverSubscriptionId,
    //_kGoldSubscriptionId,
  ];
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  List<String> _notFoundIds = <String>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<String> _consumables = <String>[];
  bool _loading = true;
  bool _isAvailable = false;
  bool _purchasePending = false;
  String? _queryProductError;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription.cancel();
      },
      onError: (Object error) {
        // handle error here.
      },
    );
    initStoreInfo();
    super.initState();
  }

// /==============  Here is an example of how to handle purchase updates: =======/////
  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
                _inAppPurchase.getPlatformAddition<
                    InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.productID == _kConsumableId) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      final List<String> consumables = await ConsumableStore.load();
      setState(
        () {
          _purchasePending = false;
          _consumables = consumables;
        },
      );
    } else {
      setState(
        () {
          _purchases.add(purchaseDetails);
          _purchasePending = false;
        },
      );
    }
    _purchases.add(purchaseDetails);
    _purchasePending = false;
  }

  void showPendingUI() {
    setState(
      () {
        _purchasePending = true;
      },
    );
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  ///
  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(
        () {
          _isAvailable = isAvailable;
          _products = <ProductDetails>[];
          _purchases = <PurchaseDetails>[];
          _notFoundIds = <String>[];
          _consumables = <String>[];
          _purchasePending = false;
          _loading = false;
        },
      );
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(
        () {
          _queryProductError = productDetailResponse.error!.message;
          log("=========================================$_queryProductError");
          _isAvailable = isAvailable;
          _products = productDetailResponse.productDetails;
          _purchases = <PurchaseDetails>[];
          _notFoundIds = productDetailResponse.notFoundIDs;
          _consumables = <String>[];
          _purchasePending = false;
          _loading = false;
        },
      );
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(
        () {
          _queryProductError = null;
          _isAvailable = isAvailable;
          _products = productDetailResponse.productDetails;
          _purchases = <PurchaseDetails>[];
          _notFoundIds = productDetailResponse.notFoundIDs;
          _consumables = <String>[];
          _purchasePending = false;
          _loading = false;
        },
      );
      return;
    }

    final List<String> consumables = await ConsumableStore.load();
    setState(
      () {
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = consumables;
        _purchasePending = false;
        _loading = false;
      },
    );
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stack = <Widget>[];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: <Widget>[
            _buildProductList(),
            // _buildRestoreButton(),
          ],
        ),
      );
    } else {
      stack.add(
        Center(
          child: Text(_queryProductError!),
        ),
      );
    }
    if (_purchasePending) {
      stack.add(
        const Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.3,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.pinkColor,
        title: const Text('Google Play'),
        actions: const [
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(AppImages.appBackground),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(
              height: 600,
              child: Stack(
                children: stack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// _buildConnectionCheckTile to check Store is available or not

  /// _buildProductList to Show your List of Product{
  Card _buildProductList() {
    if (_loading) {
      return const Card(
        child: ListTile(
          leading: CircularProgressIndicator(),
          title: Text('Fetching products...'),
        ),
      );
    }
    if (!_isAvailable) {
      return const Card();
    }
    const ListTile productHeader = ListTile(
      title: Text('Products for Sale'),
    );
    final List<ListTile> productList = <ListTile>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(
        ListTile(
          title: Text(
            '[${_notFoundIds.join(", ")},] not found',
            style: TextStyle(color: ThemeData.light().colorScheme.error),
          ),
          subtitle: const Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.'),
        ),
      );
    }
    final Map<String, PurchaseDetails> purchases =
        Map<String, PurchaseDetails>.fromEntries(
      _purchases.map(
        (PurchaseDetails purchase) {
          /// Payments done ///
          if (purchase.pendingCompletePurchase) {
            _inAppPurchase.completePurchase(purchase);
            Fluttertoast.showToast(
              msg: purchase.verificationData.localVerificationData,
              backgroundColor: Colors.red,
            );
            log("****************");
            log("Payments is Done");
            log(
                "Server Verification Data :- ${purchase.verificationData.serverVerificationData}");
            log(
                "local Verification Data :- ${purchase.verificationData.localVerificationData}");
            log("Error :- ${purchase.error}");
            log(
                "pendingCompletePurchase :- ${purchase.pendingCompletePurchase}");
            log("Source Data :- ${purchase.verificationData.source}");
          } else {
            Fluttertoast.showToast(
              msg: "Payment Fails",
              backgroundColor: Colors.red,
            );
          }
          return MapEntry<String, PurchaseDetails>(
            purchase.productID,
            purchase,
          );
        },
      ),
    );
    productList.addAll(
      _products.map(
        (ProductDetails productDetails) {
          return ListTile(
            title: Text(
              productDetails.title,
            ),
            subtitle: Text(
              productDetails.description,
            ),

            /// Price button ///
            trailing:
                // previousPurchase != null
                //     ? IconButton(
                //   onPressed: () => confirmPriceChange(context),
                //   icon: const Icon(Icons.upgrade),
                // )
                //     :
                TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green[800],
              ),
              onPressed: () {
                late PurchaseParam purchaseParam;
                log(productDetails.id);
                log(productDetails.title);
                log(productDetails.price);
                if (Platform.isAndroid) {
                  // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
                  // verify the latest status of you your subscription by using server side receipt validation
                  // and update the UI accordingly. The subscription purchase status shown
                  // inside the app may not be accurate.

                  final GooglePlayPurchaseDetails? oldSubscription =
                      _getOldSubscription(productDetails, purchases);

                  purchaseParam = GooglePlayPurchaseParam(
                    productDetails: productDetails,
                    changeSubscriptionParam: (oldSubscription != null)
                        ? ChangeSubscriptionParam(
                            oldPurchaseDetails: oldSubscription,
                            // prorationMode:
                            //     ProrationMode.immediateWithTimeProration,
                          )
                        : null,
                  );
                } else {
                  purchaseParam = PurchaseParam(
                    productDetails: productDetails,
                  );
                }

                if (productDetails.id == _kConsumableId) {
                  _inAppPurchase.buyConsumable(
                    purchaseParam: purchaseParam,
                    autoConsume: _kAutoConsume,
                  );
                } else {
                  _inAppPurchase.buyNonConsumable(
                    purchaseParam: purchaseParam,
                  );
                }
              },
              child: Text(productDetails.price),
            ),
          );
        },
      ),
    );

    return Card(
      child: Column(
          children: <Widget>[productHeader, const Divider()] + productList),
    );
  }

  // Future<void> confirmPriceChange(BuildContext context) async {
  //   if (Platform.isAndroid) {
  //     final InAppPurchaseAndroidPlatformAddition androidAddition =
  //         _inAppPurchase
  //             .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
  //     final BillingResultWrapper priceChangeConfirmationResult =
  //         await androidAddition.launchPriceChangeConfirmationFlow(
  //       sku: 'purchaseId',
  //     );
  //     if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Price change accepted'),
  //         ),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             priceChangeConfirmationResult.debugMessage ??
  //                 'Price change failed with code ${priceChangeConfirmationResult.responseCode}',
  //           ),
  //         ),
  //       );
  //     }
  //   }
  //   if (Platform.isIOS) {
  //     final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
  //         _inAppPurchase
  //             .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
  //     await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
  //   }
  // }

  ///Get OldSubscription
  GooglePlayPurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    GooglePlayPurchaseDetails? oldSubscription;
    // if (productDetails.id == _kSilverSubscriptionId &&
    //     purchases[_kGoldSubscriptionId] != null) {
    //   oldSubscription =
    //       purchases[_kGoldSubscriptionId]! as GooglePlayPurchaseDetails;
    // } else if (productDetails.id == _kGoldSubscriptionId &&
    //     purchases[_kSilverSubscriptionId] != null) {
    //   oldSubscription =
    //       purchases[_kSilverSubscriptionId]! as GooglePlayPurchaseDetails;
    // }
    return oldSubscription;
  }

  ///_BuildConsumableBox

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(
      () {
        _consumables = consumables;
      },
    );
  }
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
