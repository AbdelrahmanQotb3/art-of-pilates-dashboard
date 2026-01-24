import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/contacts_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/delete_contact_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/repo/contacts_repo_contract.dart';

@injectable
class ContactsUseCase {
  final ContactsRepoContract _contactsRepoContract;

  ContactsUseCase(this._contactsRepoContract);
  Future<BaseResponse<ContactsModel>> getContacts() {
    return _contactsRepoContract.getContacts();
  }

  Future<BaseResponse<ContactEntity>> getContact(int id) {
    return _contactsRepoContract.getContact(id);
  }

  Future<BaseResponse<DeleteContactModel>> deleteContact(int id) {
    return _contactsRepoContract.deleteContact(id);
  }

  Future<BaseResponse<ContactEntity>> updateContact(
    int id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? addressCity,
    String? addressCountry,
  ) {
    return _contactsRepoContract.updateContact(
      id,
      firstName,
      lastName,
      email,
      phoneNumber,
      addressCity,
      addressCountry,
    );
  }

  Future<BaseResponse<ContactEntity>> createContact(
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? addressCity,
    String? addressCountry,
  ) {
    return _contactsRepoContract.createContact(
      firstName,
      lastName,
      email,
      phoneNumber,
      addressCity,
      addressCountry,
    );
  }
}
