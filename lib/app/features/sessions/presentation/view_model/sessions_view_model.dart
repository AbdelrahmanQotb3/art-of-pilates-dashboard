import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/sessions_model.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/update_session_model.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/use_cases/sessions_use_case.dart';
import 'package:pilates_dashboard/app/features/sessions/presentation/view_model/sessions_state.dart';

@injectable
class SessionsViewModel extends Cubit<SessionsState> {
  final SessionsUseCase sessionsUseCase;

  // controllers for editing
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

  SessionsViewModel(this.sessionsUseCase) : super(SessionsState());

  Future<BaseResponse<SessionsModel>> getSessions() async {
    emit(
      state.copyWith(sessionsState: BaseState<SessionsModel>(isLoading: true)),
    );
    final response = await sessionsUseCase.getSessions();
    switch (response) {
      case SuccessResponse<SessionsModel>():
        emit(
          state.copyWith(
            sessionsState: BaseState<SessionsModel>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        break;
      case ErrorResponse<SessionsModel>():
        emit(
          state.copyWith(
            sessionsState: BaseState<SessionsModel>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        break;
    }
    return response;
  }

  Future<bool> deleteSession(String id) async {
    emit(state.copyWith(deleteSessionState: BaseState(isLoading: true)));
    final response = await sessionsUseCase.deleteSession(id);
    switch (response) {
      case SuccessResponse():
        emit(
          state.copyWith(
            deleteSessionState: BaseState(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return true;
      case ErrorResponse():
        emit(
          state.copyWith(
            deleteSessionState: BaseState(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return false;
    }
  }

  Future<bool> updateSession(
    String id,
    DateTime? startTime,
    DateTime? endTime,
    String? serviceId,
    String? staffMemberId,
  ) async {
    emit(state.copyWith(updateSessionState: BaseState(isLoading: true)));
    final response = await sessionsUseCase.updateSession(
      id,
      startTime,
      endTime,
      serviceId,
      staffMemberId,
    );
    switch (response) {
      case SuccessResponse<UpdateSessionModel>():
        emit(
          state.copyWith(
            updateSessionState: BaseState(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return true;
      case ErrorResponse<UpdateSessionModel>():
        emit(
          state.copyWith(
            updateSessionState: BaseState(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return false;
    }
  }

  @override
  Future<void> close() {
    startController.dispose();
    endController.dispose();
    return super.close();
  }
}
