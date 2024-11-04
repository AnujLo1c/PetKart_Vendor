import 'package:get/get.dart';
import 'package:petkart_vendor/Models/tile_models.dart';

class AllProductController extends GetxController {
  var productList = <ProductModel>[].obs;

  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() {
    productList.assignAll([
      ProductModel(
        name: 'Pedigry',
        category: 'Food',
        price: 3000,
        publishDate: '10/10/2024',
        imageUrl: 'https://placekitten.com/80/80',
      ),

    ]);
  }


  List<ProductModel> get filteredProducts {
    if (searchQuery.isEmpty) {
      return productList;
    } else {
      return productList
          .where((product) => product.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  void toggleStatus(int index) {
    productList[index].status = !productList[index].status;
    productList.refresh();
  }

  void deleteProduct(int index) {
    productList.removeAt(index);
  }
}
