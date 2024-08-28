import 'dart:convert';

class User {
  final String id;
  final String name;
  final String crNumber;
  final String email;
  final String password;
  final String phoneNumber;
  final bool status;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.crNumber,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.status,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id, // MongoDB typically uses "_id" for the ID field
      'name': name,
      'crNumber': crNumber, // Consistent with JSON keys
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'status': status,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '', // Ensure default values
      name: map['name'] ?? '',
      crNumber: map['crNumber'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      status: map['status'] ?? false,
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? crNumber,
    String? email,
    String? password,
    String? phoneNumber,
    bool? status,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      crNumber: crNumber ?? this.crNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      token: token ?? this.token,
    );
  }
}
