class DeleteClassModel {
  String? message;
  String? status;

  DeleteClassModel({this.message, this.status});

  DeleteClassModel copyWith({String? message, String? status}) {
    return DeleteClassModel(message: message ?? this.message, status: status ?? this.status);
  }
}
