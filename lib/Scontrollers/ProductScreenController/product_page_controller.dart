import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../Firebase/FirebaseAuth/email_pass_login.dart';

class ProductPageController extends GetxController {
  final String vendorId = EmailPassLoginAl().getEmail();
  final int pageSize = 6;

  var products = <Map<String, dynamic>>[].obs;
  var pets = <Map<String, dynamic>>[].obs; // For storing fetched pets
  var isLoadingProducts = false.obs;
  var isLoadingPets = false.obs;
  var hasMoreProducts = true.obs;
  var hasMorePets = true.obs;
  DocumentSnapshot? lastProductDocument;
  DocumentSnapshot? lastPetDocument;

  @override
  void onInit() {
    super.onInit();
    fetchProductList();
    fetchPetList(); // Fetch pets as well
  }

  // Fetch Products
  Future<void> fetchProductList() async {
    if (isLoadingProducts.value || !hasMoreProducts.value) return;

    isLoadingProducts.value = true;
    try {
      DocumentSnapshot vendorDoc = await FirebaseFirestore.instance
          .collection('vendorusers')
          .doc(vendorId)
          .get();

      if (vendorDoc.exists && vendorDoc.data() != null) {
        List<dynamic> productList = vendorDoc['productList'];

        if (productList.isNotEmpty) {
          Query productQuery = FirebaseFirestore.instance
              .collection('products')
              .where(FieldPath.documentId, whereIn: productList)
              .limit(pageSize);

          if (lastProductDocument != null) {
            productQuery = productQuery.startAfterDocument(lastProductDocument!);
          }

          QuerySnapshot productSnapshot = await productQuery.get();
          if (productSnapshot.docs.isNotEmpty) {
            lastProductDocument = productSnapshot.docs.last;
            List<Map<String, dynamic>> newProducts = productSnapshot.docs
                .map((doc) => doc.data() as Map<String, dynamic>)
                .toList();
            products.addAll(newProducts);
            hasMoreProducts.value = newProducts.length == pageSize;
          } else {
            hasMoreProducts.value = false;
          }
        }
      }
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoadingProducts.value = false;
    }
  }

  // Fetch Pets
  Future<void> fetchPetList() async {
    if (isLoadingPets.value || !hasMorePets.value) return;

    isLoadingPets.value = true;
    try {
      Query petQuery = FirebaseFirestore.instance
          .collection('pets')
          .where('vendorId', isEqualTo: vendorId)
          .orderBy('updatedAt', descending: true)
          .limit(pageSize);

      if (lastPetDocument != null) {
        petQuery = petQuery.startAfterDocument(lastPetDocument!);
      }

      QuerySnapshot petSnapshot = await petQuery.get();
      if (petSnapshot.docs.isNotEmpty) {
        lastPetDocument = petSnapshot.docs.last;
        List<Map<String, dynamic>> newPets = petSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        pets.addAll(newPets);
        hasMorePets.value = newPets.length == pageSize;
      } else {
        hasMorePets.value = false;
      }
    } catch (e) {
      print("Error fetching pets: $e");
    } finally {
      isLoadingPets.value = false;
    }
  }

  void loadMoreProducts() {
    if (!isLoadingProducts.value && hasMoreProducts.value) {
      fetchProductList();
    }
  }

  void loadMorePets() {
    if (!isLoadingPets.value && hasMorePets.value) {
      fetchPetList();
    }
  }
}
