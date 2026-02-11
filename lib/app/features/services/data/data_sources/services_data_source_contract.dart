import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/services/data/model/add_service_response.dart';
import 'package:pilates_dashboard/app/features/services/data/model/delete_service_response.dart';
import 'package:pilates_dashboard/app/features/services/data/model/service_response.dart';
import 'package:pilates_dashboard/app/features/services/data/model/services_response.dart';

abstract class ServicesDataSourceContract {
  Future<BaseResponse<ServicesResponse>> getServices();
  Future<BaseResponse<ServiceResponse>> getOneService(String id);
  Future<BaseResponse<AddServiceResponse>> addService({
    required String name,
    required String price,
    required String currency,
    String? imageUrl,
    bool? visibility = true,
    int? index,
  });

  Future<BaseResponse<DeleteServiceResponse>> deleteService(String id);

  Future<BaseResponse<ServiceResponse>> updateService({
    required String id,
    String? name,
    int? price,
    String? currency,
    String? imageUrl,
    bool? visibility,
    int? index,
  });
}
