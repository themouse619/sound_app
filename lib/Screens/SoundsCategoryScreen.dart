import 'dart:io';

import 'package:appcode/Models/SoundDataModel.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:appcode/Common/Component/LoadingComponent.dart';
import 'package:appcode/Common/CustomWidgets.dart';
import 'package:appcode/Common/Services.dart';
import 'package:appcode/Common/Constants.dart' as cnst;
import 'package:appcode/Models/SoundModel.dart';
import 'package:appcode/Screens/SoundsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundsCategoryScreen extends StatefulWidget {
  @override
  _SoundsCategoryScreenState createState() => _SoundsCategoryScreenState();
}

class _SoundsCategoryScreenState extends State<SoundsCategoryScreen> {
  List<MenuCategory> categoryData = [];
  List<SoundData> soundData = [];
  List<String> soundUrls = [];
  bool isLoading = false;

  @override
  void initState() {
    getCategoryData();
    super.initState();
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
            if (mounted) {
              setState(() {
                categoryData = value.menucategory!;
              });
            }
          }
          print(value.menucategory);
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        });
      }
    } on Exception catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      print(e.toString());
    }
  }

  getSoundData(cat_id, index) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        isLoading = true;
      });
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.getSoundData(cat_id.toString()).then((value) {
          if (value.success == "1") {
            prefs.setStringList(cnst.Session.soundUrls, []);
            soundUrls.clear();
            setState(() {
              for (int i = 0; i < value.sound!.length; i++) {
                soundUrls.add(cnst.Constants.playSoundApiBaseUrl +
                    value.sound![i].sound_file.toString());
              }
            });
            // print(soundUrls);
            prefs.setStringList(cnst.Session.soundUrls, soundUrls);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AudioServiceWidget(
                  child: SoundsScreen(
                    soundCategoryId: categoryData[index].id,
                    soundCategoryName: categoryData[index].cat_name,
                  ),
                ),
              ),
            );
          }
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
    return !isLoading
        ? Column(
            children: [
              Expanded(
                child: StaggeredGridView.countBuilder(
                  padding: EdgeInsets.all(8.0),
                  crossAxisCount: 2,
                  itemCount: categoryData.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        getSoundData(categoryData[index].id, index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                cnst.Constants.soundCategoryImageBaseUrl +
                                    categoryData[index].cat_icon.toString(),
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                          child: CustomTitleText(
                            titleText: categoryData[index].cat_name.toString(),
                            fontWeight: index == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontColor: Colors.white,
                            size: index == 0 ? 30 : 22,
                          ),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) =>
                      new StaggeredTile.count(index != 0 ? 1 : 2, 1),
                  mainAxisSpacing: 18.0,
                  crossAxisSpacing: 18.0,
                ),
              )
            ],
          )
        : LoadingComponent();
  }
}
