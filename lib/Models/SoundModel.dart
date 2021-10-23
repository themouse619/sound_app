class SoundModel {
  String? success;
  List<MenuCategory>? menucategory;

  SoundModel({
    this.success,
    this.menucategory,
  });

  factory SoundModel.fromJson(Map<String, dynamic> json) {
    return SoundModel(
      success: json['success'] as String,
      menucategory: json['menucategory']
          .map<MenuCategory>((item) => MenuCategory.fromJson(item))
          .toList(),
    );
  }
}

class MenuCategory {
  int? id;
  String? cat_name;
  String? cat_icon;
  String? created_at;
  String? updated_at;
  String? is_deleted;

  MenuCategory({
    this.id,
    this.cat_name,
    this.cat_icon,
    this.created_at,
    this.updated_at,
    this.is_deleted,
  });

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      id: json['id'] as int,
      cat_name: json['cat_name'] as String,
      cat_icon: json['cat_icon'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      is_deleted: json['is_deleted'] as String,
    );
  }
}
