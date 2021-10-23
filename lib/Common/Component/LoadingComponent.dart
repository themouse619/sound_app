import 'package:flutter/material.dart';
import 'package:appcode/Common/Constants.dart' as cnst;

class LoadingComponent extends StatefulWidget {
  @override
  _LoadingComponentState createState() => _LoadingComponentState();
}

class _LoadingComponentState extends State<LoadingComponent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: cnst.appPrimaryMaterialColor,
      ),
    );
  }
}
