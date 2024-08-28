import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dono/constants/custom_button.dart';
import 'package:dono/constants/custom_textfield.dart';
import 'package:dono/constants/global_variables.dart';
import 'package:dono/constants/utils.dart';
import 'package:dono/services/admin_services.dart';
import 'edit_item_page.dart'; // Import the EditItemPage

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  List<File> images = [];

  final _addProductFormKey = GlobalKey<FormState>();
  final AdminServices adminServices = AdminServices();

  List<String> productCategories = [
    'Clothes',
    'Abayas',
    'Electronics',
    'Packaged Food',
    'Water'
  ];

  List<String> shopNames = [
    'Center-point',
    'Abayas',
    'Redtag',
    'Max',
  ];

  List<String> itemSize = [
    'S',
    'M',
    'L',
    'XL',
  ];

  String category = 'Clothes';
  String shop = 'Max';
  String size = 'S';

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        size: size,
        price: double.parse(priceController.text),
        quantity: int.parse(quantityController.text),
        category: category,
        shopName: shop,
        images: images,
      );

      showSnackBar(context, 'Product Added Successfully!');
      Navigator.pop(context, true);
    }
  }

  void selectedImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    sizeController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 195, 137),
        title: const Center(
          child: Center(
            child: Text(
              "Add Product",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Form(
                key: _addProductFormKey,
                child: Column(
                  children: [
                    images.isNotEmpty
                        ? CarouselSlider(
                            items: images.map(
                              (i) {
                                return Builder(
                                  builder: (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 200,
                            ),
                          )
                        : GestureDetector(
                            onTap: selectedImages,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.folder_open,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Select Product Image",
                                      style: TextStyle(
                                          color: Colors.grey.shade400),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      controller: productNameController,
                      hintText: "Product Name",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: descriptionController,
                      hintText: "Description",
                      maxLines: 7,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: priceController,
                      hintText: "Price",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: quantityController,
                      hintText: "Quantity",
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: category,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                        items: productCategories.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newVal) {
                          setState(() {
                            category = newVal!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: shop,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                        items: shopNames.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newVal) {
                          setState(() {
                            shop = newVal!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: size,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                        items: itemSize.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newVal) {
                          setState(() {
                            size = newVal!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: 'Add',
                      onTap: sellProduct,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
