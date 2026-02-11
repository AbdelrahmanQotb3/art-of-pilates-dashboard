import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/services/api/api_client/services_api_client.dart';
import 'package:pilates_dashboard/app/features/services/data/data_sources/services_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/services/data/model/add_service_response.dart';
import 'package:pilates_dashboard/app/features/services/data/model/delete_service_response.dart';
import 'package:pilates_dashboard/app/features/services/data/model/service_response.dart';
import 'package:pilates_dashboard/app/features/services/data/model/services_response.dart';

@Injectable(as: ServicesDataSourceContract)
class ServicesDataSourceImpl implements ServicesDataSourceContract {
  ServicesApiClient apiClient;

  ServicesDataSourceImpl(this.apiClient);

  @override
  Future<BaseResponse<ServicesResponse>> getServices() async {
    try {
      final response = await apiClient.getServices();
      return SuccessResponse<ServicesResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<ServicesResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<ServiceResponse>> getOneService(String id) async {
    try {
      final response = await apiClient.getOneService(id);
      return SuccessResponse<ServiceResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<ServiceResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<AddServiceResponse>> addService({
    required String name,
    required String price,
    required String currency,
    String? imageUrl,
    bool? visibility = true,
    int? index,
  }) async {
    try {
      final respnse = await apiClient.addService({
        "name": name,
        "price": price,
        "currency": currency,
        "imageUrl": imageUrl,
        "visibility": visibility,
        // "index": 6,
      });
      return SuccessResponse<AddServiceResponse>(data: respnse);
    } on Exception catch (e) {
      return ErrorResponse<AddServiceResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<DeleteServiceResponse>> deleteService(String id) async {
    try {
      final response = await apiClient.deleteService(id);
      return SuccessResponse<DeleteServiceResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<DeleteServiceResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<ServiceResponse>> updateService({
    required String id,
    String? name,
    int? price,
    String? currency,
    String? imageUrl,
    bool? visibility,
    int? index,
  }) async {
    try {
      final response = await apiClient.updateService(id, {
        "name": name,
        "price": price,
        "currency": currency,
        "imageUrl": imageUrl,
        "visibility": visibility,
        "index": index,
      });
      return SuccessResponse<ServiceResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<ServiceResponse>(error: e);
    }
  }
}
