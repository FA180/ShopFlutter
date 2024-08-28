import 'dart:convert';

class Product {
  final String? id;
  final String shopOwnerId;
  final String name;
  final String description;
  final String size;
  final int quantity;
  final List<String> images;
  final String category;
  final String shopName;
  final double price;

  Product({
    this.id,
    required this.shopOwnerId,
    required this.name,
    required this.description,
    required this.size,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    required this.shopName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopOwnerId': shopOwnerId,
      'name': name,
      'description': description,
      'size': size,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'shopName': shopName,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      shopOwnerId: map['shopOwnerId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      size: map['size']??'',
      quantity: map['quantity']?.toInt() ?? 0.0,
      images: List<String>.from(map['images'] ?? []),
      category: map['category'] ?? '',
      shopName: map['shopName'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
