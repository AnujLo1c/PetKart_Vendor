class PaymentHistory {
  final String accountNumber;
  final String holderName;
  final String bankName;
  final String date;
  final String orderId;

  PaymentHistory({
    required this.accountNumber,
    required this.holderName,
    required this.bankName,
    required this.date,
    required this.orderId,
  });
}

class ProductModel {
  final String name;
  final String category;
  final double price;
  final String publishDate;
  final String imageUrl;
  bool status;

  ProductModel({
    required this.name,
    required this.category,
    required this.price,
    required this.publishDate,
    required this.imageUrl,
    this.status = true,
  });
}
