class Customer {
  String customerName;
  String email;
  String? profileUrl; // Optional profileUrl
  String phoneNo;

  Customer({
    required this.customerName,
    required this.email,
    this.profileUrl, // Optional profileUrl
    required this.phoneNo, // Added phoneNo field

  });

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'email': email,
      'profileUrl': profileUrl, // Can be null
      'phoneNo': phoneNo, // Added phoneNo field
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      customerName: map['customerName'] ?? '',
      email: map['email'] ?? '',
      profileUrl: map['profileUrl'], // Can be null
      phoneNo: map['phoneNo'] ?? '', // Added phoneNo field
    );
  }
}
