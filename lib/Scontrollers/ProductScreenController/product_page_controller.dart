import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:petkart_vendor/Firebase/FirebaseAuth/email_pass_login.dart';

class ProductPageController extends GetxController {
   final String vendorId=EmailPassLoginAl().getEmail();
  final int pageSize = 10; // Number of items per page

  // Observable variables for the product list, loading state, and pagination control
  var products = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  DocumentSnapshot? lastDocument;

  @override
  void onInit() {
    super.onInit();
    fetchProductList(); // Fetch initial data on controller init
  }

  // Fetch the product list with pagination
  Future<void> fetchProductList() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;

    try {
      // Step 1: Get the product list from the vendor document
      DocumentSnapshot vendorDoc = await FirebaseFirestore.instance
          .collection('vendorusers')
          .doc(vendorId)
          .get();

      if (vendorDoc.exists && vendorDoc.data() != null) {
        List<dynamic> productList = vendorDoc['productList'];

        // Step 2: Fetch products in chunks
        if (productList.isNotEmpty) {
          Query productQuery = FirebaseFirestore.instance
              .collection('products')
              .where(FieldPath.documentId, whereIn: productList)
              .limit(pageSize);

          // Apply pagination with `startAfterDocument`
          if (lastDocument != null) {
            productQuery = productQuery.startAfterDocument(lastDocument!);
          }

          QuerySnapshot productSnapshot = await productQuery.get();

          if (productSnapshot.docs.isNotEmpty) {
            // Update lastDocument for next pagination
            lastDocument = productSnapshot.docs.last;

            // Convert documents to map and add them to the products list
            List<Map<String, dynamic>> newProducts = productSnapshot.docs
                .map((doc) => doc.data() as Map<String, dynamic>)
                .toList();

            products.addAll(newProducts);
            hasMore.value = newProducts.length == pageSize;
          } else {
            hasMore.value = false; // No more products available
          }
        }
      }
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Method to load more data when reaching the bottom of the list
  void loadMore() {
    if (!isLoading.value && hasMore.value) {
      fetchProductList();
    }
  }

//implement it later
   Future<bool> deleteProduct(String docId) async {
    String vendorEmail=EmailPassLoginAl().getEmail();
    try {
       // Reference to Firestore
       final FirebaseFirestore firestore = FirebaseFirestore.instance;

       // Step 1: Delete the product document from the `products` collection
       await firestore.collection('products').doc(docId).delete();

       // Step 2: Remove the `docId` from the `productList` field in the vendor's document
       DocumentReference vendorDocRef = firestore.collection('vendorusers').doc(vendorEmail);

       await vendorDocRef.update({
         'productList': FieldValue.arrayRemove([docId]),
       });

       return true; // Return true if both operations succeeded
     } catch (e) {
       print("Error deleting product: $e");
       return false; // Return false if an error occurred
     }
   }

}
