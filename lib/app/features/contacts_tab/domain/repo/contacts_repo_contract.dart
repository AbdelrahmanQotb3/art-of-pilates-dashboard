import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/contacts_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/delete_contact_model.dart';

abstract class ContactsRepoContract {
  Future<BaseResponse<ContactsModel>> getContacts();
  Future<BaseResponse<ContactEntity>> getContact(int id);
  Future<BaseResponse<DeleteContactModel>> deleteContact(int id);
  Future<BaseResponse<ContactEntity>> updateContact(
    int id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? addressCity,
    String? addressCountry,
  );

  Future<BaseResponse<ContactEntity>> createContact(
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? addressCity,
    String? addressCountry,
  );
}
