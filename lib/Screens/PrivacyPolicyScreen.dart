import 'dart:convert';
import 'dart:io';

import 'package:appcode/Common/AppConstantTexts.dart';
import 'package:appcode/Common/CustomWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  loadHtmlFromAsset() async {
    final htmlContent =
        await rootBundle.loadString('assets/privacy_policy_content.html');
    final url = Uri.dataFromString(
      htmlContent,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();
    _webViewController.loadUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitleText(
          titleText: PRIVACY_POLICY,
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/back_arrow.png',
            height: 30,
            width: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: WebView(
        initialUrl: '',
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          loadHtmlFromAsset();
        },
      ),
    );
  }
}
