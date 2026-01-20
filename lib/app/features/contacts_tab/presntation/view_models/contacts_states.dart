import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/contacts_model.dart';

class ContactsStates {
  BaseState<ContactsModel>? contactsState;
  BaseState<ContactEntity>? contactState;

  ContactsStates({this.contactsState, this.contactState});

  ContactsStates copyWith({
    BaseState<ContactsModel>? contactsStateParam,
    BaseState<ContactEntity>? contactStateParam,
  }) {
    return ContactsStates(
      contactsState: contactsStateParam ?? contactsState,
      contactState: contactStateParam ?? contactState,
    );
  }
}
