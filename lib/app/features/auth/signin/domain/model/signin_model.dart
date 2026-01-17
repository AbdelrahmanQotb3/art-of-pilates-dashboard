class SigninModel {
  final String? message;
  final String? token;
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? role;

  SigninModel({
    this.token,
    this.message,
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
  });

  SigninModel copyWith({
    String? message,
    String? token,
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
  }) {
    return SigninModel(
      message: message ?? this.message,
      token: token ?? this.token,
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
    );
  }
}
