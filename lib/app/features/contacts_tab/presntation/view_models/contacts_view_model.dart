import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/contacts_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/use_cases/contacts_use_case.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/presntation/view_models/contacts_states.dart';

@injectable
class ContactsViewModel extends Cubit<ContactsStates> {
  final ContactsUseCase _contactsUseCase;
  TextEditingController searchController = TextEditingController();
  int? contactId;
  ContactsViewModel(this._contactsUseCase) : super(ContactsStates());

  Future<void> doIntent() async {
    await getContacts();
  }

  Future<BaseResponse<ContactsModel>> getContacts() async {
    emit(
      state.copyWith(
        contactsStateParam: BaseState<ContactsModel>(isLoading: true),
      ),
    );
    BaseResponse<ContactsModel> response = await _contactsUseCase.getContacts();
    switch (response) {
      case SuccessResponse<ContactsModel>():
        emit(
          state.copyWith(
            contactsStateParam: BaseState<ContactsModel>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
      case ErrorResponse<ContactsModel>():
        emit(
          state.copyWith(
            contactsStateParam: BaseState<ContactsModel>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
    }
    return response;
  }

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
