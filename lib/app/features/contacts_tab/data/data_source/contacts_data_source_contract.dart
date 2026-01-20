import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/contact_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/contacts_response.dart';

abstract class ContactsDataSourceContract {
  Future<BaseResponse<ContactsResponse>> getContacts();

  Future<BaseResponse<ContactResponse>> getContact(int id);
}
