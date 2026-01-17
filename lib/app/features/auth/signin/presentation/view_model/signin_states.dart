import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/auth/signin/domain/model/signin_model.dart';

class SigninStates {
  BaseState<SigninModel>? signinState;
  int rememberMeChickBox;

  SigninStates({this.signinState, this.rememberMeChickBox = 0});

  SigninStates copyWith({
    BaseState<SigninModel>? signinStateParam,
    int? rememberMeChickBox,
  }) {
    return SigninStates(
      signinState: signinStateParam ?? signinState,
      rememberMeChickBox: rememberMeChickBox ?? this.rememberMeChickBox,
    );
  }
}
