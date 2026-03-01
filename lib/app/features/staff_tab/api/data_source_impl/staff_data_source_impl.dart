import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/api/api_client/staff_api_client.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/data_source/staff_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/add_staff_member_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/delete_staff_memeber_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/staff_member_resposne.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/staff_members_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/update_staff_member_response.dart';

@Injectable(as: StaffDataSourceContract)
class StaffDataSourceImpl implements StaffDataSourceContract {
  StaffApiClient apiClient;
  StaffDataSourceImpl(this.apiClient);

  @override
  Future<BaseResponse<StaffMembersResponse>> getStaffMembers() async {
    try {
      final response = await apiClient.getStaffMembers();
      return SuccessResponse<StaffMembersResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<StaffMembersResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<StaffMemberResponse>> getStaffMember(int id) async {
    try {
      final response = await apiClient.getStaffMember(id);
      return SuccessResponse<StaffMemberResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<StaffMemberResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<AddStaffMemberResponse>> addStaffMember(
    String name,
    String email,
    String? phone,
    String customAcion,
    bool? visibility,
  ) async {
    try {
      final response = await apiClient.addStaffMember({
        "name": name,
        "email": email,
        "phone": phone,
        "customAction": customAcion,
        "visibility": visibility,
      });
      return SuccessResponse<AddStaffMemberResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<AddStaffMemberResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<DeleteStaffMemberResponse>> deleteStaffMember(
    int index,
    String id,
  ) async {
    try {
      final response = await apiClient.deleteStaffMember(index, id);
      return SuccessResponse<DeleteStaffMemberResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<DeleteStaffMemberResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<UpdateStaffMemberResponse>> updateStaffMember(
    int index,
    String? name,
    String? email,
    String? phone,
    String? customAction,
    bool? visibility,
  ) async {
    try {
      final response = await apiClient.updateStaffMember(index, {
        "name": name,
        "email": email,
        "phone": phone,
        "customAction": customAction,
        "visibility": visibility,
      });
      return SuccessResponse<UpdateStaffMemberResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<UpdateStaffMemberResponse>(error: e);
    }
  }
}
