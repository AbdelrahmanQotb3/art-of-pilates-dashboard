import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/classes/domain/model/delete_class_model.dart';
import 'package:pilates_dashboard/app/features/classes/domain/model/get_classes_model.dart';
import 'package:pilates_dashboard/app/features/classes/domain/repo/classes_repo_contract.dart';

@injectable
class ClassesUseCase {
  final ClassesRepoContract classesRepoContract;

  ClassesUseCase(this.classesRepoContract);

  Future<BaseResponse<GetClassesModel>> getClasses() =>
      classesRepoContract.getClasses();

  Future<BaseResponse<ClassEntity>> addClass({
    required String name,
    double? price,
    String? tagLine,
    String? description,
    String? location,
    int? maxParticipants,
  }) => classesRepoContract.addClass(
    name: name,
    price: price,
    tagLine: tagLine,
    description: description,
    location: location,
    maxParticipants: maxParticipants,
  );

  Future<BaseResponse<ClassEntity>> getOneClass({required String id}) =>
      classesRepoContract.getOneClass(id: id);

  Future<BaseResponse<DeleteClassModel>> deleteClass({required String id}) =>
      classesRepoContract.deleteClass(id: id);

  Future<BaseResponse<ClassEntity>> updateClass({
    required String id,
    String? name,
    double? price,
    String? tagLine,
    String? description,
    String? location,
    int? maxParticipants,
  }) =>
      classesRepoContract.updateClass(
        id: id,
        name: name,
        price: price,
        tagLine: tagLine,
        description: description,
        location: location,
        maxParticipants: maxParticipants,
      );
}
