import 'package:appcode/Common/CustomWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appcode/Common/Constants.dart' as cnst;

class CustomSetTimerPopUpComponent extends StatefulWidget {
  List<int> allHours;
  List<int> allMinutes;

  CustomSetTimerPopUpComponent(
      {required this.allHours, required this.allMinutes});

  @override
  _CustomSetTimerPopUpComponentState createState() =>
      _CustomSetTimerPopUpComponentState();
}

class _CustomSetTimerPopUpComponentState
    extends State<CustomSetTimerPopUpComponent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      children: List.generate(
                        widget.allHours.length,
                        (index) => CustomTitleText(
                          titleText: '${widget.allHours[index].toString()}',
                          fontColor: Colors.black,
                          size: 40,
                        ),
                      ),
                      magnification: 1.2,
                      diameterRatio: 1,
                      onSelectedItemChanged: (value) {
                        print(value);
                      },
                      itemExtent: 50,
                      selectionOverlay: Container(),
                    ),
                  ),
                  CustomTitleText(
                    titleText: ':',
                    size: 40,
                    fontColor: Colors.black,
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      children: List.generate(
                        widget.allMinutes.length,
                        (index) => CustomTitleText(
                          titleText: '${widget.allMinutes[index].toString()}',
                          fontColor: Colors.black,
                          size: 40,
                        ),
                      ),
                      magnification: 1.2,
                      diameterRatio: 1,
                      selectionOverlay: Container(),
                      onSelectedItemChanged: (value) {
                        print(value);
                      },
                      itemExtent: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: cnst.appPrimaryMaterialColor,
                          width: 0.6,
                        ),
                        right: BorderSide(
                          color: cnst.appPrimaryMaterialColor,
                          width: 0.6,
                        ),
                      ),
                    ),
                    child: Center(
                      child: CustomTitleText(
                        titleText: 'Cancel',
                        fontColor: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: cnst.appPrimaryMaterialColor,
                          width: 0.6,
                        ),
                      ),
                    ),
                    child: Center(
                      child: CustomTitleText(
                        titleText: 'Done',
                        fontColor: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
