class User {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final DateTime dateOfBirth;
  final String gender;
  final String? bpjsNumber;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.dateOfBirth,
    required this.gender,
    this.bpjsNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      bpjsNumber: json['bpjsNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'bpjsNumber': bpjsNumber,
    };
  }
}
