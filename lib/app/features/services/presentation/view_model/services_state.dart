import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/services/domain/model/delete_service_model.dart';
import 'package:pilates_dashboard/app/features/services/domain/model/services_model.dart';

class ServicesState {
  BaseState<ServicesModel>? servicesState;
  BaseState<ServiceEntity>? serviceState;
  BaseState<ServiceEntity>? addServiceState;
  BaseState<DeleteServiceModel>? deleteServiceState;
  BaseState<ServiceEntity>? updateServiceState;

  ServicesState({this.servicesState , this.serviceState , this.addServiceState , this.deleteServiceState , this.updateServiceState});

  ServicesState copyWith({BaseState<ServicesModel>? servicesState , BaseState<ServiceEntity>? serviceState , BaseState<ServiceEntity>? addServiceState , BaseState<DeleteServiceModel>? deleteServiceState , BaseState<ServiceEntity>? updateServiceState}) {
    return ServicesState(
      servicesState: servicesState ?? this.servicesState,
      serviceState: serviceState ?? this.serviceState,
      addServiceState: addServiceState ?? this.addServiceState,
      deleteServiceState: deleteServiceState ?? this.deleteServiceState,
      updateServiceState: updateServiceState ?? this.updateServiceState
      );
  }
}