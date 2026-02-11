import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/services/domain/model/delete_service_model.dart';
import 'package:pilates_dashboard/app/features/services/domain/model/services_model.dart';

abstract class ServicesRepoContract {
  Future<BaseResponse<ServicesModel>> getServices();
  Future<BaseResponse<ServiceEntity>> getOneService(String id);
  Future<BaseResponse<ServiceEntity>> addService({
    required String name,
    required String price,
    required String currency,
    String? imageUrl,
    bool? isVisible = true,
    int? index,
  });

  Future<BaseResponse<DeleteServiceModel>> deleteService(String id);

  Future<BaseResponse<ServiceEntity>> updateService({
    required String id,
    String? name,
    int? price,
    String? currency,
    String? imageUrl,
    bool? isVisible,
    int? index,
  });
}
