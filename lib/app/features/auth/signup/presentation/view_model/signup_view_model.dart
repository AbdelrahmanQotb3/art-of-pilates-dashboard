import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/auth/signup/domain/model/signup_model.dart';
import 'package:pilates_dashboard/app/features/auth/signup/domain/use_cases/signup_usecase.dart';
import 'package:pilates_dashboard/app/features/auth/signup/presentation/view_model/signup_events.dart';
import 'package:pilates_dashboard/app/features/auth/signup/presentation/view_model/signup_states.dart';

@injectable
class SignupViewModel extends Cubit<SignupStates> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  final SignupUseCase _signupUseCase;
  SignupViewModel(this._signupUseCase) : super(SignupStates());

  void doIntent(
    SignupEvents event,
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String role,
  ) {
    switch (event) {
      case SignupEvent():
        signup(email, password, firstName, lastName, phoneNumber, role);
        return;
    }
  }

  Future<void> signup(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String role,
  ) async {
    emit(
      state.copyWith(signupStateParam: BaseState<SignupModel>(isLoading: true)),
    );
    final resposne = await _signupUseCase.signup(
      email,
      password,
      firstName,
      lastName,
      phoneNumber,
      role,
    );
    try {
      if (isClosed) return;
      switch (resposne) {
        case SuccessResponse<SignupModel>():
          emit(
            state.copyWith(
              signupStateParam: BaseState<SignupModel>(
                data: resposne.data,
                isLoading: false,
              ),
            ),
          );
          return;
        case ErrorResponse<SignupModel>():
          emit(
            state.copyWith(
              signupStateParam: BaseState<SignupModel>(
                errorMessage: resposne.error.toString(),
                isLoading: false,
              ),
            ),
          );
          return;
      }
    } catch (e) {
      emit(
        state.copyWith(
          signupStateParam: BaseState<SignupModel>(
            errorMessage: e.toString(),
            isLoading: false,
          ),
        ),
      );
    }
  }
}
