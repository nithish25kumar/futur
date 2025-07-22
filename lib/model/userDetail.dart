class UserDetails {
  final String firstName;
  final String lastName;
  final String email;
  final String birthday;
  final String mobile;
  final String province;
  final String city;
  final String addressLine1;
  final String addressLine2;
  final String postalCode;
  final String? photoUrl;

  UserDetails({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthday,
    required this.mobile,
    required this.province,
    required this.city,
    required this.addressLine1,
    required this.addressLine2,
    required this.postalCode,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'birthday': birthday,
      'mobile': mobile,
      'province': province,
      'city': city,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'postalCode': postalCode,
      'photoUrl': photoUrl,
    };
  }

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      birthday: json['birthday'] ?? '',
      mobile: json['mobile'] ?? '',
      province: json['province'] ?? '',
      city: json['city'] ?? '',
      addressLine1: json['addressLine1'] ?? '',
      addressLine2: json['addressLine2'] ?? '',
      postalCode: json['postalCode'] ?? '',
      photoUrl: json['photoUrl'],
    );
  }
}
