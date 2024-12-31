class UserModel {
  String? username;
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? photoLink;

  UserModel(
      {this.username,
      this.fullName,
      this.email,
      this.phone,
      this.address,
      this.photoLink});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      fullName: json['fullName'],
      phone: json['phone'],
      address: json['address'],
      photoLink: json['photoLink'],
    );
  }
}
