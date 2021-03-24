class ProductModel {
  String id;
  String name;
  String code;
  String description;
  String categoryId;
  String subCategoryId;
  double priceSelling;
  double priceBuying;

  String imageMainUrl;
  String image1Url;
  String image2Url;

  String fixedColor;
  String fixedPaperSize;
  String fixedPaperQuantity;

  ProductModel({
    this.id,
    this.categoryId,
    this.name,
    this.code,
    this.priceBuying,
    this.priceSelling,
    this.description,
    this.imageMainUrl,
    this.image1Url,
    this.image2Url,
    this.subCategoryId,
    this.fixedColor,
    this.fixedPaperQuantity,
    this.fixedPaperSize,
  });

  Map<String, dynamic> productToMapWithId() {
    return {
      "id": id,
      "name": name,
      "code": code,
      "categoryId": categoryId,
      "priceBuying": priceBuying,
      "priceSelling": priceSelling,
      "description": description,
      "imageMainUrl": imageMainUrl,
      "image1Url": image1Url,
      "image2Url": image2Url,
      "subCategoryId": subCategoryId,
      "fixedColor": fixedColor,
      "fixedPaperQuantity": fixedPaperQuantity,
      "fixedPaperSize": fixedPaperSize,
    };
  }

  Map<String, dynamic> productToMapWithoutId() {
    return {
      "name": name,
      "code": code,
      "categoryId": categoryId,
      "priceSelling": priceSelling,
      "priceBuying": priceBuying,
      "description": description,
      "imageMainUrl": imageMainUrl,
      "image1Url": image1Url,
      "image2Url": image2Url,
      "subCategoryId": subCategoryId,
      "fixedColor": fixedColor,
      "fixedPaperQuantity": fixedPaperQuantity,
      "fixedPaperSize": fixedPaperSize,
    };
  }

  factory ProductModel.fromFirebase({Map<String, dynamic> map}) {
    return ProductModel(
      id: map["id"],
      categoryId: map["categoryId"],
      name: map["name"],
      code: map["code"],
      description: map["description"],
      priceBuying: double.parse(map["priceBuying"].toString()),
      priceSelling: double.parse(map["priceSelling"].toString()),
      imageMainUrl: map["imageMainUrl"],
      image1Url: map["image1Url"],
      image2Url: map["image2Url"],
      subCategoryId: map["subCategoryId"],
      fixedColor: map["fixedColor"],
      fixedPaperQuantity: map["fixedPaperQuantity"],
      fixedPaperSize: map["fixedPaperSize"],
    );
  }
  factory ProductModel.fromAppDatabase({Map<String, dynamic> map}) {
    return ProductModel(
      id: map["id"],
      categoryId: map["categoryId"],
      name: map["name"],
      code: map["code"],
      description: map["description"],
      priceBuying: map["priceBuying"],
      priceSelling: map["priceSelling"],
      imageMainUrl: map["imageMainUrl"],
      image1Url: map["image1Url"],
      image2Url: map["image2Url"],
      subCategoryId: map["subCategoryId"],
      fixedColor: map["fixedColor"],
      fixedPaperQuantity: map["fixedPaperQuantity"],
      fixedPaperSize: map["fixedPaperSize"],
    );
  }
}
