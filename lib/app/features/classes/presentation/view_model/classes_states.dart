import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/classes/domain/model/delete_class_model.dart';
import 'package:pilates_dashboard/app/features/classes/domain/model/get_classes_model.dart';

class ClassesStates {
  BaseState<GetClassesModel>? classesState;
  BaseState<ClassEntity>? addClassState;
  BaseState<ClassEntity>? oneClassState;
  BaseState<DeleteClassModel>? deleteClassState;
  BaseState<ClassEntity>? updateClassState;
  ClassesStates({this.classesState, this.addClassState, this.oneClassState , this.deleteClassState , this.updateClassState});

  ClassesStates copyWith({
    BaseState<GetClassesModel>? classesState,
    BaseState<ClassEntity>? addClassState,
    BaseState<ClassEntity>? oneClassState,
    BaseState<DeleteClassModel>? deleteClassState,
    BaseState<ClassEntity>? updateClassState
  }) {
    return ClassesStates(
      classesState: classesState ?? this.classesState,
      addClassState: addClassState ?? this.addClassState,
      oneClassState: oneClassState ?? this.oneClassState,
      deleteClassState: deleteClassState ?? this.deleteClassState,
      updateClassState: updateClassState ?? this.updateClassState
    );
  }
}
