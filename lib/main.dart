import 'package:appcode/Common/Constants.dart' as cnst;
import 'package:appcode/Models/IAPProviderModel.dart';
import 'package:appcode/Screens/PrivacyPolicyScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import 'Screens/AboutUsScreen.dart';
import 'Screens/Dashboard.dart';
import 'Screens/FeedbackScreen.dart';
import 'Screens/PlaySoundScreen.dart';
import 'Screens/SetTimerScreen.dart';
import 'Screens/TermsAndConditionsScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }
  return runApp(ChangeNotifierProvider(
      create: (context) => IAPProviderModel(), child: new MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        fontFamily: 'Skia',
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(
            color: cnst.appPrimaryMaterialColor,
          ),
        ),
        // primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Dashboard(),
        '/AboutUsScreen': (context) => AboutUsScreen(),
        '/TermsAndConditionsScreen': (context) => TermsAndConditionsScreen(),
        '/PrivacyPolicyScreen': (context) => PrivacyPolicyScreen(),
        '/FeedbackScreen': (context) => FeedbackScreen(),
        '/SetTimerScreen': (context) => SetTimerScreen(),
        '/PlaySoundScreen': (context) => PlaySoundScreen(),
      },
    );
  }
}
