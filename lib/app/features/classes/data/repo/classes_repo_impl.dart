import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/classes/data/data_source/classes_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/delete_class_response.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/get_classes_response.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/one_class_response.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/update_class_response.dart';
import 'package:pilates_dashboard/app/features/classes/domain/model/delete_class_model.dart';
import 'package:pilates_dashboard/app/features/classes/domain/model/get_classes_model.dart';
import 'package:pilates_dashboard/app/features/classes/domain/repo/classes_repo_contract.dart';

@Injectable(as: ClassesRepoContract)
class ClassesRepoImpl implements ClassesRepoContract {
  final ClassesDataSourceContract classesDataSourceContract;
  ClassesRepoImpl(this.classesDataSourceContract);
  @override
  Future<BaseResponse<GetClassesModel>> getClasses() async {
    final response = await classesDataSourceContract.getClasses();
    switch (response) {
      case SuccessResponse<GetClassesResponse>():
        final List<ClassEntity> classes = response.data.classes!.map((e) {
          return ClassEntity(
            id: e.id!,
            name: e.name!,
            price: e.price,
            description: e.description,
            location: e.location,
            maxParticipations: e.maxParticipations,
            tagLine: e.tagLine,
          );
        }).toList();
        GetClassesModel model = GetClassesModel(classes: classes);
        return SuccessResponse<GetClassesModel>(data: model);
      case ErrorResponse<GetClassesResponse>():
        return ErrorResponse<GetClassesModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<ClassEntity>> addClass({
    required String name,
    double? price,
    String? tagLine,
    String? description,
    String? location,
    int? maxParticipants,
  }) async {
    final response = await classesDataSourceContract.addClass(
      name: name,
      price: price,
      tagLine: tagLine,
      description: description,
      location: location,
      maxParticipants: maxParticipants,
    );
    switch (response) {
      case SuccessResponse<OneClassResponse>():
        final ClassEntity classEntity = ClassEntity(
          id: response.data.classData!.id!,
          name: response.data.classData!.name!,
          price: response.data.classData!.price,
          description: response.data.classData!.description,
          location: response.data.classData!.location,
          maxParticipations: response.data.classData!.maxParticipations,
          tagLine: response.data.classData!.tagLine,
        );
        return SuccessResponse<ClassEntity>(data: classEntity);
      case ErrorResponse<OneClassResponse>():
        return ErrorResponse<ClassEntity>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<ClassEntity>> getOneClass({required String id}) async {
    final response = await classesDataSourceContract.getOneClass(id: id);
    switch (response) {
      case SuccessResponse<OneClassResponse>():
        final ClassEntity classEntity = ClassEntity(
          id: response.data.classData!.id!,
          name: response.data.classData!.name!,
          price: response.data.classData!.price,
          description: response.data.classData!.description,
          location: response.data.classData!.location,
          maxParticipations: response.data.classData!.maxParticipations,
          tagLine: response.data.classData!.tagLine,
        );
        return SuccessResponse<ClassEntity>(data: classEntity);
      case ErrorResponse<OneClassResponse>():
        return ErrorResponse<ClassEntity>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<DeleteClassModel>> deleteClass({
    required String id,
  }) async {
    final response = await classesDataSourceContract.deleteClass(id: id);
    switch (response) {
      case SuccessResponse<DeleteClassResponse>():
        final model = DeleteClassModel(
          message: response.data.message,
          status: response.data.status,
        );
        return SuccessResponse<DeleteClassModel>(data: model);
      case ErrorResponse<DeleteClassResponse>():
        return ErrorResponse<DeleteClassModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<ClassEntity>> updateClass({
    required String id,
    String? name,
    double? price,
    String? tagLine,
    String? description,
    String? location,
    int? maxParticipants,
  }) async {
    final response = await classesDataSourceContract.updateClass(
      id: id,
      name: name,
      price: price,
      tagLine: tagLine,
      description: description,
      location: location,
      maxParticipants: maxParticipants,
    );
    switch (response) {
      case SuccessResponse<UpdateClassResponse>():
        final ClassEntity classEntity = ClassEntity(
          id: response.data.classData!.id!,
          name: response.data.classData!.name!,
          price: response.data.classData!.price?.toDouble(),
          description: response.data.classData!.description,
          location: response.data.classData!.location,
          maxParticipations: response.data.classData!.maxParticipations,
          tagLine: response.data.classData!.tagLine,
        );
        return SuccessResponse<ClassEntity>(data: classEntity);
      case ErrorResponse<UpdateClassResponse>():
        return ErrorResponse<ClassEntity>(error: response.error);
    }
  }
}
