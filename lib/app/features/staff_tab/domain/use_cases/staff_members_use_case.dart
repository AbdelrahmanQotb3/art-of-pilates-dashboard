import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/model/delete_staff_member_model.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/model/staff_members_model.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/repo/staff_members_repo_contract.dart';

@injectable
class StaffMembersUseCase {
  StaffMembersRepoContract staffMembersRepoContract;
  StaffMembersUseCase(this.staffMembersRepoContract);

  Future<BaseResponse<StaffMembersModel>> getStaffMembers() async {
    return await staffMembersRepoContract.getStaffMembers();
  }

  Future<BaseResponse<StaffMemberEntity>> getStaffMember(int id) async {
    return await staffMembersRepoContract.getStaffMember(id);
  }

  Future<BaseResponse<StaffMemberEntity>> addStaffMember(
    String name,
    String email,
    String? phone,
    String customAction,
    bool? visibility,
  ) async {
    return await staffMembersRepoContract.addStaffMember(
      name,
      email,
      phone,
      customAction,
      visibility,
    );
  }

  Future<BaseResponse<DeleteStaffMemberModel>> deleteStaffMember(
    int index,
    String id,
  ) async {
    return await staffMembersRepoContract.deleteStaffMember(index, id);
  }

  Future<BaseResponse<StaffMemberEntity>> updateStaffMember(
    int index,
    String? name,
    String? email,
    String? phone,
    String? customAction,
    bool? visibility,
  ) async {
    return await staffMembersRepoContract.updateStaffMember(
      index,
      name,
      email,
      phone,
      customAction,
      visibility,
    );
  }
}
