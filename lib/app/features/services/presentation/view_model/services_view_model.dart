import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/services/domain/model/delete_service_model.dart';
import 'package:pilates_dashboard/app/features/services/domain/model/services_model.dart';
import 'package:pilates_dashboard/app/features/services/domain/use_case/services_use_case.dart';
import 'package:pilates_dashboard/app/features/services/presentation/view_model/services_state.dart';

@injectable
class ServicesViewModel extends Cubit<ServicesState> {
  ServicesUseCase servicesUseCase;
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController currencyController = TextEditingController(text: "SAR");
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController isVisibleController = TextEditingController(text: "true");
  ServicesViewModel(this.servicesUseCase) : super(ServicesState());

  Future<BaseResponse<ServicesModel>> getServices() async {
    emit(
      state.copyWith(servicesState: BaseState<ServicesModel>(isLoading: true)),
    );
    final response = await servicesUseCase.getServices();
    switch (response) {
      case SuccessResponse<ServicesModel>():
        emit(
          state.copyWith(
            servicesState: BaseState<ServicesModel>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        break;
      case ErrorResponse<ServicesModel>():
        emit(
          state.copyWith(
            servicesState: BaseState<ServicesModel>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        break;
    }
    return response;
  }

  Future<BaseResponse<ServiceEntity>> getOneService(String id) async {
    emit(
      state.copyWith(serviceState: BaseState<ServiceEntity>(isLoading: true)),
    );
    final response = await servicesUseCase.getOneService(id);
    switch (response) {
      case SuccessResponse<ServiceEntity>():
        emit(
          state.copyWith(
            serviceState: BaseState<ServiceEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        break;
      case ErrorResponse<ServiceEntity>():
        emit(
          state.copyWith(
            serviceState: BaseState<ServiceEntity>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        break;
    }
    return response;
  }

  Future<bool> addService({
    required String name,
    required String price,
    required String currency,
    String? imageUrl,
    bool? isVisible = true,
    int? index,
  }) async {
    emit(
      state.copyWith(
        addServiceState: BaseState<ServiceEntity>(isLoading: true),
      ),
    );
    final response = await servicesUseCase.addService(
      name: name,
      price: price,
      currency: currency,
      imageUrl: imageUrl,
      isVisible: isVisible,
      index: index,
    );
    switch (response) {
      case SuccessResponse<ServiceEntity>():
        emit(
          state.copyWith(
            addServiceState: BaseState<ServiceEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return true;
      case ErrorResponse<ServiceEntity>():
        emit(
          state.copyWith(
            addServiceState: BaseState<ServiceEntity>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return false;
    }
  }

  Future<bool> deleteService(String id) async {
    emit(
      state.copyWith(
        deleteServiceState: BaseState<DeleteServiceModel>(isLoading: true),
      ),
    );
    final response = await servicesUseCase.deleteService(id);
    switch (response) {
      case SuccessResponse<DeleteServiceModel>():
        emit(
          state.copyWith(
            deleteServiceState: BaseState<DeleteServiceModel>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return true;
      case ErrorResponse<DeleteServiceModel>():
        emit(
          state.copyWith(
            deleteServiceState: BaseState<DeleteServiceModel>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return false;
    }
  }

  Future<bool> updateService({
    required String id,
    required String name,
    required int price,
    required String currency,
    String? imageUrl,
    bool? isVisible = true,
    int? index,
  }) async {
    emit(
      state.copyWith(
        updateServiceState: BaseState<ServiceEntity>(isLoading: true),
      ),
    );
    final response = await servicesUseCase.updateService(
      id: id,
      name: name,
      price: price,
      currency: currency,
      imageUrl: imageUrl,
      isVisible: isVisible,
      index: index,
    );
    switch (response) {
      case SuccessResponse<ServiceEntity>():
        emit(
          state.copyWith(
            updateServiceState: BaseState<ServiceEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return true;
      case ErrorResponse<ServiceEntity>():
        emit(
          state.copyWith(
            updateServiceState: BaseState<ServiceEntity>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return false;
    }
  }
}
