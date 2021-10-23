import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static const String apiBaseUrl = 'http://nulled-download.com/Ajay/Sleep/api/';
  static const String soundCategoryImageBaseUrl =
      'https://nulled-download.com/Ajay/Sleep/public/upload/images/menu_cat_icon/';
  static const String playSoundApiBaseUrl =
      'https://nulled-download.com/Ajay/Sleep/public/upload/images/menu_sound_icon/';
  static const String soundFileImageBaseUrl =
      'https://nulled-download.com/Ajay/Sleep/public/upload/images/menu_sound_icon/';
}

class Session {
  static const String soundUrls = 'soundUrls';
  static const String allCustomSoundUrls = 'allCustomSoundUrls';
  static const String allCustomSelectedSoundUrls = 'allCustomSelectedSoundUrls';
  static const String allCustomSelectedSoundNames = 'allCustomSelectedSoundNames';
  static const String allCustomSelectedSoundImages = 'allCustomSelectedSoundImages';
}

Map<int, Color> appPrimaryColors = {
  50: Color.fromRGBO(0, 217, 254, .1),
  100: Color.fromRGBO(0, 217, 254, .2),
  200: Color.fromRGBO(0, 217, 254, .3),
  300: Color.fromRGBO(0, 217, 254, .4),
  400: Color.fromRGBO(0, 217, 254, .5),
  500: Color.fromRGBO(0, 217, 254, .6),
  600: Color.fromRGBO(0, 217, 254, .7),
  700: Color.fromRGBO(0, 217, 254, .8),
  800: Color.fromRGBO(0, 217, 254, .9),
  900: Color.fromRGBO(0, 217, 254, 1)
};

MaterialColor appPrimaryMaterialColor =
MaterialColor(0xFF00D9FE, appPrimaryColors);
