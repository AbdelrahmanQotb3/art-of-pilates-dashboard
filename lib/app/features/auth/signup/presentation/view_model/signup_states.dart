import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/auth/signup/domain/model/signup_model.dart';

class SignupStates {
  BaseState<SignupModel>? signupState;

  SignupStates({this.signupState});

  SignupStates copyWith({BaseState<SignupModel>? signupStateParam}) {
    return SignupStates(signupState: signupStateParam ?? signupState);
  }
}
