import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petkart_vendor/Firebase/FirebaseAuth/email_pass_login.dart';
import 'package:petkart_vendor/Firebase/FirebaseFirestore/firestore_firebase.dart';

import '../../Models/product_model.dart';

class AddProductController extends GetxController {
  final productNameController = TextEditingController();
  final weightController = TextEditingController();
  final descriptionController = TextEditingController();
  final stockAvailabilityController = TextEditingController();
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final shippingChargesController = TextEditingController();
  final primaryImageController = TextEditingController();

  var warranty = false.obs;
  var returnRefundable = false.obs;
  var publish = false.obs;
  var selectedCategory = 'Food'.obs;
  var selectedSubcategory = ''.obs;

  List<String> categories = ['Food', 'Toys', 'Gears'];
  var subcategories = <String>[].obs;

  // List to store the paths of selected images
  var selectedImages = <String>[].obs;
  var primaryImage = Rx<File?>(null); // Change to hold a File object

  // Update the pickImage method to handle primary image
  Future<void> pickPrimaryImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      primaryImage.value = File(pickedFile.path); // Store the File object
    }
  }
  @override
  void onInit() {
    super.onInit();
    updateSubcategories(); // Initialize subcategories based on the default category
  }

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
    updateSubcategories();
  }

  void updateSubcategories() {
    if (selectedCategory.value == 'Food') {
      subcategories.value = ['Fruit', 'Vegetables'];
    } else if (selectedCategory.value == 'Toys') {
      subcategories.value = ['Educational', 'Soft'];
    } else {
      subcategories.value = ['Protective Gear', 'Tools'];
    }

    // Set selectedSubcategory to the first item in the new list if available
    selectedSubcategory.value = subcategories.isNotEmpty ? subcategories[0] : '';
  }

  Future<void> pickImage() async {
    if (selectedImages.length >= 5) {
      Get.snackbar("Limit Reached", "You can only select up to 5 images.");
      return;
    }

    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImages.add(pickedFile.path); // Add the selected image path to the list
    }
  }

  @override
  void onClose() {
    productNameController.dispose();
    weightController.dispose();
    descriptionController.dispose();
    stockAvailabilityController.dispose();
    priceController.dispose();
    discountController.dispose();
    shippingChargesController.dispose();
    primaryImageController.dispose();
    super.onClose();
  }
  Future<bool> uploadProduct() async {
    double weight = double.tryParse(weightController.text) ?? 0.0;
    int stockAvailability = int.tryParse(stockAvailabilityController.text) ?? 0;
    double price = double.tryParse(priceController.text) ?? 0.0;
    double discount = double.tryParse(discountController.text) ?? 0.0;
    double shippingCharges = double.tryParse(shippingChargesController.text) ?? 0.0;
    File? selectedPrimaryImage = primaryImage.value;
    ProductModel product=ProductModel(
      name: productNameController.text,
      category: selectedCategory.value,
      subcategory: selectedSubcategory.value,
      weight: weight,
      description: descriptionController.text,
      stockAvailability: stockAvailability,
      price: price,
      discount: discount,
      shippingCharges: shippingCharges,
      primaryImage: selectedPrimaryImage!, // Use the path if the file is selected
    );
    var vendorId=EmailPassLoginAl().getEmail();
    FirebaseFirestore firestore=FirebaseFirestore.instance;
    try {
      // Generate a unique document ID for the product
      String docId = firestore.collection('products').doc().id;

      // Upload primary image and additional images to Firebase Storage
      String primaryImageUrl = await _uploadFile(product.primaryImage, 'products/$docId/primary');
      List<String> imageUrls = await Future.wait(
        product.images.map((file) => _uploadFile(file, 'products/$docId/images/${file.path.split('/').last}')),
      );

      // Convert product to Map and add uploaded image URLs
      Map<String, dynamic> productData = product.toMap();
      productData['primaryImageUrl'] = primaryImageUrl;
      productData['imageUrls'] = imageUrls;
      productData['vendorId'] = vendorId;

      // Save product data to Firestore
      await firestore.collection('products').doc(docId).set(productData);
      await firestore.collection('products').doc(docId).update({'docId':docId});

      // Update vendor's product list with the new product ID
      await firestore.collection('vendorusers').doc(vendorId).update({
        'productList': FieldValue.arrayUnion([docId])
      });

      print("Product uploaded successfully with ID: $docId");
      return true;
    } catch (e) {
      print("Error uploading product: $e");

      return false;
    }
  }


  Future<String> _uploadFile(File file, String path) async {
    FirebaseStorage storage=FirebaseStorage.instance;
    UploadTask uploadTask = storage.ref().child(path).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

}
