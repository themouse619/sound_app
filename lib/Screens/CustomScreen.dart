import 'dart:developer';
import 'dart:io';

import 'package:appcode/Common/AppConstantTexts.dart';
import 'package:appcode/Common/Component/LoadingComponent.dart';
import 'package:appcode/Common/Component/VolumeMixPopUpComponent.dart';
import 'package:appcode/Common/Constants.dart' as cnst;
import 'package:appcode/Common/CustomWidgets.dart';
import 'package:appcode/Common/Services.dart';
import 'package:appcode/Models/AllSoundDataModel.dart';
import 'package:appcode/Models/SoundModel.dart';
import 'package:appcode/Models/StoreSound.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomScreen extends StatefulWidget {
  @override
  _CustomScreenState createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  List<MenuCategory> categoryData = [];
  List<String> categoryTitles = [];
  List<AllSoundData> allSoundData = [];
  List<List<AllSoundsClass>> allSoundsClass = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];
  List<List<int>> selectedIndexList = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];

  bool isLoading = false;
  bool isSoundLoading = false;
  bool isSoundLocked = false;
  bool isSoundDataLoading = false;
  bool isAllSoundClassListSet = false;

  int soundMixCount = 0;
  int tabIndex = 0;

  ItemScrollController itemScrollController = new ItemScrollController();
  List<StoreSound> storeSound = [];

  @override
  void initState() {
    getCategoryData();
    decodeData();
    super.initState();
  }

  decodeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    storeSound =
        StoreSound.decode(prefs.getString(cnst.Session.allCustomSoundUrls)!);
    for (int i = 0; i < storeSound.length; i++) {
      log(storeSound[i].listSoundData.toString());
    }
  }

  getCategoryData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.getSoundCategoryData().then((value) {
          if (value.success == "1") {
            categoryData.clear();
            categoryTitles.clear();
            setState(() {
              categoryData = value.menucategory!;
              for (int i = 0; i < categoryData.length; i++) {
                categoryTitles.add(categoryData[i].cat_name!);
              }
              categoryTitles.insert(0, ALL);
              if (tabIndex == 0) {
                getAllSoundData();
              }
            });
          }
          print(value.menucategory);
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
              isSoundDataLoading = true;
              allSoundData = value.sound!;
              for (int i = 0; i < allSoundData.length; i++) {
                for (int j = 0; j < allSoundData[i].list_sound!.length; j++) {
                  allSoundsClass[i].add(
                    AllSoundsClass(
                      name: allSoundData[i].list_sound![j].name!,
                      status: false,
                      volume: 1.0,
                    ),
                  );
                }
              }
              isSoundDataLoading = false;
            });
          }
          setState(() {
            isSoundLoading = false;
          });
          if (isSoundDataLoading == false) {
            loadAllAudios();
          }
        });
      }
    } on Exception catch (e) {
      setState(() {
        isSoundLoading = false;
      });
      print(e.toString());
    }
  }

  goToElement(int index) {
    if (index == 0) {
      itemScrollController.scrollTo(
        index: 0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    } else if (index == 1) {
      itemScrollController.scrollTo(
        index: 0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    } else if (index == 2) {
      itemScrollController.scrollTo(
        index: 3,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    } else if (index == 3) {
      itemScrollController.scrollTo(
        index: 4,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    } else if (index == 4) {
      itemScrollController.scrollTo(
        index: 5,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    } else if (index == 5) {
      itemScrollController.scrollTo(
        index: 6,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    } else if (index == 6) {
      itemScrollController.scrollTo(
        index: 7,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    } else if (index == 7) {
      itemScrollController.scrollTo(
        index: 8,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    } else if (index == 8) {
      itemScrollController.scrollTo(
        index: 9,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    } else if (index == 9) {
      itemScrollController.scrollTo(
        index: 10,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    } else if (index == 10) {
      itemScrollController.scrollTo(
        index: 1,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    } else if (index == 11) {
      itemScrollController.scrollTo(
        index: 2,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        !isLoading
            ? Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryTitles.length,
                      itemBuilder: (context, index) {
                        return TextButton(
                          onPressed: () {
                            setState(() {
                              tabIndex = index;
                              goToElement(index);
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomTitleText(
                                titleText: categoryTitles[index],
                                fontColor: tabIndex == index
                                    ? cnst.appPrimaryMaterialColor
                                    : Colors.white,
                                size: 16,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: tabIndex == index
                                      ? cnst.appPrimaryMaterialColor
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 2,
                                width: 40,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  if (!isSoundLoading) ...[
                    Expanded(
                      child: ScrollablePositionedList.builder(
                        itemScrollController: itemScrollController,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        itemCount: allSoundData.length,
                        itemBuilder: (context, lIndex) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.black,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      CustomTitleText(
                                        titleText: allSoundData[lIndex].cat_id!,
                                        fontColor: Colors.white,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                    ),
                                    itemCount: allSoundsClass[lIndex].length,
                                    itemBuilder: (context, gIndex) {
                                      return playerCard(
                                        name:
                                            allSoundsClass[lIndex][gIndex].name,
                                        gIndex: gIndex,
                                        lIndex: lIndex,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: LoadingComponent(),
                    ),
                  ]
                ],
              )
            : LoadingComponent(),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    print('Volume mix clicked');
                    // showDialog(
                    //     barrierDismissible: false,
                    //     context: context,
                    //     builder: (builder) {
                    //       return VolumeMixPopUpComponent(
                    //         allSoundsClass: allSoundsClass,
                    //       );
                    //     });
                  },
                  child: Container(
                    height: 45,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: cnst.appPrimaryMaterialColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/speaker.png',
                          height: 30,
                          width: 30,
                        ),
                        CustomTitleText(
                          titleText: VOLUME_MIX,
                          fontColor: Colors.black,
                          size: 16,
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: CustomTitleText(
                              titleText: soundMixCount.toString(),
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        )
      ],
    );
  }

  playerCard({
    String name = " ",
    int lIndex = -1,
    int gIndex = -1,
  }) {
    return GestureDetector(
      onTap: isSoundLocked
          ? null
          : () async {
              if (allSoundsClass[lIndex][gIndex].status) {
                AudioService.customAction(
                    'pauseAudio', {'lIndex': lIndex, 'gIndex': gIndex});
              } else if (allSoundsClass[lIndex][gIndex].isInitialized) {
                AudioService.customAction(
                    'playAudio', {'lIndex': lIndex, 'gIndex': gIndex});
              } else {
                AudioService.customAction('initializePlayer', {
                  'url': storeSound[lIndex].listSoundData![gIndex],
                  'lIndex': lIndex,
                  'gIndex': gIndex,
                });
                allSoundsClass[lIndex][gIndex].isInitialized = true;
              }
              setState(() {
                allSoundsClass[lIndex][gIndex].status =
                    !allSoundsClass[lIndex][gIndex].status;
                if (allSoundsClass[lIndex][gIndex].status) {
                  soundMixCount++;
                  selectedIndexList[lIndex].add(gIndex);
                } else {
                  soundMixCount--;
                  selectedIndexList[lIndex].remove(gIndex);
                }
              });
              print("${allSoundsClass[lIndex][gIndex].name} playing now");
              print(selectedIndexList);
            },
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        cnst.Constants.soundFileImageBaseUrl +
                            allSoundData[lIndex]
                                .list_sound![gIndex]
                                .sound_image!,
                      ),
                      fit: BoxFit.scaleDown,
                    ),
                    border: Border.all(
                      color: allSoundsClass[lIndex][gIndex].status
                          ? cnst.appPrimaryMaterialColor
                          : Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: CustomTitleText(
                      textAlign: TextAlign.center,
                      titleText: allSoundsClass[lIndex][gIndex].name,
                      fontColor: allSoundsClass[lIndex][gIndex].status
                          ? cnst.appPrimaryMaterialColor
                          : Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          allSoundsClass[lIndex][gIndex].status
              ? SizedBox(
                  height: 15,
                  child: Slider(
                    activeColor: cnst.appPrimaryMaterialColor,
                    value: allSoundsClass[lIndex][gIndex].volume,
                    onChanged: (val) {
                      setState(() {
                        allSoundsClass[lIndex][gIndex].volume = val;
                      });
                      AudioService.customAction('setVolume',
                          {'lIndex': lIndex, 'gIndex': gIndex, 'volume': val});
                    },
                  ),
                )
              : SizedBox(
                  height: 15,
                ),
        ],
      ),
    );
  }

  loadAllAudios() async {
    await AudioService.stop();
    await AudioService.start(
      backgroundTaskEntrypoint: _entryPoint,
      androidNotificationColor: 0xFF26C6DA,
      androidNotificationIcon: 'mipmap/ic_launcher',
      androidEnableQueue: true,
    );
    await AudioService.setRepeatMode(AudioServiceRepeatMode.all);
  }
}

class AllSoundsClass {
  String name = "";
  double volume = 1.0;
  bool status = false;
  bool isInitialized = false;

  AllSoundsClass({
    this.name = "",
    this.volume = 0.0,
    this.status = false,
    this.isInitialized = false,
  });
}

void _entryPoint() => AudioServiceBackground.run(() => AudioPlayerTask());

class AudioPlayerTask extends BackgroundAudioTask {
  List<List<AudioPlayer>> _players = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("storeSound.length");
    print(StoreSound.decode(prefs.getString(cnst.Session.allCustomSoundUrls)!)
        .length);
    for (int i = 0;
        i <
            StoreSound.decode(prefs.getString(cnst.Session.allCustomSoundUrls)!)
                .length;
        i++) {
      for (int j = 0;
          j <
              StoreSound.decode(
                      prefs.getString(cnst.Session.allCustomSoundUrls)!)[i]
                  .listSoundData!
                  .length;
          j++) {
        _players[i].add(AudioPlayer());
        print("PLAYER STATUS INITIALIZED $i : ${_players[i][j].playing}");
      }
    }

    final mediaItem = MediaItem(
      id: StoreSound.decode(
              prefs.getString(cnst.Session.allCustomSoundUrls)!)[0]
          .listSoundData![0],
      album: MULTIPLE_AUDIOS,
      title: BACKGROUND_PLAY,
    );
    // Tell the UI and media notification what we're playing.
    AudioServiceBackground.setMediaItem(mediaItem);
  }

  @override
  Future<void> onStop() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i = 0;
        i <
            StoreSound.decode(prefs.getString(cnst.Session.allCustomSoundUrls)!)
                .length;
        i++) {
      for (int j = 0;
          j <
              StoreSound.decode(
                      prefs.getString(cnst.Session.allCustomSoundUrls)!)[i]
                  .listSoundData!
                  .length;
          j++) {
        await _players[i][j].dispose();
        print("PLAYER STATUS Stopped$i : ${_players[i][j].playing}");
      }
    }
    await super.onStop();
  }

  onPlay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i = 0;
        i <
            StoreSound.decode(prefs.getString(cnst.Session.allCustomSoundUrls)!)
                .length;
        i++) {
      for (int j = 0;
          j <
              StoreSound.decode(
                      prefs.getString(cnst.Session.allCustomSoundUrls)!)[i]
                  .listSoundData!
                  .length;
          j++) {
        _players[i][j].play();
        print("PLAYER STATUS PLAYING $i : ${_players[i][j].playing}");
      }
    }
  }

  onPause() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i = 0;
        i <
            StoreSound.decode(prefs.getString(cnst.Session.allCustomSoundUrls)!)
                .length;
        i++) {
      for (int j = 0;
          j <
              StoreSound.decode(
                      prefs.getString(cnst.Session.allCustomSoundUrls)!)[i]
                  .listSoundData!
                  .length;
          j++) {
        await _players[i][j].pause();
        print("PLAYER STATUS PAUSED $i : ${_players[i][j].playing}");
      }
    }
  }

  // onSeekTo(Duration duration) => _player.seek(duration);
  //
  // onSetSpeed(double speed) => _player.setSpeed(speed);
  //

  onCustomAction(String name, dynamic arguments) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (name) {
      case 'setVolume':
        await _players[arguments['lIndex']][arguments['gIndex']]
            .setVolume(arguments['volume']);
        break;
      case 'saveBookmark':
        // app-specific code
        break;
      case 'playAudios':
        for (int i = 0;
            i <
                StoreSound.decode(
                        prefs.getString(cnst.Session.allCustomSoundUrls)!)
                    .length;
            i++) {
          for (int j = 0;
              j <
                  StoreSound.decode(
                          prefs.getString(cnst.Session.allCustomSoundUrls)!)[i]
                      .listSoundData!
                      .length;
              j++) {
            _players[i][j].play();
            print("PLAYER STATUS PLAYING $i : ${_players[i][j].playing}");
          }
        }
        break;
      case 'playAudio':
        _players[arguments['lIndex']][arguments['gIndex']].play();
        break;
      case 'pauseAudio':
        _players[arguments['lIndex']][arguments['gIndex']].pause();
        break;
      case 'initializePlayer':
        initializePlayer(
            arguments['url'], arguments['lIndex'], arguments['gIndex']);
        break;
      case 'disposeAudio':
        {
          _players[arguments['lIndex']][arguments['gIndex']].stop();
          _players[arguments['lIndex']][arguments['gIndex']].dispose();
        }
        break;
    }
  }

  initializePlayer(String url, int lIndex, int gIndex) async {
    _players[lIndex][gIndex].playerStateStream.listen((playerState) {
      AudioServiceBackground.setState(
        playing: playerState.playing,
        // Every state from the audio player gets mapped onto an audio_service state.
        processingState: {
          ProcessingState.idle: AudioProcessingState.none,
          ProcessingState.loading: AudioProcessingState.connecting,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[playerState.processingState],
        // Tell clients what buttons/controls should be enabled in the
        // current state.
        controls: [
          playerState.playing ? MediaControl.pause : MediaControl.play,
          MediaControl.stop,
        ],
      );
    });

    await _players[lIndex][gIndex].setUrl(url);
    _players[lIndex][gIndex].setLoopMode(LoopMode.all);
    _players[lIndex][gIndex].play();
  }
}
