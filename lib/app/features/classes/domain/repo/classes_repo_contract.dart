import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/classes/domain/model/delete_class_model.dart';
import 'package:pilates_dashboard/app/features/classes/domain/model/get_classes_model.dart';

abstract class ClassesRepoContract {
  Future<BaseResponse<GetClassesModel>> getClasses();
  Future<BaseResponse<ClassEntity>> addClass({
    required String name,
    double? price,
    String? tagLine,
    String? description,
    String? location,
    int? maxParticipants,
  });

  Future<BaseResponse<ClassEntity>> getOneClass({required String id});

  Future<BaseResponse<DeleteClassModel>> deleteClass({required String id});

  Future<BaseResponse<ClassEntity>> updateClass({
    required String id,
    String? name,
    double? price,
    String? tagLine,
    String? description,
    String? location,
    int? maxParticipants,
  });
}
