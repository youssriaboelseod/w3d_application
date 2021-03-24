class CategoryModel {
  String id;
  String name;
  String imageUrl;
  String iconImageUrl;

  CategoryModel({
    this.id,
    this.name,
    this.imageUrl,
    this.iconImageUrl,
  });

  Map<String, dynamic> categoryToMapWithId() {
    return {
      "id": id,
      "name": name,
      "imageUrl": imageUrl,
      "iconImageUrl": iconImageUrl,
    };
  }

  Map<String, dynamic> categoryToMapWithoutId() {
    return {
      "name": name,
      "imageUrl": imageUrl,
      "iconImageUrl": iconImageUrl,
    };
  }

  factory CategoryModel.fromFirebase({Map<String, dynamic> map}) {
    return CategoryModel(
      id: map["id"],
      name: map["name"],
      imageUrl: map["imageUrl"],
      iconImageUrl: map["iconImageUrl"],
    );
  }
}
