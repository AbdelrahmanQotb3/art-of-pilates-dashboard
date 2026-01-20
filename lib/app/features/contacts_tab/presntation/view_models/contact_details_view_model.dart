import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/contacts_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/use_cases/contacts_use_case.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/presntation/view_models/contacts_states.dart';

@injectable
class ContactDetailsViewModel extends Cubit<ContactsStates> {
  int? contactId;
  final ContactsUseCase _contactsUseCase;
  ContactDetailsViewModel(this._contactsUseCase) : super(ContactsStates());

  Future<BaseResponse<ContactEntity>> getContact(int id) async {
    emit(
      state.copyWith(
        contactStateParam: BaseState<ContactEntity>(isLoading: true),
      ),
    );
    BaseResponse<ContactEntity> response = await _contactsUseCase.getContact(
      id,
    );
    switch (response) {
      case SuccessResponse<ContactEntity>():
        emit(
          state.copyWith(
            contactStateParam: BaseState<ContactEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
      case ErrorResponse<ContactEntity>():
        emit(
          state.copyWith(
            contactStateParam: BaseState<ContactEntity>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
    }
    return response;
  }
}
