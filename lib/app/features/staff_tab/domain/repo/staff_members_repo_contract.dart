import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/model/delete_staff_member_model.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/model/staff_members_model.dart';

abstract class StaffMembersRepoContract {
  Future<BaseResponse<StaffMembersModel>> getStaffMembers();
  Future<BaseResponse<StaffMemberEntity>> getStaffMember(int id);
  Future<BaseResponse<StaffMemberEntity>> addStaffMember(
    String name,
    String email,
    String? phone,
    String customAction,
    bool? visibility,
  );

  Future<BaseResponse<DeleteStaffMemberModel>> deleteStaffMember(
    int index,
    String id,
  );

  Future<BaseResponse<StaffMemberEntity>> updateStaffMember(
    int index,
    String? name,
    String? email,
    String? phone,
    String? customAction,
    bool? visibility,
  );
}
