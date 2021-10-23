import 'package:flutter/material.dart';
import 'package:appcode/Common/Constants.dart' as cnst;

class CustomTitleText extends StatefulWidget {
  String titleText;
  double? size;
  FontWeight? fontWeight;
  Color? fontColor;
  TextAlign? textAlign;

  CustomTitleText(
      {required this.titleText, this.size, this.fontWeight, this.fontColor,this.textAlign});

  @override
  _CustomTitleTextState createState() => _CustomTitleTextState();
}

class _CustomTitleTextState extends State<CustomTitleText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.titleText,
      textAlign: widget.textAlign,
      style: TextStyle(
        color: widget.fontColor ?? cnst.appPrimaryMaterialColor,
        letterSpacing: 1.5,
        fontWeight: widget.fontWeight ?? FontWeight.normal,
        fontSize: widget.size ?? 22,
      ),
    );
  }
}

class CustomElevatedButton extends StatefulWidget {
  Widget child;
  VoidCallback onPressed;

  CustomElevatedButton({required this.child, required this.onPressed});

  @override
  _CustomElevatedButtonState createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 140,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          primary: cnst.appPrimaryMaterialColor,
        ),
        onPressed: widget.onPressed,
        child: widget.child,
      ),
    );
  }
}


