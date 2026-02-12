class GetClassesModel {
  final List<ClassEntity> classes;
  final String? message;

  GetClassesModel({required this.classes, this.message});
}

class ClassEntity {
  final String id;
  final String name;
  final double? price;
  final String? description;
  final int? maxParticipations;
  final String? tagLine;
  final String? location;

  ClassEntity({
    required this.id,
    required this.name,
    this.price,
    this.description,
    this.maxParticipations,
    this.tagLine,
    this.location,
  });
}
