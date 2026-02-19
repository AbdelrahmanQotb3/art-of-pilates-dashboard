import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/auth/signout/domain/model/signout_model.dart';
import 'package:pilates_dashboard/app/features/auth/signout/domain/use_case/signout_use_case.dart';
import 'package:pilates_dashboard/app/features/auth/signout/presentation/view_model/signout_state.dart';

@injectable
class SignoutViewModel extends Cubit<SignoutState> {
  final SignoutUseCase _signoutUseCase;
  SignoutViewModel(this._signoutUseCase) : super(SignoutState());

  Future<bool> signout() async {
    emit(
      state.copyWith(signoutState: BaseState<SignoutModel>(isLoading: true)),
    );
    final response = await _signoutUseCase.signout();
    switch (response) {
      case SuccessResponse<SignoutModel>():
      emit(state.copyWith(signoutState: BaseState<SignoutModel>(data: response.data, isLoading: false)));
      return true;
      case ErrorResponse<SignoutModel>():
      emit(state.copyWith(signoutState: BaseState<SignoutModel>(errorMessage: response.error.toString(), isLoading: false)));
      return false;
    }
  }
}
