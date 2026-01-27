class StaffMembersModel {
  String? message;
  List<StaffMemberEntity>? staffMembers;

  StaffMembersModel({this.message, this.staffMembers});

  StaffMembersModel copyWith({
    String? message,
    List<StaffMemberEntity>? staffMembers,
  }) {
    return StaffMembersModel(
      message: message ?? this.message,
      staffMembers: staffMembers ?? this.staffMembers,
    );
  }
}

class StaffMemberEntity {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? profilePic;
  final bool? visibility;
  final int? index;
  final String? customAction;

  StaffMemberEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profilePic,
    this.visibility,
    this.index,
    this.customAction,
  });

  StaffMemberEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profilePic,
    bool? visibility,
    int? index,
    String? customAction,
  }) {
    return StaffMemberEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePic: profilePic ?? this.profilePic,
      visibility: visibility ?? this.visibility,
      index: index ?? this.index,
      customAction: customAction ?? this.customAction,
    );
  }
}
