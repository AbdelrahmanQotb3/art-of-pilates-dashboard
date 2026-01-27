class DeleteStaffMemberModel {
  String? message;
  String? status;

  DeleteStaffMemberModel({this.message, this.status});

  DeleteStaffMemberModel copyWith({String? message, String? status}) {
    return DeleteStaffMemberModel(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
