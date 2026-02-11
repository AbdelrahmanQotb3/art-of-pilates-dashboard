class DeleteServiceModel {
  String? message;
  String? status;

  DeleteServiceModel({this.message, this.status});

  DeleteServiceModel copyWith({String? message, String? status}) {
    return DeleteServiceModel(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
