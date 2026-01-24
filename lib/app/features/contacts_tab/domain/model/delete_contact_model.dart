class DeleteContactModel {
  String? message;
  String? status;

  DeleteContactModel({this.message, this.status});

  DeleteContactModel copyWith({String? message, String? status}) {
    return DeleteContactModel(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
