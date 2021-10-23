import 'package:appcode/Common/AppConstantTexts.dart';
import 'package:appcode/Common/Constants.dart' as cnst;
import 'package:appcode/Screens/CustomScreen.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import '../CustomWidgets.dart';

class VolumeMixPopUpComponent extends StatefulWidget {
  List<List<AllSoundsClass>> allSoundsClass;

  VolumeMixPopUpComponent({required this.allSoundsClass});

  @override
  _VolumeMixPopUpComponentState createState() =>
      _VolumeMixPopUpComponentState();
}

class _VolumeMixPopUpComponentState extends State<VolumeMixPopUpComponent> {
  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      // contentPadding: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      backgroundColor: cnst.appPrimaryMaterialColor[800],
      title: Row(
        children: [
          Expanded(
            child: CustomTitleText(
              titleText: VOLUME_MIX,
              textAlign: TextAlign.center,
              fontColor: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.cancel,
              color: Colors.white,
            ),
          ),
        ],
      ),
      content: SizedBox(
        height: 360,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            for (int i = 0; i < widget.allSoundsClass.length; i++) ...[
              for (int j = 0; j < widget.allSoundsClass[i].length; j++) ...[
                if (widget.allSoundsClass[i][j].status) ...[
                  Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            CustomTitleText(
                              titleText: widget.allSoundsClass[i][j].name,
                              size: 18,
                            ),
                            Slider(
                              activeColor: cnst.appPrimaryMaterialColor,
                              value: widget.allSoundsClass[i][j].volume,
                              onChanged: (val) {
                                setState(() {
                                  widget.allSoundsClass[i][j].volume = val;
                                });
                                AudioService.customAction('setVolume',
                                    {'lIndex': i, 'gIndex': j, 'volume': val});
                              },
                            ),
                          ],
                        ),
                        // IconButton(
                        //   onPressed: () {
                        //
                        //     AudioService.customAction(
                        //         'pauseAudio', {'lIndex': i, 'gIndex': j});
                        //     setState(() {
                        //
                        //     });
                        //   },
                        //   icon: Icon(
                        //     Icons.cancel,
                        //     color: cnst.appPrimaryMaterialColor,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ]
              ]
            ]
          ],
        ),
      ),
    );
  }
}
