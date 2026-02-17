import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/core/utils/session_manager.dart';
import 'package:pilates_dashboard/app/features/profile/domain/model/user_model.dart';
import 'package:pilates_dashboard/app/features/profile/domain/use_cases/user_use_case.dart';
import 'package:pilates_dashboard/app/features/profile/presentation/view_model/user_states.dart';

@injectable
class UserViewModel extends Cubit<UserStates> {
  final SessionManager _sessionManager;
  UserUseCase userUseCase;

  UserViewModel(this.userUseCase , this._sessionManager) : super(UserStates());

  Future<BaseResponse<UserModel>> getUser() async {
    emit(state.copyWith(userState: BaseState<UserModel>(isLoading: true)));
    final userId = await _sessionManager.getUserId();
    final user = await userUseCase.getUser(int.parse(userId!));
    switch (user){
      case SuccessResponse<UserModel>():
        emit(state.copyWith(userState: BaseState<UserModel>(data: user.data, isLoading: false)));
      case ErrorResponse<UserModel>():
        emit(state.copyWith(userState: BaseState<UserModel>(errorMessage: user.error.toString(), isLoading: false)));
    }
    return user;
  }

  Future<BaseResponse<UserModel>> updateUser( String? firstName, String? lastName, String? email) async{
    emit(state.copyWith(editUserState: BaseState<UserModel>(isLoading: true)));
    final id = await _sessionManager.getUserId();
    final user = await userUseCase.updateUser(int.parse(id!), firstName, lastName, email);
    switch (user){
      case SuccessResponse<UserModel>():
        emit(state.copyWith(editUserState: BaseState<UserModel>(data: user.data, isLoading: false)));
      case ErrorResponse<UserModel>():
        emit(state.copyWith(editUserState: BaseState<UserModel>(errorMessage: user.error.toString(), isLoading: false)));
    }
    return user;
  }
}