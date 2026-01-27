import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/core/utils/end_points.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/add_staff_member_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/delete_staff_memeber_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/staff_member_resposne.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/staff_members_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/update_staff_member_response.dart';
import 'package:retrofit/retrofit.dart';
part 'staff_api_client.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@injectable
abstract class StaffApiClient {
  @factoryMethod
  factory StaffApiClient(Dio dio) = _StaffApiClient;

  @GET(EndPoints.getStaffMembers)
  Future<StaffMemebersResponse> getStaffMembers();

  @GET(EndPoints.getStaffMember)
  Future<StaffMemberResponse> getStaffMember(@Query("index") int id);

  @POST(EndPoints.addStaffMember)
  Future<AddStaffMemberResponse> addStaffMember(
    @Body() Map<String, dynamic> body,
  );

  @DELETE(EndPoints.deleteStaffMember)
  Future<DeleteStaffMemberResponse> deleteStaffMember(
    @Query("index") int index,
    @Query("id") String id,
  );

  @PATCH(EndPoints.updateStaffMember)
  Future<UpdateStaffMemberResponse> updateStaffMember(
    @Query("index") int index,
    @Body() Map<String, dynamic> body,
  );
}
