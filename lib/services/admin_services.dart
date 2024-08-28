import 'dart:io';

import 'package:dono/constants/utils.dart';
import 'package:dono/models/product.dart';
import 'package:dono/providers/shop_ownerprovider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Assuming you have this provider
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminServices {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required String size,
    required double price,
    required int quantity,
    required String category,
    required String shopName,
    required List<File> images,
  }) async {
    final shopOwnerProvider =
        Provider.of<ShopOwnerProvider>(context, listen: false);

    try {
      List<String> imageUrls = [];

      // Upload images to Firebase Storage
      for (int i = 0; i < images.length; i++) {
        String fileName = '${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
        Reference ref =
            FirebaseStorage.instance.ref().child('products/$name/$fileName');
        UploadTask uploadTask = ref.putFile(images[i]);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      }

      // Create a Product object
      Product product = Product(
        name: name,
        description: description,
        size: size,
        quantity: quantity,
        price: price,
        images: imageUrls,
        category: category,
        shopName: shopName,
        shopOwnerId: shopOwnerProvider.shopOwner!.id,
      );

      // Reference to Firebase Realtime Database
      DatabaseReference productRef =
          FirebaseDatabase.instance.ref('products').push();
      await productRef.set(product.toMap());

      showSnackBar(context, "Product Added Successfully");
      Navigator.pop(context);
    } catch (e) {
      showSnackBar(context, "Failed to add product: $e");
      print("Error adding product: $e"); // Log the error for debugging
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    List<Product> productList = [];
    try {
      DatabaseEvent event = await database.ref('products').once();
      DataSnapshot snapshot = event.snapshot;

      Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;

      if (values != null) {
        values.forEach((key, value) {
          productList.add(Product.fromMap(Map<String, dynamic>.from(value)));
        });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<void> deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    try {
      await database.ref('products/${product.id}').remove();

      // Delete images from Firebase Storage
      for (String imageUrl in product.images) {
        await FirebaseStorage.instance.refFromURL(imageUrl).delete();
      }

      onSuccess();
      showSnackBar(context, "Product deleted successfully");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
