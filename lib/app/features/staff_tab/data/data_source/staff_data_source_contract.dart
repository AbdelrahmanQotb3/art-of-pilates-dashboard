import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/add_staff_member_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/delete_staff_memeber_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/staff_member_resposne.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/staff_members_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/update_staff_member_response.dart';

abstract class StaffDataSourceContract {
  Future<BaseResponse<StaffMembersResponse>> getStaffMembers();

  Future<BaseResponse<StaffMemberResponse>> getStaffMember(int id);

  Future<BaseResponse<AddStaffMemberResponse>> addStaffMember(
    String name,
    String email,
    String? phone,
    String customAction,
    bool? visibility,
  );

  Future<BaseResponse<DeleteStaffMemberResponse>> deleteStaffMember(
    int index,
    String id,
  );

  Future<BaseResponse<UpdateStaffMemberResponse>> updateStaffMember(
    int index,
    String? name,
    String? email,
    String? phone,
    String? customAction,
    bool? visibility,
  );
}
