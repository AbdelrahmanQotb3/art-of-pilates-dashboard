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
    DateTime? bufferTime,
    String? paymentType,
    String? paymentPriceType,
    double? paymentAmount,
    String? paymentPref,
    String? location,
    String? bookingPolicy
  }) async {
    try {
      final respnse = await apiClient.addService({
        "name": name,
        "price": price,
        "currency": currency,
        "imageUrl": imageUrl,
        "visibility": visibility,
        "index": index,
        "bufferTime": bufferTime,
        "paymentType": paymentType,
        "paymentPriceType": paymentPriceType,
        "paymentAmount": paymentAmount,
        "paymentPref": paymentPref,
        "location": location,
        "bookingPolicy": bookingPolicy
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
  @override
Future<BaseResponse<ServiceResponse>> updateService({
  required String id,
  String? name,
  int? price,
  String? currency,
  String? imageUrl,
  bool? visibility,
  int? index,
  DateTime? bufferTime,
    String? paymentType,
    String? paymentPriceType,
    double? paymentAmount,
    String? paymentPref,
    String? location,
    String? bookingPolicy
}) async {
  try {
    // We create a map and only include non-null values to avoid 
    // accidentally overwriting DB data with nulls.
    final Map<String, dynamic> body = {
      if (name != null) "name": name,
      if (price != null) "price": price,
      if (currency != null) "currency": currency,
      if (imageUrl != null) "imageUrl": imageUrl,
      if (visibility != null) "isVisible": visibility, // Check if your API uses 'isVisible' or 'visibility'
      if (index != null) "index": index,
      if (paymentType != null) "paymentType": paymentType,
      if (paymentPref != null) "paymentPref": paymentPref,
      if (bookingPolicy != null) "bookingPolicy": bookingPolicy,
      if (location != null) "location": location,
      if (paymentPriceType != null) "paymentPriceType": paymentPriceType,
      if (paymentAmount != null) "paymentAmount": paymentAmount,
      // CRITICAL: Convert DateTime to ISO8601 String for the API
      if (bufferTime != null) "bufferTime": bufferTime.toIso8601String(),
    };

    final response = await apiClient.updateService(id, body);
    return SuccessResponse<ServiceResponse>(data: response);
  } on Exception catch (e) {
    return ErrorResponse<ServiceResponse>(error: e);
  }
}}
