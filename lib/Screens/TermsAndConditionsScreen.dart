import 'dart:io';

import 'package:appcode/Common/AppConstantTexts.dart';
import 'package:flutter/material.dart';
import 'package:appcode/Common/Component/LoadingComponent.dart';
import 'package:appcode/Common/CustomWidgets.dart';
import 'package:appcode/Common/Services.dart';
import 'package:appcode/Models/TermsAndConditionsModel.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  @override
  _TermsAndConditionsScreenState createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  List<TermsAndConditions> termsAndConditionsData = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getTermsAndConditions();
  }

  getTermsAndConditions() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.getTermsAndConditions().then((value) {
          if (value.success == "1") {
            setState(() {
              termsAndConditionsData = value.TermsCondition!;
            });
          }
          print(value.TermsCondition);
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
          titleText: TERMS_AND_CONDITIONS,
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
                data: termsAndConditionsData[0].terms_data.toString(),
                style: {
                  "body": Style(color: Colors.white,),
                },
              ),
          )
          : LoadingComponent(),
    );
  }
}
