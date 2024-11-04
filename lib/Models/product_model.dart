import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String name;
  String category;
  String subcategory;
  double weight;
  String description;
  int stockAvailability;
  double price;
  double discount;
  double shippingCharges;
  List<File> images; // List of additional images
  File primaryImage; // Primary image, required
  bool warranty;
  bool returnRefundable;
  bool publish;
  DateTime listingDate; // New field for the listing date

  ProductModel({
    required this.name,
    required this.category,
    required this.subcategory,
    required this.weight,
    required this.description,
    required this.stockAvailability,
    required this.price,
    required this.discount,
    required this.shippingCharges,
    required this.primaryImage,
    this.images = const [],
    this.warranty = false,
    this.returnRefundable = false,
    this.publish = false,
    DateTime? listingDate, // Allow optional date input, defaults to current time
  }) : listingDate = listingDate ?? DateTime.now();

  // Converts ProductModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'subcategory': subcategory,
      'weight': weight,
      'description': description,
      'stockAvailability': stockAvailability,
      'price': price,
      'discount': discount,
      'shippingCharges': shippingCharges,
      'primaryImage': primaryImage.path, // Storing the file path for simplicity
      'images': images.map((file) => file.path).toList(), // Convert each file to its path
      'warranty': warranty,
      'returnRefundable': returnRefundable,
      'publish': publish,
      'listingDate': Timestamp.fromDate(listingDate), // Convert DateTime to Firestore Timestamp
    };
  }

  // Creates a ProductModel from a Map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'],
      category: map['category'],
      subcategory: map['subcategory'],
      weight: map['weight'],
      description: map['description'],
      stockAvailability: map['stockAvailability'],
      price: map['price'],
      discount: map['discount'],
      shippingCharges: map['shippingCharges'],
      primaryImage: File(map['primaryImage']), // Creating a File instance from the path
      images: (map['images'] as List<dynamic>).map((path) => File(path)).toList(), // Convert paths to File objects
      warranty: map['warranty'] ?? false,
      returnRefundable: map['returnRefundable'] ?? false,
      publish: map['publish'] ?? false,
      listingDate: (map['listingDate'] as Timestamp).toDate(), // Convert Firestore Timestamp to DateTime
    );
  }
}
