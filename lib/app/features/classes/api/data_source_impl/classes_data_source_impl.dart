import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/classes/api/api_client/classes_api_client.dart';
import 'package:pilates_dashboard/app/features/classes/data/data_source/classes_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/delete_class_response.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/get_classes_response.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/one_class_response.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/update_class_response.dart';

@Injectable(as: ClassesDataSourceContract)
class ClassesDataSourceImpl implements ClassesDataSourceContract {
  final ClassesApiClient apiClient;

  ClassesDataSourceImpl(this.apiClient);

  @override
  Future<BaseResponse<GetClassesResponse>> getClasses() async {
    try {
      final response = await apiClient.getClasses();
      return SuccessResponse<GetClassesResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<GetClassesResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<OneClassResponse>> addClass({
    required String name,
    double? price,
    String? tagLine,
    String? description,
    String? location,
    int? maxParticipants,
  }) async {
    try {
      final response = await apiClient.addClass({
        "name": name,
        "price": price,
        "description": description,
        "tagLine": tagLine,
        "location": location,
        "maxParticipants": maxParticipants,
      });
      return SuccessResponse<OneClassResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<OneClassResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<OneClassResponse>> getOneClass({
    required String id,
  }) async {
    try {
      final resopnse = await apiClient.getOneClass(id);
      return SuccessResponse<OneClassResponse>(data: resopnse);
    } on Exception catch (e) {
      return ErrorResponse<OneClassResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<DeleteClassResponse>> deleteClass({
    required String id,
  }) async {
    try {
      final response = await apiClient.deleteClass(id);
      return SuccessResponse<DeleteClassResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<DeleteClassResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<UpdateClassResponse>> updateClass({
    required String id,
    String? name,
    double? price,
    String? tagLine,
    String? description,
    String? location,
    int? maxParticipants,
  }) async {
    try {
      final response = await apiClient.updateClass(id, {
        "name": name,
        "price": price,
        "description": description,
        "tagLine": tagLine,
        "location": location,
        "maxParticipations": maxParticipants,
      });
      return SuccessResponse<UpdateClassResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<UpdateClassResponse>(error: e);
    }
  }
}
