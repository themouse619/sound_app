import 'dart:io';

import 'package:appcode/Common/AppConstantTexts.dart';
import 'package:appcode/Common/Component/LoadingComponent.dart';
import 'package:appcode/Common/Constants.dart' as cnst;
import 'package:appcode/Common/CustomWidgets.dart';
import 'package:appcode/Common/Services.dart';
import 'package:appcode/Models/AllSoundDataModel.dart';
import 'package:appcode/Models/IAPProviderModel.dart';
import 'package:appcode/Models/StoreSound.dart';
import 'package:appcode/Screens/CustomScreen.dart';
import 'package:appcode/Screens/SettingsScreen.dart';
import 'package:appcode/Screens/SoundsCategoryScreen.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 0;
  bool isSoundLoading = false;
  List<AllSoundData> allSoundData = [];
  List<List<String>> allSoundUrls = [];
  List<String> airSoundUrls = [];
  List<String> citySoundUrls = [];
  List<String> fireSoundUrls = [];
  List<String> homeSoundUrls = [];
  List<String> musicSoundUrls = [];
  List<String> natureDaySoundUrls = [];
  List<String> natureNightSoundUrls = [];
  List<String> oceanSoundUrls = [];
  List<String> orientalSoundUrls = [];
  List<String> rainSoundUrls = [];
  List<String> waterSoundUrls = [];
  String encodedData = '';

  @override
  void initState() {
    var provider = Provider.of<IAPProviderModel>(context, listen: false);
    provider.initialize();
    setAllSoundUrlsList();
    getAllSoundData();
    super.initState();
  }

  @override
  void dispose() {
    var provider = Provider.of<IAPProviderModel>(context, listen: false);
    provider.subscription.cancel();
    super.dispose();
  }

  getScreens() {
    if (index == 0) {
      stopAllPlayingSounds();
      return SoundsCategoryScreen();
    } else if (index == 1) {
      return AudioServiceWidget(child: CustomScreen());
    } else if (index == 2) {
      stopAllPlayingSounds();
      return SettingsScreen();
    }
  }

  setAllSoundUrlsList() {
    allSoundUrls = [
      airSoundUrls,
      rainSoundUrls,
      waterSoundUrls,
      citySoundUrls,
      fireSoundUrls,
      homeSoundUrls,
      musicSoundUrls,
      natureDaySoundUrls,
      natureNightSoundUrls,
      oceanSoundUrls,
      orientalSoundUrls,
    ];
  }

  encodeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    encodedData = StoreSound.encode([
      StoreSound(listSoundData: airSoundUrls),
      StoreSound(listSoundData: rainSoundUrls),
      StoreSound(listSoundData: waterSoundUrls),
      StoreSound(listSoundData: citySoundUrls),
      StoreSound(listSoundData: fireSoundUrls),
      StoreSound(listSoundData: homeSoundUrls),
      StoreSound(listSoundData: musicSoundUrls),
      StoreSound(listSoundData: natureDaySoundUrls),
      StoreSound(listSoundData: natureNightSoundUrls),
      StoreSound(listSoundData: oceanSoundUrls),
      StoreSound(listSoundData: orientalSoundUrls),
    ]);
    prefs.setString(cnst.Session.allCustomSoundUrls, encodedData);
  }

  stopAllPlayingSounds() async {
    await AudioService.stop();
  }

  getAppbarTitle() {
    if (index == 0) {
      return DASHBOARD;
    } else if (index == 1) {
      return SOUND_CUSTOMIZE;
    } else if (index == 2) {
      return SETTINGS;
    }
  }

  getAllSoundData() async {
    try {
      setState(() {
        isSoundLoading = true;
      });
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.getAllSoundData().then((value) {
          if (value.success == "1") {
            setState(() {
              allSoundData = value.sound!;
              for (int i = 0; i < allSoundData.length; i++) {
                for (int j = 0; j < allSoundData[i].list_sound!.length; j++) {
                  allSoundUrls[i].add(cnst.Constants.playSoundApiBaseUrl +
                      allSoundData[i].list_sound![j].sound_file!);
                }
              }
              encodeData();
            });
          }
          setState(() {
            isSoundLoading = false;
          });
        });
      }
    } on Exception catch (e) {
      setState(() {
        isSoundLoading = false;
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitleText(
          titleText: getAppbarTitle(),
        ),
        // actions: [
        //   index == 0
        //       ? Row(
        //           children: [
        //             IconButton(
        //               onPressed: () {
        //                 Navigator.pushNamed(context, '/PlaySoundScreen');
        //
        //               },
        //               icon: Image.asset(
        //                 'assets/play.png',
        //                 height: 20,
        //                 width: 20,
        //                 color: cnst.appPrimaryMaterialColor,
        //               ),
        //             ),
        //             IconButton(
        //               onPressed: () {
        //                 Navigator.pushNamed(context, '/SetTimerScreen');
        //               },
        //               icon: Image.asset(
        //                 'assets/timer.png',
        //                 height: 20,
        //                 width: 20,
        //               ),
        //             ),
        //           ],
        //         )
        //       : Container()
        // ],
      ),
      body: !isSoundLoading ? getScreens() : LoadingComponent(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 0;
                  });
                  print('sounds clicked index $index');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    index == 0
                        ? Image.asset(
                            'assets/sounds_fill.png',
                            height: 25,
                            width: 25,
                          )
                        : Image.asset(
                            'assets/sounds.png',
                            height: 25,
                            width: 25,
                          ),
                    CustomTitleText(
                      titleText: SOUNDS,
                      size: 14,
                      fontColor: index == 0
                          ? cnst.appPrimaryMaterialColor
                          : Colors.white,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 1;
                  });
                  print('custom clicked index $index');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    index == 1
                        ? Image.asset(
                            'assets/custom_fill.png',
                            height: 25,
                            width: 25,
                          )
                        : Image.asset(
                            'assets/custom.png',
                            height: 25,
                            width: 25,
                          ),
                    CustomTitleText(
                      titleText: CUSTOM,
                      size: 14,
                      fontColor: index == 1
                          ? cnst.appPrimaryMaterialColor
                          : Colors.white,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 2;
                  });
                  print('settings clicked index $index');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    index == 2
                        ? Image.asset(
                            'assets/settings_fill.png',
                            height: 25,
                            width: 25,
                          )
                        : Image.asset(
                            'assets/settings.png',
                            height: 25,
                            width: 25,
                          ),
                    CustomTitleText(
                      titleText: SETTINGS,
                      size: 14,
                      fontColor: index == 2
                          ? cnst.appPrimaryMaterialColor
                          : Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: index == 1
      //     ? Container(
      //         height: 45,
      //         width: 200,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),
      //           color: cnst.appPrimaryMaterialColor,
      //         ),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             Image.asset(
      //               'assets/speaker.png',
      //               height: 30,
      //               width: 30,
      //             ),
      //             CustomTitleText(
      //               titleText: 'Volume mix',
      //               fontColor: Colors.black,
      //               size: 16,
      //             ),
      //             Container(
      //               height: 20,
      //               width: 20,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(100),
      //                 color: Colors.black,
      //               ),
      //               child: Center(
      //                   child: CustomTitleText(
      //                 titleText: '2',
      //                 size: 16,
      //               )),
      //             ),
      //           ],
      //         ),
      //       )
      //     : Container(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
