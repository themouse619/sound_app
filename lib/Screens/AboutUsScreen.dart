import 'dart:io';

import 'package:appcode/Common/AppConstantTexts.dart';
import 'package:flutter/material.dart';
import 'package:appcode/Common/Component/LoadingComponent.dart';
import 'package:appcode/Common/CustomWidgets.dart';
import 'package:appcode/Common/Services.dart';
import 'package:appcode/Models/AboutUsModel.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  List<AboutUs> aboutUsData = [];
  bool isLoading = false;

  @override
  void initState() {
    getAboutUsData();
    super.initState();
  }

  getAboutUsData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.getAboutUs().then((value) {
          if (value.success == "1") {
            setState(() {
              aboutUsData = value.about_us!;
            });
          }
          print(value.about_us);
          setState(() {
            isLoading = false;
          });
        });
      }
    } on Exception catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitleText(
          titleText: ABOUT_US,
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
      body: !isLoading
          ? SingleChildScrollView(
              child: Html(
                data: aboutUsData[0].content_data.toString(),
                style: {
                  "body": Style(
                    color: Colors.white,
                  ),
                },
              ),
            )
          : LoadingComponent(),
    );
  }
}
