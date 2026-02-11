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

@Injectable(as: ServicesRepoContract)
class ServicesRepoImpl implements ServicesRepoContract {
  ServicesDataSourceContract servicesDataSourceContract;
  ServicesRepoImpl(this.servicesDataSourceContract);
  @override
  Future<BaseResponse<ServicesModel>> getServices() async {
    final response = await servicesDataSourceContract.getServices();
    switch (response) {
      case SuccessResponse<ServicesResponse>():
        final List<ServiceEntity> services = response.data.services!.map((e) {
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
          );
        }).toList();
        ServicesModel model = ServicesModel(services: services);
        return SuccessResponse<ServicesModel>(data: model);
      case ErrorResponse<ServicesResponse>():
        return ErrorResponse<ServicesModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<ServiceEntity>> getOneService(String id) async {
    final response = await servicesDataSourceContract.getOneService(id);
    switch (response) {
      case SuccessResponse<ServiceResponse>():
        final ServiceEntity service = ServiceEntity(
          id: response.data.service!.id,
          name: response.data.service!.name,
          imageUrl: response.data.service!.imageUrl,
          price: response.data.service!.price,
          currency: response.data.service!.currency,
          isVisible: response.data.service!.isVisible,
          index: response.data.service!.index,
          createdAt: response.data.service!.createdAt,
          updatedAt: response.data.service!.updatedAt,
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
  }) async {
    final response = await servicesDataSourceContract.addService(
      name: name,
      price: price,
      currency: currency,
      imageUrl: imageUrl,
      visibility: isVisible,
      index: index,
    );
    switch (response) {
      case SuccessResponse<AddServiceResponse>():
        final ServiceEntity service = ServiceEntity(
          id: response.data.service?.id,
          name: response.data.service?.name,
          imageUrl: response.data.service?.imageUrl,
          price: response.data.service?.price,
          currency: response.data.service?.currency,
          isVisible: response.data.service?.isVisible,
          index: response.data.service?.index,
          createdAt: response.data.service?.createdAt,
          updatedAt: response.data.service?.updatedAt,
        );
        return SuccessResponse<ServiceEntity>(data: service);
      case ErrorResponse<AddServiceResponse>():
        return ErrorResponse<ServiceEntity>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<DeleteServiceModel>> deleteService(String id) async {
    final response = await servicesDataSourceContract.deleteService(id);
    switch (response) {
      case SuccessResponse<DeleteServiceResponse>():
        final DeleteServiceModel model = DeleteServiceModel(
          message: response.data.message,
          status: response.data.status,
        );
        return SuccessResponse<DeleteServiceModel>(data: model);
      case ErrorResponse<DeleteServiceResponse>():
        return ErrorResponse<DeleteServiceModel>(error: response.error);
    }
  }
  
  @override
  Future<BaseResponse<ServiceEntity>> updateService({required String id, String? name, int? price, String? currency, String? imageUrl, bool? isVisible, int? index}) async {
    final response = await servicesDataSourceContract.updateService(id: id, name: name, price: price, currency: currency, imageUrl: imageUrl, visibility: isVisible, index: index);
    switch (response){
      case SuccessResponse<ServiceResponse>():
        final ServiceEntity service = ServiceEntity(
          id: response.data.service?.id,
          name: response.data.service?.name,
          imageUrl: response.data.service?.imageUrl,
          price: response.data.service?.price,
          currency: response.data.service?.currency,
          isVisible: response.data.service?.isVisible,
          index: response.data.service?.index,
          createdAt: response.data.service?.createdAt,
          updatedAt: response.data.service?.updatedAt,
        );
        return SuccessResponse<ServiceEntity>(data: service);
      case ErrorResponse<ServiceResponse>():
        return ErrorResponse<ServiceEntity>(error: response.error);
    }    
  }
}
