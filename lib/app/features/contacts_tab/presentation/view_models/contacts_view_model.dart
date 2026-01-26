import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/contacts_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/use_cases/contacts_use_case.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/presentation/view_models/contacts_states.dart';

@lazySingleton
class ContactsViewModel extends Cubit<ContactsStates> {
  final ContactsUseCase _contactsUseCase;
  TextEditingController searchController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
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

  Future<bool> createContact(
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? addressCity,
    String? addressCountry,
  ) async {
    emit(
      state.copyWith(
        createContactStateParam: BaseState<ContactEntity>(isLoading: true),
      ),
    );
    final response = await _contactsUseCase.createContact(
      firstName,
      lastName,
      email,
      phoneNumber,
      addressCity,
      addressCountry,
    );
    switch (response) {
      case SuccessResponse<ContactEntity>():
        emit(
          state.copyWith(
            createContactStateParam: BaseState<ContactEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return true;
      case ErrorResponse<ContactEntity>():
        emit(
          state.copyWith(
            createContactStateParam: BaseState<ContactEntity>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return false;
    }
  }

  void reset() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    cityController.clear();
    countryController.clear();
    contactId = null;
  }
}
