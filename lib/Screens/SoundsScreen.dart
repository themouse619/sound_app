import 'dart:io';

import 'package:appcode/Common/AppConstantTexts.dart';
import 'package:appcode/Common/Component/LoadingComponent.dart';
import 'package:appcode/Common/Constants.dart' as cnst;
import 'package:appcode/Common/CustomWidgets.dart';
import 'package:appcode/Common/Services.dart';
import 'package:appcode/Models/SoundDataModel.dart';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundsScreen extends StatefulWidget {
  int? soundCategoryId;

  String? soundCategoryName;

  SoundsScreen({this.soundCategoryName, this.soundCategoryId});

  @override
  _SoundsScreenState createState() => _SoundsScreenState();
}

class _SoundsScreenState extends State<SoundsScreen> {
  List<SoundData> soundData = [];
  List<AllSoundsClass> allSoundsClass = [];
  bool isLoading = false;
  bool isSoundDataLoading = false;

  @override
  void initState() {
    getSoundData();
    super.initState();
  }

  @override
  void dispose() {
    stopAllPlayingSounds();
    super.dispose();
  }

  getSoundData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.getSoundData(widget.soundCategoryId.toString()).then((value) {
          if (value.success == "1") {
            setState(() {
              isSoundDataLoading = true;
              soundData = value.sound!;
              for (int i = 0; i < soundData.length; i++) {
                allSoundsClass.add(
                  AllSoundsClass(
                    name: soundData[i].name!,
                    status: false,
                    volume: 1.0,
                  ),
                );
              }
              isSoundDataLoading = false;
            });
          }
          setState(() {
            isLoading = false;
          });
          if (isSoundDataLoading == false) {
            loadAllAudios();
          }
        });
      }
    } on Exception catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  stopAllPlayingSounds() async {
    await AudioService.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitleText(
          titleText: widget.soundCategoryName! + ' ' + SOUNDS,
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/back_arrow.png',
            height: 30,
            width: 30,
          ),
          onPressed: () {
            stopAllPlayingSounds();
            Navigator.pop(context);
          },
        ),
      ),
      body: !isLoading
          ? Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(8.0),
                    itemCount: allSoundsClass.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 18.0,
                      mainAxisSpacing: 18.0,
                    ),
                    itemBuilder: (context, index) {
                      return playerCard(
                          name: allSoundsClass[index].name, index: index);
                    },
                  ),
                ),
              ],
            )
          : LoadingComponent(),
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

  playerCard({String name = " ", int index = -1}) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
              onTap: () {
                if (allSoundsClass[index].status) {
                  AudioService.customAction('pauseAudio', index);
                } else {
                  AudioService.customAction('playAudio', index);
                }
                setState(() {
                  allSoundsClass[index].status = !allSoundsClass[index].status;
                });
                print("${allSoundsClass[index].name} playing now");
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(
                          cnst.Constants.soundFileImageBaseUrl +
                              soundData[index].sound_image!,
                        ),
                        fit: BoxFit.scaleDown,
                      ),
                    ),

                    child: Center(
                      child: CustomTitleText(
                        titleText: soundData[index].name!,
                        fontColor: allSoundsClass[index].status
                            ? cnst.appPrimaryMaterialColor
                            : Colors.white,
                        size: 18,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Icon(
                    allSoundsClass[index].status
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white.withOpacity(0.7),
                    size: 50,
                  )
                ],
              )),
        ),
        Slider(
          activeColor: cnst.appPrimaryMaterialColor,
          value: allSoundsClass[index].volume,
          onChanged: (val) {
            setState(() {
              allSoundsClass[index].volume = val;
            });
            AudioService.customAction(
                'setVolume', {'index': index, 'volume': val});
          },
        ),
      ],
    );
  }
}

class AllSoundsClass {
  String name = "";
  double volume = 1.0;
  bool status = false;

  AllSoundsClass({this.name = "", this.volume = 0.0, this.status = false});
}

void _entryPoint() => AudioServiceBackground.run(() => AudioPlayerTask());

class AudioPlayerTask extends BackgroundAudioTask {
  List<AudioPlayer> _player = [];

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("sound Url Data");
    // print(prefs.getStringList("soundUrls"));
    // print('${prefs.getStringList("soundUrls")!.length} data of sound');

    for (int i = 0;
        i < prefs.getStringList(cnst.Session.soundUrls)!.length;
        i++) {
      _player.add(AudioPlayer());
      print("PLAYER STATUS INITIALIZED $i : ${_player[i].playing}");
    }

    final mediaItem = MediaItem(
      id: prefs.getStringList(cnst.Session.soundUrls)![0],
      album: "Multiple Audios",
      title: "Background Play",
    );
    // Tell the UI and media notification what we're playing.
    AudioServiceBackground.setMediaItem(mediaItem);
    // Listen to state changes on the player...

    for (int i = 0;
        i < prefs.getStringList(cnst.Session.soundUrls)!.length;
        i++) {
      _player[i].playerStateStream.listen((playerState) {
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
      await _player[i].setUrl(prefs.getStringList(cnst.Session.soundUrls)![i]);
      _player[i].setLoopMode(LoopMode.all);
      print(
          "PLAYER STATUS (set audio urls and loop mode)$i : ${_player[i].playing}");
    }

    //await onPlay();

    // Start loading something (will play when ready).
    // await _player2.setUrl("https://nulled-download.com/resources/air_wind_door.ogg");
    // await _player2.setUrl("https://nulled-download.com/resources/air_wind_door.ogg");
    //
    // _player.setLoopMode(LoopMode.all);
    // _player2.setLoopMode(LoopMode.all);
    // _player3.setLoopMode(LoopMode.all);
    //
    // print("PLAYING AUDIOS : ${_player.playing} & ${_player2.playing}");
    // print("PLAYING AUDIOS LOOPS: ${_player.loopMode} & ${_player2.loopMode}");

    // print("LOADING MEDIA ITEM : ${mediaItem.id}");

    // Play when ready.
    // _player.play();
    // _player2.play();
    //print("MEDIA ITEM STATUS : ${_player.playing}");
  }

  @override
  Future<void> onStop() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0;
        i < prefs.getStringList(cnst.Session.soundUrls)!.length;
        i++) {
      await _player[i].dispose();
      print("PLAYER STATUS Stopped$i : ${_player[i].playing}");
    }
    await super.onStop();
  }

  onPlay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i = 0;
        i < prefs.getStringList(cnst.Session.soundUrls)!.length;
        i++) {
      _player[i].play();
      print("PLAYER STATUS PLAYING $i : ${_player[i].playing}");
    }
  }

  onPause() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i = 0;
        i < prefs.getStringList(cnst.Session.soundUrls)!.length;
        i++) {
      await _player[i].pause();
      print("PLAYER STATUS PAUSED $i : ${_player[i].playing}");
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
        await _player[arguments['index']].setVolume(arguments['volume']);
        break;
      case 'saveBookmark':
        // app-specific code
        break;
      case 'playAudios':
        for (int i = 0;
            i < prefs.getStringList(cnst.Session.soundUrls)!.length;
            i++) {
          _player[i].play();
          print("PLAYER STATUS PLAYING $i : ${_player[i].playing}");
        }
        break;
      case 'playAudio':
        _player[arguments].play();
        break;
      case 'pauseAudio':
        _player[arguments].pause();
        break;
      case 'disposeAudio':
        {
          _player[arguments].stop();
          _player[arguments].dispose();
        }
        break;
    }
  }
}
