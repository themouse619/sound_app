import 'dart:io';

import 'package:appcode/Common/AppConstantTexts.dart';
import 'package:flutter/material.dart';
import 'package:appcode/Common/CustomWidgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:appcode/Common/Services.dart';
import 'package:appcode/Common/Constants.dart' as cnst;

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  postFeedback() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.postFeedback(emailController.text, titleController.text,
                descriptionController.text)
            .then((value) {
          if (value['success'] == '1') {
            Navigator.pop(context);
            Fluttertoast.showToast(
              msg: FEEDBACK_SUBMITTED_SUCCESSFULLY,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.white,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitleText(
          titleText: FEEDBACK,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                text: PLEASE_PROVIDE_YOUR_VALUABLE,
                style: TextStyle(
                  fontFamily: 'Skia',
                  color: Colors.white,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: FEEDBACK+'!',
                    style: TextStyle(
                      fontFamily: 'Skia',
                      color: cnst.appPrimaryMaterialColor,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: CustomTitleText(
                          titleText: EMAIL,
                          fontColor: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  Card(
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 16, color: cnst.appPrimaryMaterialColor),
                      cursorColor: cnst.appPrimaryMaterialColor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 5.0),
                        hintText: EMAIL_ADDRESS,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: CustomTitleText(
                          titleText: TITLE,
                          fontColor: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  Card(
                    child: TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 16, color: cnst.appPrimaryMaterialColor),
                      cursorColor: cnst.appPrimaryMaterialColor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 5.0),
                        hintText: FEEDBACK_TITLE,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: CustomTitleText(
                          titleText: DESCRIPTION,
                          fontColor: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  Card(
                    child: TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 16, color: cnst.appPrimaryMaterialColor),
                      cursorColor: cnst.appPrimaryMaterialColor,
                      maxLines: 6,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(5.0),
                        hintText: FEEDBACK_DESCRIPTION,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
              child: CustomTitleText(
                titleText: SUBMIT,
                fontColor: Colors.black,
                fontWeight: FontWeight.w600,
                size: 16,
              ),
              onPressed: () {
                if (emailController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: EMAIL_CANT_BE_EMPTY,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    backgroundColor: Colors.white,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else if (!emailController.text.contains('@')) {
                  Fluttertoast.showToast(
                    msg: PROVIDE_A_VALID_EMAIL,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    backgroundColor: Colors.white,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else if (titleController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: TITLE_CANT_BE_EMPTY,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    backgroundColor: Colors.white,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else if (descriptionController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: DESCRIPTION_CANT_BE_EMPTY,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    backgroundColor: Colors.white,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  postFeedback();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
