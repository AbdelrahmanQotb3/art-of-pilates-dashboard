import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/contacts_model.dart';
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
}
