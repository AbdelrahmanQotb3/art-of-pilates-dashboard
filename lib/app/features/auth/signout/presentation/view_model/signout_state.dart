import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/auth/signout/domain/model/signout_model.dart';

class SignoutState {
  BaseState<SignoutModel>? signoutState;

  SignoutState({this.signoutState});

  SignoutState copyWith({BaseState<SignoutModel>? signoutState}) => SignoutState(signoutState: signoutState ?? this.signoutState);
}