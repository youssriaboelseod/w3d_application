class CartModel {
  String productId;
  int quantity;
  int colorIndex;
  String paperSize;
  int paperQuantity;
  String itemDocumentId;

  CartModel({
    this.colorIndex,
    this.paperQuantity,
    this.paperSize,
    this.productId,
    this.quantity,
    this.itemDocumentId,
  });

  Map<String, dynamic> toAppDatabase() {
    return {
      "productId": productId,
      "quantity": quantity,
      "colorIndex": colorIndex,
      "paperSize": paperSize,
      "paperQuantity": paperQuantity,
      "itemDocumentId": itemDocumentId,
    };
  }

  Map<String, dynamic> toFirebase() {
    return {
      "productId": productId,
      "quantity": quantity,
      "colorIndex": colorIndex,
      "paperSize": paperSize,
      "paperQuantity": paperQuantity,
      "itemDocumentId": "",
    };
  }

  factory CartModel.fromFirebase({Map<String, dynamic> map}) {
    return CartModel(
      colorIndex: int.parse(map["colorIndex"].toString()),
      paperQuantity: int.parse(map["paperQuantity"].toString()),
      paperSize: map["paperSize"],
      productId: map["productId"],
      quantity: int.parse(map["quantity"].toString()),
      itemDocumentId: map["itemDocumentId"],
    );
  }
  factory CartModel.fromAppDatabase({Map<String, dynamic> map}) {
    return CartModel(
      colorIndex: map["colorIndex"],
      paperQuantity: map["paperQuantity"],
      paperSize: map["paperSize"],
      productId: map["productId"],
      quantity: map["quantity"],
      itemDocumentId: map["itemDocumentId"],
    );
  }
}
