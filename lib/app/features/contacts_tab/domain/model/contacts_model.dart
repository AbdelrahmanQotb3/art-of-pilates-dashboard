class ContactsModel {
  final List<ContactEntity> contacts;
  ContactsModel({required this.contacts});
  ContactsModel copyWith({List<ContactEntity>? contacts}) {
    return ContactsModel(contacts: contacts ?? this.contacts);
  }
}

class ContactEntity {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? addressCity;
  final String? addressCountry;

  ContactEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.addressCity,
    this.addressCountry,
  });

  ContactEntity copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? addressCity,
    String? addressCountry,
  }) {
    return ContactEntity(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addressCity: addressCity ?? this.addressCity,
      addressCountry: addressCountry ?? this.addressCountry,
    );
  }
}
