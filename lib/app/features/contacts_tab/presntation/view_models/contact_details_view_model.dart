import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/contacts_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/delete_contact_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/use_cases/contacts_use_case.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/presntation/view_models/contacts_states.dart';

@injectable
class ContactDetailsViewModel extends Cubit<ContactsStates> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
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

  Future<bool> deleteContact(int id) async {
    final bool isDeleted;
    emit(
      state.copyWith(
        deleteContactStateParam: BaseState<DeleteContactModel>(isLoading: true),
      ),
    );
    BaseResponse<DeleteContactModel> response = await _contactsUseCase
        .deleteContact(id);
    switch (response) {
      case SuccessResponse<DeleteContactModel>():
        emit(
          state.copyWith(
            deleteContactStateParam: BaseState<DeleteContactModel>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        isDeleted = true;
      case ErrorResponse<DeleteContactModel>():
        emit(
          state.copyWith(
            deleteContactStateParam: BaseState<DeleteContactModel>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        isDeleted = false;
    }
    return isDeleted;
  }

  Future<bool> updateContact(
    int id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? addressCity,
    String? addressCountry,
  ) async {
    bool isUpdated = false;
    emit(
      state.copyWith(
        updateContactStateParam: BaseState<ContactEntity>(isLoading: true),
      ),
    );
    final resposne = await _contactsUseCase.updateContact(
      id,
      firstName,
      lastName,
      email,
      phoneNumber,
      addressCity,
      addressCountry,
    );
    switch (resposne) {
      case SuccessResponse<ContactEntity>():
        isUpdated = true;
        emit(
          state.copyWith(
            updateContactStateParam: BaseState<ContactEntity>(
              data: resposne.data,
              isLoading: false,
            ),
          ),
        );
      case ErrorResponse<ContactEntity>():
        emit(
          state.copyWith(
            updateContactStateParam: BaseState<ContactEntity>(
              errorMessage: resposne.error.toString(),
              isLoading: false,
            ),
          ),
        );
    }
    return isUpdated;
  }
}
