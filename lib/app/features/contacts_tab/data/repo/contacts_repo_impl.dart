import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/data_source/contacts_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/contact_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/contacts_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/create_contact_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/delete_contact_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/update_contact_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/contacts_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/delete_contact_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/repo/contacts_repo_contract.dart';

@Injectable(as: ContactsRepoContract)
class ContactsRepoImpl implements ContactsRepoContract {
  final ContactsDataSourceContract _contactsDataSourceContract;

  ContactsRepoImpl(this._contactsDataSourceContract);

  @override
  Future<BaseResponse<ContactsModel>> getContacts() async {
    BaseResponse<ContactsResponse> response = await _contactsDataSourceContract
        .getContacts();
    switch (response) {
      case SuccessResponse<ContactsResponse>():
        final List<ContactEntity> contacts = response.data.contacts!.map((
          contactDto,
        ) {
          return ContactEntity(
            id: contactDto.id!,
            firstName: contactDto.firstName,
            lastName: contactDto.lastName,
            email: contactDto.email,
            phoneNumber: contactDto.phone,
            addressCity: contactDto.addressCity,
            addressCountry: contactDto.addressCountry,
          );
        }).toList();

        ContactsModel model = ContactsModel(contacts: contacts);
        return SuccessResponse<ContactsModel>(data: model);
      case ErrorResponse<ContactsResponse>():
        return ErrorResponse<ContactsModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<ContactEntity>> getContact(int id) async {
    final response = await _contactsDataSourceContract.getContact(id);
    switch (response) {
      case SuccessResponse<ContactResponse>():
        final contact = ContactEntity(
          id: response.data.contact!.id!,
          firstName: response.data.contact!.firstName,
          lastName: response.data.contact!.lastName,
          email: response.data.contact!.email,
          phoneNumber: response.data.contact!.phone,
          addressCity: response.data.contact!.addressCity,
          addressCountry: response.data.contact!.addressCountry,
        );
        return SuccessResponse<ContactEntity>(data: contact);
      case ErrorResponse<ContactResponse>():
        return ErrorResponse<ContactEntity>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<DeleteContactModel>> deleteContact(int id) async {
    final response = await _contactsDataSourceContract.deleteContact(id);
    switch (response) {
      case SuccessResponse<DeleteContactResponse>():
        DeleteContactModel model = DeleteContactModel(
          message: response.data.message,
          status: response.data.status,
        );
        return SuccessResponse<DeleteContactModel>(data: model);
      case ErrorResponse<DeleteContactResponse>():
        return ErrorResponse<DeleteContactModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<ContactEntity>> updateContact(
    int id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? addressCity,
    String? addressCountry,
  ) async {
    final response = await _contactsDataSourceContract.updateContact(
      id,
      firstName,
      lastName,
      email,
      phoneNumber,
      addressCity,
      addressCountry,
    );
    switch (response) {
      case SuccessResponse<UpdateContactResponse>():
        final contact = ContactEntity(
          id: response.data.user!.id!,
          firstName: response.data.user!.firstName,
          lastName: response.data.user!.lastName,
          email: response.data.user!.email,
          phoneNumber: response.data.user!.phone,
          addressCity: response.data.user!.addressCity,
          addressCountry: response.data.user!.addressCountry,
        );
        return SuccessResponse<ContactEntity>(data: contact);
      case ErrorResponse<UpdateContactResponse>():
        return ErrorResponse<ContactEntity>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<ContactEntity>> createContact(
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? addressCity,
    String? addressCountry,
  ) async {
    final response = await _contactsDataSourceContract.createContact(
      firstName,
      lastName,
      email,
      phoneNumber,
      addressCity,
      addressCountry,
    );
    switch (response) {
      case SuccessResponse<CreateContactResponse>():
        final contact = ContactEntity(
          id: response.data.contact!.id!,
          firstName: response.data.contact!.firstName,
          lastName: response.data.contact!.lastName,
          email: response.data.contact!.email,
          phoneNumber: response.data.contact!.phone,
          addressCity: response.data.contact!.addressCity,
          addressCountry: response.data.contact!.addressCountry,
        );
        return SuccessResponse<ContactEntity>(data: contact);
      case ErrorResponse<CreateContactResponse>():
        return ErrorResponse<ContactEntity>(error: response.error);
    }
  }
}
