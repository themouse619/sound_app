import 'dart:convert';

class StoreSound {
  List? listSoundData;

  StoreSound({this.listSoundData});

  factory StoreSound.fromJson(Map<String, dynamic> json) {
    return StoreSound(
      listSoundData: json['allSoundData'] as List,
    );
  }

  static Map<String, dynamic> toMap(StoreSound item) => {
        'allSoundData': item.listSoundData,
      };

  static String encode(List<StoreSound> items) => json.encode(
    items
        .map<Map<String, dynamic>>((item) => StoreSound.toMap(item))
        .toList(),
  );

  static List<StoreSound> decode(String items) =>
      (json.decode(items) as List<dynamic>)
          .map<StoreSound>((item) => StoreSound.fromJson(item))
          .toList();
}
