import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/api/api_client/contacts_api_client.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/data_source/contacts_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/contact_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/contacts_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/create_contact_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/delete_contact_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/update_contact_response.dart';

@Injectable(as: ContactsDataSourceContract)
class ContactsDataSourceImpl implements ContactsDataSourceContract {
  final ContactsApiClient _contactsApiClient;
  ContactsDataSourceImpl(this._contactsApiClient);

  @override
  Future<BaseResponse<ContactsResponse>> getContacts() async {
    try {
      final response = await _contactsApiClient.getContacts();
      return SuccessResponse<ContactsResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<ContactsResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<ContactResponse>> getContact(int id) async {
    try {
      final response = await _contactsApiClient.getContact(id);
      return SuccessResponse<ContactResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<ContactResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<DeleteContactResponse>> deleteContact(int id) async {
    try {
      final response = await _contactsApiClient.deleteContact(id);
      return SuccessResponse<DeleteContactResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<DeleteContactResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<UpdateContactResponse>> updateContact(
    int id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? addressCity,
    String? addressCountry,
  ) async {
    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phoneNumber,
      "addressCity": addressCity,
      "addressCountry": addressCountry,
    };
    try {
      final response = await _contactsApiClient.updateContact(id, body);
      return SuccessResponse<UpdateContactResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<UpdateContactResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<CreateContactResponse>> createContact(
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? addressCity,
    String? addressCountry,
  ) async {
    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phoneNumber,
      "addressCity": addressCity,
      "addressCountry": addressCountry,
    };
    try {
      final response = await _contactsApiClient.createContact(body);
      return SuccessResponse<CreateContactResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<CreateContactResponse>(error: e);
    }
  }
}
