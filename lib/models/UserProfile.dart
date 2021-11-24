class UserProfile {
  late String? id;
  late String? username;
  late String? email;
  late String? role;
  late String? firstName;
  late String? lastName;
  late String? address;
  late String? password;
  late String? phoneNumber;
  late String? profilePicture;
  late String? createdAt;
  late String? updateAt;

  UserProfile(
      {this.id,
      this.username,
      this.email,
      this.role,
      this.firstName,
      this.lastName,
      this.address,
      this.password,
      this.phoneNumber,
      this.profilePicture,
      this.createdAt,
      this.updateAt});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      createdAt: json['createdAt'],
      updateAt: json['updateAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['role'] = this.role;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['address'] = this.address;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['profilePicture'] = this.profilePicture;
    data['createdAt'] = this.createdAt;
    data['updateAt'] = this.updateAt;
    return data;
  }
}
