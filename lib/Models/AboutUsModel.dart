class AboutUsModel {
  String? success;
  List<AboutUs>? about_us;

  AboutUsModel({
    this.success,
    this.about_us,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      success: json['success'] as String,
      about_us: json['about_us']
          .map<AboutUs>((item) => AboutUs.fromJson(item))
          .toList(),
    );
  }
}

class AboutUs {
  int? id;
  String? content_data;

  AboutUs({this.id, this.content_data});

  factory AboutUs.fromJson(Map<String, dynamic> json) {
    return AboutUs(
      id: json['id'] as int,
      content_data: json['content_data'] as String,
    );
  }
}
