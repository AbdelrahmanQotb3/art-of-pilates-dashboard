import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/classes/domain/model/delete_class_model.dart';
import 'package:pilates_dashboard/app/features/classes/domain/model/get_classes_model.dart';
import 'package:pilates_dashboard/app/features/classes/domain/use_cases/classes_use_case.dart';
import 'package:pilates_dashboard/app/features/classes/presentation/view_model/classes_states.dart';

@injectable
class ClassesViewModel extends Cubit<ClassesStates> {
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController tagLineController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final ClassesUseCase classesUseCase;
  ClassesViewModel(this.classesUseCase) : super(ClassesStates());

  Future<BaseResponse<GetClassesModel>> getClasses() async {
    emit(
      state.copyWith(classesState: BaseState<GetClassesModel>(isLoading: true)),
    );
    final response = await classesUseCase.getClasses();
    switch (response) {
      case SuccessResponse<GetClassesModel>():
        emit(
          state.copyWith(
            classesState: BaseState<GetClassesModel>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return response;
      case ErrorResponse<GetClassesModel>():
        emit(
          state.copyWith(
            classesState: BaseState<GetClassesModel>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return response;
    }
  }

  Future<BaseResponse<ClassEntity>> getOneClass(String id) async {
    emit(
      state.copyWith(oneClassState: BaseState<ClassEntity>(isLoading: true)),
    );
    final response = await classesUseCase.getOneClass(id: id);
    switch (response) {
      case SuccessResponse<ClassEntity>():
        emit(
          state.copyWith(
            oneClassState: BaseState<ClassEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return response;
      case ErrorResponse<ClassEntity>():
        emit(
          state.copyWith(
            oneClassState: BaseState<ClassEntity>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return response;
    }
  }

  Future<BaseResponse<ClassEntity>> addClass({
    required String name,
    double? price,
    String? tagLine,
    String? description,
    String? location,
    int? maxParticipants,
  }) async {
    emit(
      state.copyWith(addClassState: BaseState<ClassEntity>(isLoading: true)),
    );
    final response = await classesUseCase.addClass(
      name: name,
      price: price,
      tagLine: tagLine,
      description: description,
      location: location,
      maxParticipants: maxParticipants,
    );
    switch (response) {
      case SuccessResponse<ClassEntity>():
        emit(
          state.copyWith(
            addClassState: BaseState<ClassEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
      case ErrorResponse<ClassEntity>():
        emit(
          state.copyWith(
            addClassState: BaseState<ClassEntity>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
    }
    return response;
  }

  Future<bool> deleteClass({required String id}) async {
    emit(
      state.copyWith(
        deleteClassState: BaseState<DeleteClassModel>(isLoading: true),
      ),
    );
    final response = await classesUseCase.deleteClass(id: id);
    switch (response) {
      case SuccessResponse<DeleteClassModel>():
        emit(
          state.copyWith(
            deleteClassState: BaseState<DeleteClassModel>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return true;
      case ErrorResponse<DeleteClassModel>():
        emit(
          state.copyWith(
            deleteClassState: BaseState<DeleteClassModel>(
              errorMessage: response.error.toString(),
            ),
          ),
        );
        return false;
    }
  }

  Future<bool> updateClass({
    required String id,
    required String name,
    double? price,
    String? tagLine,
    String? description,
    String? location,
    int? maxParticipants,
  }) async {
    emit(
      state.copyWith(updateClassState: BaseState<ClassEntity>(isLoading: true)),
    );
    final response = await classesUseCase.updateClass(
      id: id,
      name: name,
      price: price,
      tagLine: tagLine,
      description: description,
      location: location,
      maxParticipants: maxParticipants,
    );
    switch (response) {
      case SuccessResponse<ClassEntity>():
        emit(
          state.copyWith(
            updateClassState: BaseState<ClassEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return true;
      case ErrorResponse<ClassEntity>():
        emit(
          state.copyWith(
            updateClassState: BaseState<ClassEntity>(
              errorMessage: response.error.toString(),
            ),
          ),
        );
        return false;
    }
  }
}
