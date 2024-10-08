class Customer{
  String customerName;
  String email;
  String profileUrl;

  Customer({
    required this.customerName,
    required this.email,
    required this.profileUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'email': email,
      'profileUrl': profileUrl,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      customerName: map['customerName'] ?? '',
      email: map['email'] ?? '',
      profileUrl: map['profileUrl'] ?? '',
    );
  }
}