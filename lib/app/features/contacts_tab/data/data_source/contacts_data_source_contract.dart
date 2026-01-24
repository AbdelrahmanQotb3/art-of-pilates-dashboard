import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/contact_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/contacts_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/create_contact_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/delete_contact_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/update_contact_response.dart';

abstract class ContactsDataSourceContract {
  Future<BaseResponse<ContactsResponse>> getContacts();

  Future<BaseResponse<ContactResponse>> getContact(int id);

  Future<BaseResponse<DeleteContactResponse>> deleteContact(int id);

  Future<BaseResponse<UpdateContactResponse>> updateContact(
    int id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? addressCity,
    String? addressCountry,
  );

  Future<BaseResponse<CreateContactResponse>> createContact(
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? addressCity,
    String? addressCountry,
  );
}
