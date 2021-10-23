class AllSoundDataModel {
  String? success;
  List<AllSoundData>? sound;

  AllSoundDataModel({this.success, this.sound});

  factory AllSoundDataModel.fromJson(Map<String, dynamic> json) {
    return AllSoundDataModel(
      success: json['success'] as String,
      sound: json['sound']
          .map<AllSoundData>((item) => AllSoundData.fromJson(item))
          .toList(),
    );
  }
}

class AllSoundData {
  String? cat_id;
  List<Sound>? list_sound;

  AllSoundData({this.cat_id, this.list_sound});

  factory AllSoundData.fromJson(Map<String, dynamic> json) {
    return AllSoundData(
      cat_id: json['cat_id'] as String,
      list_sound: json['list_sound']
          .map<Sound>((item) => Sound.fromJson(item))
          .toList(),
    );
  }
}

class Sound {
  int? id;
  String? cat_id;
  String? name;
  String? sound_image;
  String? sound_file;
  String? created_at;
  String? updated_at;
  String? is_deleted;

  Sound({
    this.id,
    this.cat_id,
    this.name,
    this.sound_image,
    this.sound_file,
    this.created_at,
    this.updated_at,
    this.is_deleted,
  });

  factory Sound.fromJson(Map<String, dynamic> json) {
    return Sound(
      id: json['id'] as int,
      cat_id: json['cat_id'] as String,
      name: json['name'] as String,
      sound_image: json['sound_image'] as String,
      sound_file: json['sound_file'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      is_deleted: json['is_deleted'] as String,
    );
  }
}
