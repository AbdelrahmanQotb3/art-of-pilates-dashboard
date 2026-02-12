import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/delete_class_response.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/get_classes_response.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/one_class_response.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/update_class_response.dart';

abstract class ClassesDataSourceContract {
  Future<BaseResponse<GetClassesResponse>> getClasses();
  Future<BaseResponse<OneClassResponse>> addClass({
    required String name,
    double? price,
    String? tagLine,
    String? description,
    String? location,
    int? maxParticipants,
  });

  Future<BaseResponse<OneClassResponse>> getOneClass({required String id});

  Future<BaseResponse<DeleteClassResponse>> deleteClass({required String id});

  Future<BaseResponse<UpdateClassResponse>> updateClass({
    required String id,
    String? name,
    double? price,
    String? tagLine,
    String? description,
    String? location,
    int? maxParticipants,
  });
}
