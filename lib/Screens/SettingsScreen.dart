import 'package:appcode/Common/AppConstantTexts.dart';
import 'package:appcode/Models/IAPProviderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appcode/Common/CustomWidgets.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:appcode/Common/Constants.dart' as cnst;

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  InAppPurchase inAppPurchase = InAppPurchase.instance;

  void _buyProduct(ProductDetails prod) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
    inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IAPProviderModel>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var prod in provider.products)
            if (provider.hasPurchased(prod.id).status !=
                PurchaseStatus.error) ...[
              Container(
                margin: EdgeInsets.all(20),
                height: 220,
                // width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.pink[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 20,
                          width: 40,
                          child: Center(
                            child: CustomTitleText(
                              titleText: PRO,
                              fontColor: Colors.black,
                              size: 10,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.lightGreenAccent[400],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ],
                    ),
                    CustomTitleText(
                      titleText: "Upgraded to premium",
                      fontWeight: FontWeight.bold,
                      fontColor: Colors.white,
                      size: 25,
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    CustomTitleText(
                      titleText: "No ads, just relaxing sounds!",
                      size: 10,
                      fontColor: Colors.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomElevatedButton(
                      child: CustomTitleText(
                        titleText: 'Premium',
                        fontColor: Colors.red,
                      ),
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ),
            ] else ...[
              Container(
                margin: EdgeInsets.all(20),
                height: 220,
                // width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.pink[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 20,
                          width: 40,
                          child: Center(
                            child: CustomTitleText(
                              titleText: PRO,
                              fontColor: Colors.black,
                              size: 10,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.lightGreenAccent[400],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ],
                    ),
                    CustomTitleText(
                      titleText: UPGRADE_TO_PREMIUM,
                      fontWeight: FontWeight.bold,
                      fontColor: Colors.white,
                      size: 25,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTitleText(
                      titleText: ENJOY_FULL_VERSION_OF_APP_WITHOUT_ADS,
                      size: 10,
                      fontColor: Colors.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomElevatedButton(
                      child: CustomTitleText(
                        titleText: 'Upgrade',
                        fontColor: Colors.black,
                      ),
                      onPressed: () {
                        _buyProduct(prod);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                          ),
                          child: CustomTitleText(
                            titleText: SPECIAL_OFFER,
                            fontColor: Colors.white,
                            size: 10,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          child: Image.asset(
                            'assets/offer.png',
                            height: 30,
                            width: 30,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

          ListTile(
            dense: true,
            title: CustomTitleText(
              titleText: RESTORE_PURCHASE,
              fontColor: Colors.white,
              size: 16,
            ),
            horizontalTitleGap: 0,
            leading: Image.asset(
              'assets/restore.png',
              height: 30,
              width: 30,
            ),
            trailing: Image.asset(
              'assets/forward_arrow.png',
              height: 25,
              width: 25,
            ),
            onTap: () {},
          ),
          Divider(
            color: Colors.grey,
            height: 0,
            thickness: 0.6,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            dense: true,
            title: CustomTitleText(
              titleText: PRIVACY_POLICY,
              fontColor: Colors.white,
              size: 16,
            ),
            horizontalTitleGap: 0,
            leading: Image.asset(
              'assets/privacy_policy.png',
              height: 30,
              width: 30,
            ),
            trailing: Image.asset(
              'assets/forward_arrow.png',
              height: 25,
              width: 25,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/PrivacyPolicyScreen');
            },
          ),
          Divider(
            color: Colors.grey,
            height: 0,
            thickness: 0.6,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            dense: true,
            title: CustomTitleText(
              titleText: TERMS_OF_SERVICE,
              fontColor: Colors.white,
              size: 16,
            ),
            horizontalTitleGap: 0,
            leading: Image.asset(
              'assets/terms_and_conditions.png',
              height: 30,
              width: 30,
            ),
            trailing: Image.asset(
              'assets/forward_arrow.png',
              height: 25,
              width: 25,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/TermsAndConditionsScreen');
            },
          ),
          Divider(
            color: Colors.grey,
            height: 0,
            thickness: 0.6,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            dense: true,
            title: CustomTitleText(
              titleText: RATE_THE_APP,
              fontColor: Colors.white,
              size: 16,
            ),
            horizontalTitleGap: 0,
            leading: Image.asset(
              'assets/rate_app.png',
              height: 30,
              width: 30,
            ),
            trailing: Image.asset(
              'assets/forward_arrow.png',
              height: 25,
              width: 25,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/FeedbackScreen');
            },
          ),
          Divider(
            color: Colors.grey,
            height: 0,
            thickness: 0.6,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            dense: true,
            title: CustomTitleText(
              titleText: SHARE_WITH_FRIENDS,
              fontColor: Colors.white,
              size: 16,
            ),
            horizontalTitleGap: 0,
            leading: Image.asset(
              'assets/share_with_friends.png',
              height: 30,
              width: 30,
            ),
            trailing: Image.asset(
              'assets/forward_arrow.png',
              height: 25,
              width: 25,
            ),
            onTap: () {
              Share.share(
                CHECK_OUT_THE_SOUND_APP_FROM_THE_LINK_BELOW,
              );
            },
          ),
          Divider(
            color: Colors.grey,
            height: 0,
            thickness: 0.6,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            dense: true,
            title: CustomTitleText(
              titleText: ABOUT_US,
              fontColor: Colors.white,
              size: 16,
            ),
            horizontalTitleGap: 0,
            leading: Image.asset(
              'assets/terms_and_conditions.png',
              height: 30,
              width: 30,
            ),
            trailing: Image.asset(
              'assets/forward_arrow.png',
              height: 25,
              width: 25,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/AboutUsScreen');
            },
          ),
          Divider(
            color: Colors.grey,
            height: 0,
            thickness: 0.6,
            indent: 15,
            endIndent: 15,
          ),
        ],
      ),
    );
  }
}
