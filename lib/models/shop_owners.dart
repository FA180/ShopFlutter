class ShopOwner {
  final String id;
  final String name;
  final String email;
  final String type;
  final String crNumber;
  final String phoneNumber;
  final bool status;

  ShopOwner({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.crNumber,
    required this.phoneNumber,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'type': type,
      'crNumber': crNumber,
      'phoneNumber': phoneNumber,
      'status': status,
    };
  }

  factory ShopOwner.fromMap(Map<String, dynamic> map) {
    return ShopOwner(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      type: map['type'] ?? '',
      crNumber: map['crNumber'] ?? '',
      phoneNumber: map['phoneNumber'],
      status: map['status'] ?? false,
    );
  }
}
