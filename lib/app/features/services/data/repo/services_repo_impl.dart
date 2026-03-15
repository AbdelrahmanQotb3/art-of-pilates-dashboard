import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/services/data/data_sources/services_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/services/data/model/add_service_response.dart';
import 'package:pilates_dashboard/app/features/services/data/model/delete_service_response.dart';
import 'package:pilates_dashboard/app/features/services/data/model/service_response.dart';
import 'package:pilates_dashboard/app/features/services/data/model/services_response.dart';
import 'package:pilates_dashboard/app/features/services/domain/model/delete_service_model.dart';
import 'package:pilates_dashboard/app/features/services/domain/model/services_model.dart';
import 'package:pilates_dashboard/app/features/services/domain/repo/services_repo_contract.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/sessions_model.dart';

@Injectable(as: ServicesRepoContract)
class ServicesRepoImpl implements ServicesRepoContract {
  final ServicesDataSourceContract servicesDataSourceContract;

  ServicesRepoImpl(this.servicesDataSourceContract);

  @override
  Future<BaseResponse<ServicesModel>> getServices() async {
    final response = await servicesDataSourceContract.getServices();
    switch (response) {
      case SuccessResponse<ServicesResponse>():
        final List<ServiceEntity> services = (response.data.services ?? []).map((e) {
          return ServiceEntity(
            id: e.id,
            name: e.name,
            imageUrl: e.imageUrl,
            price: e.price,
            currency: e.currency,
            isVisible: e.isVisible,
            index: e.index,
            createdAt: e.createdAt,
            updatedAt: e.updatedAt,
            sessions: e.sessions?.map((s) {
              return SessionEntity(
                id: s.id,
                startTime: s.startTime,
                endTime: s.endTime,
                serviceId: s.serviceId,
                staffMemberId: s.staffMemberId,
                serviceName: s.service?.name,
                staffName: s.staffMember?.name,
              );
            }).toList(),
          );
        }).toList();
        return SuccessResponse<ServicesModel>(data: ServicesModel(services: services));
      case ErrorResponse<ServicesResponse>():
        return ErrorResponse<ServicesModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<ServiceEntity>> getOneService(String id) async {
    final response = await servicesDataSourceContract.getOneService(id);
    switch (response) {
      case SuccessResponse<ServiceResponse>():
        final s = response.data.service;
        if (s == null) {        }

        final ServiceEntity service = ServiceEntity(
          id: s!.id,
          name: s.name,
          imageUrl: s.imageUrl,
          price: s.price,
          currency: s.currency,
          isVisible: s.isVisible,
          index: s.index,
          createdAt: s.createdAt,
          updatedAt: s.updatedAt,
          location: s.location,
          bookingPolicy: s.bookingPolicy,
          bufferTime: s.bufferTime,
          paymentType: s.paymentType,
          paymentPriceType: s.paymentPriceType,
          paymentAmount: s.paymentAmount,
          paymentPref: s.paymentPref,
          sessions: s.sessions?.map((sess) => SessionEntity(
            id: sess.id,
            startTime: sess.startTime,
            endTime: sess.endTime,
            serviceId: sess.serviceId,
            staffMemberId: sess.staffMemberId,
            serviceName: sess.service?.name,
            staffName: sess.staffMember?.name,
          )).toList(),
        );
        return SuccessResponse<ServiceEntity>(data: service);
      case ErrorResponse<ServiceResponse>():
        return ErrorResponse<ServiceEntity>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<ServiceEntity>> addService({
    required String name,
    required String price,
    required String currency,
    String? imageUrl,
    bool? isVisible = true,
    int? index,
    DateTime? bufferTime,
    String? paymentType,
    String? paymentPriceType,
    double? paymentAmount,
    String? paymentPref,
    String? location,
    String? bookingPolicy,
  }) async {
    final response = await servicesDataSourceContract.addService(
      name: name,
      price: price,
      currency: currency,
      imageUrl: imageUrl,
      visibility: isVisible,
      index: index,
      bufferTime: bufferTime,
      paymentType: paymentType,
      paymentPriceType: paymentPriceType,
      paymentAmount: paymentAmount,
      paymentPref: paymentPref,
      location: location,
      bookingPolicy: bookingPolicy,
    );
    return _handleServiceResponse(response);
  }

  @override
  Future<BaseResponse<ServiceEntity>> updateService({
    required String id,
    String? name,
    int? price,
    String? currency,
    String? imageUrl,
    bool? isVisible,
    int? index,
    DateTime? bufferTime,
    String? paymentType,
    String? paymentPriceType,
    double? paymentAmount,
    String? paymentPref,
    String? location,
    String? bookingPolicy,
  }) async {
    final response = await servicesDataSourceContract.updateService(
      id: id,
      name: name,
      price: price,
      currency: currency,
      imageUrl: imageUrl,
      visibility: isVisible,
      index: index,
      paymentType: paymentType,
      paymentPref: paymentPref,
      bookingPolicy: bookingPolicy,
      location: location,
      paymentPriceType: paymentPriceType,
      paymentAmount: paymentAmount,
    );
    return _handleServiceResponse(response);
  }

  @override
  Future<BaseResponse<DeleteServiceModel>> deleteService(String id) async {
    final response = await servicesDataSourceContract.deleteService(id);
    switch (response) {
      case SuccessResponse<DeleteServiceResponse>():
        return SuccessResponse<DeleteServiceModel>(
          data: DeleteServiceModel(
            message: response.data.message,
            status: response.data.status,
          ),
        );
      case ErrorResponse<DeleteServiceResponse>():
        return ErrorResponse<DeleteServiceModel>(error: response.error);
    }
  }

  /// Helper to map common ServiceResponse to ServiceEntity
  BaseResponse<ServiceEntity> _handleServiceResponse(BaseResponse<dynamic> response) {
    if (response is SuccessResponse) {
      final s = response.data is AddServiceResponse 
          ? (response.data as AddServiceResponse).service 
          : (response.data as ServiceResponse).service;
    
      return SuccessResponse<ServiceEntity>(
        data: ServiceEntity(
          id: s!.id,
          name: s.name,
          imageUrl: s.imageUrl,
          price: s.price,
          currency: s.currency,
          isVisible: s.isVisible,
          index: s.index,
          createdAt: s.createdAt,
          updatedAt: s.updatedAt,
          location: s.location,
          bookingPolicy: s.bookingPolicy,
          bufferTime: s.bufferTime,
          paymentType: s.paymentType,
          paymentPriceType: s.paymentPriceType,
          paymentAmount: s.paymentAmount,
          paymentPref: s.paymentPref,
          sessions: s.sessions?.map((sess) => SessionEntity(
            id: sess.id,
            startTime: sess.startTime,
            endTime: sess.endTime,
            serviceId: sess.serviceId,
            staffMemberId: sess.staffMemberId,
            serviceName: sess.service?.name,
            staffName: sess.staffMember?.name,
          )).toList(),
        ),
      );
    }
    return ErrorResponse<ServiceEntity>(error: (response as ErrorResponse).error);
  }
}