class ServicesModel {
  String? message;
  List<ServiceEntity>? services;

  ServicesModel({this.message, this.services});

  ServicesModel copyWith({String? message, List<ServiceEntity>? services}) {
    return ServicesModel(
      message: message ?? this.message,
      services: services ?? this.services,
    );
  }
}

class ServiceEntity {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? imageUrl;
  int? price;
  String? currency;
  bool? isVisible;
  int? index;

  ServiceEntity({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.imageUrl,
    this.price,
    this.currency,
    this.isVisible,
    this.index,
  });

  ServiceEntity copyWith({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? name,
    String? imageUrl,
    int? price,
    String? currency,
    bool? isVisible,
    int? index,
  }) {
    return ServiceEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      isVisible: isVisible ?? this.isVisible,
      index: index ?? this.index,
    );
  }
}
