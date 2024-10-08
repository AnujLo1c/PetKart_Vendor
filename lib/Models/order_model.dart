class OrderModel {
  final String id;
  final String date;
  final String customerName;
  final String deliveryStatus;
  final String imageUrl;
  final int price;

  OrderModel({
    required this.id,
    required this.date,
    required this.customerName,
    required this.deliveryStatus,
    required this.imageUrl,
    required this.price,
  });
}
