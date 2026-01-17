import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/auth/signin/domain/model/signin_model.dart';
import 'package:pilates_dashboard/app/features/auth/signin/domain/use_cases/signin_use_case.dart';
import 'package:pilates_dashboard/app/features/auth/signin/presentation/view_model/signin_events.dart';
import 'package:pilates_dashboard/app/features/auth/signin/presentation/view_model/signin_states.dart';

@injectable
class SigninViewModel extends Cubit<SigninStates> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  final SigninUseCase _signinUseCase;
  SigninViewModel(this._signinUseCase) : super(SigninStates());

  void doIntent(SigninEvents event, String email, String password) {
    switch (event) {
      case SigninEvent():
        signin(email, password);
        return;
      case RememberMeEvent():
        rememberMeChickBox();
        return;
    }
  }

  Future<void> signin(String email, String password) async {
    emit(
      state.copyWith(signinStateParam: BaseState<SigninModel>(isLoading: true)),
    );
    final resposne = await _signinUseCase.signin(email, password);
    if (isClosed) return;

    switch (resposne) {
      case SuccessResponse<SigninModel>():
        emit(
          state.copyWith(
            signinStateParam: BaseState<SigninModel>(
              data: resposne.data,
              isLoading: false,
            ),
          ),
        );
        return;
      case ErrorResponse<SigninModel>():
        emit(
          state.copyWith(
            signinStateParam: BaseState<SigninModel>(
              errorMessage: email,
              isLoading: false,
            ),
          ),
        );
        return;
    }
  }

  void rememberMeChickBox() {
    final newValue = state.rememberMeChickBox == 0 ? 1 : 0;
    emit(state.copyWith(rememberMeChickBox: newValue));
  }
}
