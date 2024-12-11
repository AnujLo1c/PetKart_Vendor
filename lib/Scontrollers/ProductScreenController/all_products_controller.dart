import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Models/tile_models.dart';

class AllProductController extends GetxController {
  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;

  // Filter criteria
  var searchQuery = ''.obs;
  var categoryFilter = ''.obs;
  var priceFilter = 0.0.obs;
  var startDateFilter = ''.obs;
  var endDateFilter = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      final querySnapshotf = await FirebaseFirestore.instance.collection('products').doc('Food').collection('Food').get();
      final querySnapshota = await FirebaseFirestore.instance.collection('products').doc('Accessories').collection('Accessories').get();
      final productList = querySnapshotf.docs.map((doc) {
        return Product.fromJson(doc.data());
      }).toList();
productList.addAll(querySnapshota.docs.map((doc) {
  return Product.fromJson(doc.data());
}).toList());
      products.assignAll(productList);
      filteredProducts.assignAll(productList);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e',backgroundColor: Colors.black);
    }
  }

  void applyFilters() {
    filteredProducts.assignAll(products.where((product) {
      bool matchesSearchQuery = product.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      bool matchesCategory = categoryFilter.value.isEmpty || product.category.toLowerCase().contains(categoryFilter.value.toLowerCase());
      bool matchesPrice = priceFilter.value == 0 || product.price <= priceFilter.value;
      bool matchesDate = (startDateFilter.value.isEmpty || product.publishDate.compareTo(startDateFilter.value) >= 0) &&
          (endDateFilter.value.isEmpty || product.publishDate.compareTo(endDateFilter.value) <= 0);

      return matchesSearchQuery && matchesCategory && matchesPrice && matchesDate;
    }).toList());
  }
}


class Product {
  String name;
  String category;
  String img;
  double price;
  String publishDate; // Store as string

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.img,
    required this.publishDate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Format date before storing as string
    Timestamp timestamp = json['date'] ?? Timestamp(0, 0);
    DateTime date = timestamp.toDate();

    // Format the DateTime to a string
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return Product(
      name: json['name'] ?? 'Unknown',
      category: json['category'] ?? 'Unknown',
      img: json['primaryImageUrl'] ?? 'Unknown',
      price: json['price']?.toDouble() ?? 0.0,
      publishDate: formattedDate,
    );
  }
}
