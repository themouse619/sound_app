import 'package:appcode/Common/AppConstantTexts.dart';
import 'package:appcode/Common/Component/CustomTimerPopUpComponent.dart';
import 'package:appcode/Common/CustomWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appcode/Common/Constants.dart' as cnst;

class SetTimerScreen extends StatefulWidget {
  @override
  _SetTimerScreenState createState() => _SetTimerScreenState();
}

class _SetTimerScreenState extends State<SetTimerScreen> {
  List<String> hours = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];
  List<int> allHours = [];
  List<int> allMinutes = [];
  List<String> minutes = [
    '5',
    '10',
    '15',
    '20',
    '25',
    '30',
    '35',
    '40',
  ];

  int selectedHourIndex = -1;
  int selectedMinuteIndex = -1;

  String selectedHours = '';
  String selectedMinutes = '';

  @override
  void initState() {
    setAllHoursAndMinutes();
    super.initState();
  }

  setAllHoursAndMinutes() {
    for (int i = 01; i <= 24; i++) {
      allHours.add(i);
    }
    for (int i = 01; i <= 60; i++) {
      allMinutes.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitleText(
          titleText: SET_TIMER,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Image.asset(
                  'assets/timer.png',
                  height: 60,
                  width: 60,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTitleText(
                    titleText: SELECT_HOURS,
                    fontColor: Colors.white,
                    size: 18,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Custom Timer clicked');

                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (builder) {
                          return CustomSetTimerPopUpComponent(
                            allHours: allHours,
                            allMinutes: allMinutes,
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: cnst.appPrimaryMaterialColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Center(
                        child: CustomTitleText(
                          titleText: CUSTOM,
                          fontColor: Colors.black,
                          size: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: hours.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      selectedHours = '';
                      setState(() {
                        selectedHourIndex = index;
                        selectedHours = hours[index];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: index == selectedHourIndex
                                  ? cnst.appPrimaryMaterialColor
                                  : Colors.grey,
                              width: 0.7,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTitleText(
                              titleText: '${hours[index]}',
                              fontColor: index == selectedHourIndex
                                  ? cnst.appPrimaryMaterialColor
                                  : Colors.grey,
                              size: 40,
                            ),
                            CustomTitleText(
                              titleText: index == 0 ? HOUR : HOURS,
                              fontColor: index == selectedHourIndex
                                  ? cnst.appPrimaryMaterialColor
                                  : Colors.grey,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomTitleText(
                    titleText: SELECT_MINUTES,
                    fontColor: Colors.white,
                    size: 18,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: hours.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      selectedMinutes = '';
                      setState(() {
                        selectedMinuteIndex = index;
                        selectedMinutes = minutes[index];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: index == selectedMinuteIndex
                                  ? cnst.appPrimaryMaterialColor
                                  : Colors.grey,
                              width: 0.7,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTitleText(
                              titleText: '${minutes[index]}',
                              fontColor: index == selectedMinuteIndex
                                  ? cnst.appPrimaryMaterialColor
                                  : Colors.grey,
                              size: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTitleText(
                              titleText: MIN,
                              fontColor: index == selectedMinuteIndex
                                  ? cnst.appPrimaryMaterialColor
                                  : Colors.grey,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              /*for (int i = 0; i < hours.length; i++) ...[
                Row(
                  children: [
                    for (int j = i; i < hours.length; j + 3) ...[
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.7,
                          ),
                        ),
                      ),
                    ]
                  ],
                )
              ]*/
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomElevatedButton(
        child: CustomTitleText(
          titleText: CONTINUE,
          fontColor: Colors.black,
        ),
        onPressed: () {
          print('Timer for $selectedHours hours and $selectedMinutes minutes');
        },
      ),
    );
  }
}
