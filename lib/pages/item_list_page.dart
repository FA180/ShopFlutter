import 'package:dono/constants/loader.dart';
import 'package:dono/constants/singe_product.dart';
import 'package:dono/models/product.dart';
import 'package:dono/pages/add_product_screen.dart';
import 'package:dono/pages/edit_item_page.dart';
import 'package:dono/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

/*
  void navigateToEditProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context, ) => AddProductScreen(
          products: product,
          onSave: (updatedProduct) {
            setState(() {
              // Update the product in the list
              int index = products!.indexOf(product);
              products![index] = updatedProduct;
            });
          },
        ),
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 240, 239, 239),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: ListView.builder(
                    itemCount: products!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == products!.length) {
                        return const SizedBox(height: 3);
                      }
                      final productData = products![index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              spreadRadius: 1,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.all(16.0),
                              title: Text(productData.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Price: ${productData.price} BHD'),
                                  Text('Size: ${productData.size}'),
                                  Text('Quantity: ${productData.quantity}'),
                                  if (productData.description != null &&
                                      productData.description.isNotEmpty)
                                    Text(
                                        'Description: ${productData.description}'),
                                ],
                              ),
                              leading: productData.images != null &&
                                      productData.images.isNotEmpty
                                  ? Image.network(
                                      productData.images[0],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors.grey,
                                      child: const Icon(Icons.image),
                                    ),
                            ),
                            Positioned(
                              top: 3,
                              right: 3,
                              child: IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.edit,
                                  size: 21,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/edit_item_page');
                                },
                              ),
                            ),
                            Positioned(
                              top: 3,
                              right: 40,
                              child: IconButton(
                                onPressed: () =>
                                    deleteProduct(productData, index),
                                icon: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color.fromARGB(255, 196, 194, 194),
                        width: 1,
                      ),
                    ),
                    child: FloatingActionButton(
                      onPressed: navigateToAddProduct,
                      backgroundColor: const Color.fromARGB(255, 45, 195, 137),
                      elevation: 1,
                      shape: const CircleBorder(),
                      child: const FaIcon(
                        FontAwesomeIcons.add,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
