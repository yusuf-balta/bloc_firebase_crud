import 'dart:convert';

class ProductModel {
  String uuid;
  String productId;
  String productCode;
  String productName;
  String productPrice;
  ProductModel({
    required this.uuid,
    required this.productId,
    required this.productCode,
    required this.productName,
    required this.productPrice,
  });

  ProductModel copyWith({
    String? uuid,
    String? productId,
    String? productCode,
    String? productName,
    String? productPrice,
  }) {
    return ProductModel(
      uuid: uuid ?? this.uuid,
      productId: productId ?? this.productId,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'productId': productId,
      'productCode': productCode,
      'productName': productName,
      'productPrice': productPrice,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      uuid: map['uuid'] ?? '',
      productId: map['productId'] ?? '',
      productCode: map['productCode'] ?? '',
      productName: map['productName'] ?? '',
      productPrice: map['productPrice'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(uuid: $uuid, productId: $productId, productCode: $productCode, productName: $productName, productPrice: $productPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.uuid == uuid &&
        other.productId == productId &&
        other.productCode == productCode &&
        other.productName == productName &&
        other.productPrice == productPrice;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        productId.hashCode ^
        productCode.hashCode ^
        productName.hashCode ^
        productPrice.hashCode;
  }
}
