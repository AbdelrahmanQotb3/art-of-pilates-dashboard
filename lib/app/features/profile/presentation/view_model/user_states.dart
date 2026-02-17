import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/profile/domain/model/user_model.dart';

class UserStates {
  BaseState<UserModel>? userState;
  BaseState<UserModel>? editUserState;

  UserStates({this.userState , this.editUserState});

  UserStates copyWith({BaseState<UserModel>? userState , BaseState<UserModel>? editUserState}) {
    return UserStates(userState: userState , editUserState: editUserState);
  }
}
