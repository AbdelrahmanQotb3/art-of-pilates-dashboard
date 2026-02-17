class UserModel {
  int id;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  String? profileImage;

  UserModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.profileImage
  });

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? role,
    String? profileImage
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage
    );
  }
}
