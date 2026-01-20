import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/contacts_model.dart';

abstract class ContactsRepoContract {
  Future<BaseResponse<ContactsModel>> getContacts();
  Future<BaseResponse<ContactEntity>> getContact(int id);
}
