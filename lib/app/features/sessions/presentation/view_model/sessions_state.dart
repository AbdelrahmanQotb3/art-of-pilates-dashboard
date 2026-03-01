import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/sessions_model.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/delete_session_model.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/update_session_model.dart';

class SessionsState {
  BaseState<SessionsModel>? sessionsState;
  BaseState<SessionEntity>? sessionState;
  BaseState<DeleteSessionModel>? deleteSessionState;
  BaseState<UpdateSessionModel>? updateSessionState;

  SessionsState({
    this.sessionsState,
    this.sessionState,
    this.deleteSessionState,
    this.updateSessionState,
  });

  SessionsState copyWith({
    BaseState<SessionsModel>? sessionsState,
    BaseState<SessionEntity>? sessionState,
    BaseState<DeleteSessionModel>? deleteSessionState,
    BaseState<UpdateSessionModel>? updateSessionState,
  }) {
    return SessionsState(
      sessionsState: sessionsState ?? this.sessionsState,
      sessionState: sessionState ?? this.sessionState,
      deleteSessionState: deleteSessionState ?? this.deleteSessionState,
      updateSessionState: updateSessionState ?? this.updateSessionState,
    );
  }
}
