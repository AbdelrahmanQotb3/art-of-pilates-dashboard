import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/services/domain/model/delete_service_model.dart';
import 'package:pilates_dashboard/app/features/services/domain/model/services_model.dart';
import 'package:pilates_dashboard/app/features/services/domain/repo/services_repo_contract.dart';

@injectable
class ServicesUseCase {
  final ServicesRepoContract servicesRepoContract;
  ServicesUseCase(this.servicesRepoContract);

  Future<BaseResponse<ServicesModel>> getServices() =>
      servicesRepoContract.getServices();

  Future<BaseResponse<ServiceEntity>> getOneService(String id) =>
      servicesRepoContract.getOneService(id);

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
    String? bookingPolicy
  }) => servicesRepoContract.addService(
    name: name,
    price: price,
    currency: currency,
    imageUrl: imageUrl,
    isVisible: isVisible,
    index: index,
    bufferTime: bufferTime,
    paymentType: paymentType,
    paymentPriceType: paymentPriceType,
    paymentAmount: paymentAmount,
    paymentPref: paymentPref,
    location: location,
    bookingPolicy: bookingPolicy
  );

  Future<BaseResponse<DeleteServiceModel>> deleteService(String id) =>
      servicesRepoContract.deleteService(id);

  Future<BaseResponse<ServiceEntity>> updateService({
    required String id,
    String? name,
    int? price,
    String? currency,
    String? imageUrl,
    bool? isVisible,
    int? index,
    String? paymentType,
    String? paymentPref,
    String? bookingPolicy,
    String? location,
    String? paymentPriceType,
    double? paymentAmount,
    DateTime? bufferTime

  }) => servicesRepoContract.updateService(
    id: id,
    name: name,
    price: price,
    currency: currency,
    imageUrl: imageUrl,
    isVisible: isVisible,
    index: index,
    paymentType: paymentType,
    paymentPref: paymentPref,
    bookingPolicy: bookingPolicy,
    location: location,
    paymentPriceType: paymentPriceType,
    paymentAmount: paymentAmount,
    bufferTime: bufferTime
  );
}
