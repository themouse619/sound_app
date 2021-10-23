class SoundDataModel {
  String? success;
  List<SoundData>? sound;

  SoundDataModel({
    this.success,
    this.sound,
  });

  factory SoundDataModel.fromJson(Map<String, dynamic> json) {
    return SoundDataModel(
      success: json['success'] as String,
      sound: json['sound']
          .map<SoundData>((item) => SoundData.fromJson(item))
          .toList(),
    );
  }
}

class SoundData {
  int? id;
  String? cat_id;
  String? name;
  String? sound_image;
  String? sound_file;
  String? created_at;
  String? updated_at;
  String? is_deleted;

  SoundData({
    this.id,
    this.cat_id,
    this.name,
    this.sound_image,
    this.sound_file,
    this.created_at,
    this.updated_at,
    this.is_deleted,
  });

  factory SoundData.fromJson(Map<String, dynamic> json) {
    return SoundData(
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
