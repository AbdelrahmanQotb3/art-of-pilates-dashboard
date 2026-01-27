import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/data_source/staff_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/add_staff_member_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/delete_staff_memeber_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/staff_member_resposne.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/staff_members_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/update_staff_member_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/model/delete_staff_member_model.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/model/staff_members_model.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/repo/staff_members_repo_contract.dart';

@Injectable(as: StaffMembersRepoContract)
class StaffMembersRepoImpl implements StaffMembersRepoContract {
  StaffDataSourceContract dataSource;
  StaffMembersRepoImpl(this.dataSource);

  @override
  Future<BaseResponse<StaffMembersModel>> getStaffMembers() async {
    final response = await dataSource.getStaffMembers();
    switch (response) {
      case SuccessResponse<StaffMemebersResponse>():
        final List<StaffMemberEntity> members = response.data.staffMembers!.map(
          (memberDto) {
            return StaffMemberEntity(
              id: memberDto.id!,
              name: memberDto.name,
              email: memberDto.email,
              index: memberDto.index,
              phone: memberDto.phone,
              profilePic: memberDto.profilePic,
              visibility: memberDto.visibility,
              customAction: memberDto.customAction,
            );
          },
        ).toList();
        final model = StaffMembersModel(staffMembers: members);
        return SuccessResponse<StaffMembersModel>(data: model);
      case ErrorResponse<StaffMemebersResponse>():
        return ErrorResponse<StaffMembersModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<StaffMemberEntity>> getStaffMember(int id) async {
    final response = await dataSource.getStaffMember(id);
    switch (response) {
      case SuccessResponse<StaffMemberResponse>():
        final StaffMemberEntity member = StaffMemberEntity(
          id: response.data.staffMember!.id!,
          name: response.data.staffMember!.name,
          email: response.data.staffMember!.email,
          index: response.data.staffMember!.index!,
          phone: response.data.staffMember!.phone,
          profilePic: response.data.staffMember!.profilePic,
          visibility: response.data.staffMember!.visibility,
          customAction: response.data.staffMember!.customAction,
        );
        return SuccessResponse<StaffMemberEntity>(data: member);
      case ErrorResponse<StaffMemberResponse>():
        return ErrorResponse<StaffMemberEntity>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<StaffMemberEntity>> addStaffMember(
    String name,
    String email,
    String? phone,
    String customAction,
    bool? visibility,
  ) async {
    final response = await dataSource.addStaffMember(
      name,
      email,
      phone,
      customAction,
      visibility,
    );
    switch (response) {
      case SuccessResponse<AddStaffMemberResponse>():
        if (response.data.staffMember == null) {
          return ErrorResponse<StaffMemberEntity>(
            error: Exception('Staff member response is null'),
          );
        }
        final StaffMemberEntity member = StaffMemberEntity(
          id: response.data.staffMember!.id,
          name: response.data.staffMember!.name,
          email: response.data.staffMember!.email,
          index: response.data.staffMember!.index,
          phone: response.data.staffMember!.phone,
          profilePic: response.data.staffMember!.profilePic,
          visibility: response.data.staffMember!.visibility,
          customAction: response.data.staffMember!.customAction,
        );
        return SuccessResponse<StaffMemberEntity>(data: member);
      case ErrorResponse<AddStaffMemberResponse>():
        return ErrorResponse<StaffMemberEntity>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<DeleteStaffMemberModel>> deleteStaffMember(
    int index,
    String id,
  ) async {
    final response = await dataSource.deleteStaffMember(index, id);
    switch (response) {
      case SuccessResponse<DeleteStaffMemberResponse>():
        final DeleteStaffMemberModel model = DeleteStaffMemberModel(
          message: response.data.message,
          status: response.data.status,
        );
        return SuccessResponse<DeleteStaffMemberModel>(data: model);
      case ErrorResponse<DeleteStaffMemberResponse>():
        return ErrorResponse<DeleteStaffMemberModel>(error: response.error);
    }
  }

  Future<BaseResponse<StaffMemberEntity>> updateStaffMember(
    int index,
    String? name,
    String? email,
    String? phone,
    String? customAction,
    bool? visibility,
  ) async{
    final response = await dataSource.updateStaffMember(index, name, email, phone, customAction, visibility);
    switch (response) {
      case SuccessResponse<UpdateStaffMemberResponse>():
        final StaffMemberEntity member = StaffMemberEntity(
          id: response.data.staffMember.id,
          name: response.data.staffMember.name,
          email: response.data.staffMember.email,
          index: response.data.staffMember.index,
          phone: response.data.staffMember.phone,
          profilePic: response.data.staffMember.profilePic,
          visibility: response.data.staffMember.visibility,
          customAction: response.data.staffMember.customAction,
        );
        return SuccessResponse<StaffMemberEntity>(data: member);
      case ErrorResponse<UpdateStaffMemberResponse>():
        return ErrorResponse<StaffMemberEntity>(error: response.error);
  }
  }
}
