import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/contacts_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/delete_contact_model.dart';

class ContactsStates {
  BaseState<ContactsModel>? contactsState;
  BaseState<ContactEntity>? contactState;
  BaseState<DeleteContactModel>? deleteContactState;
  BaseState<ContactEntity>? updateContactState;
  BaseState<ContactEntity>? createContactState;

  ContactsStates({
    this.contactsState,
    this.contactState,
    this.deleteContactState,
    this.updateContactState,
    this.createContactState,
  });

  ContactsStates copyWith({
    BaseState<ContactsModel>? contactsStateParam,
    BaseState<ContactEntity>? contactStateParam,
    BaseState<DeleteContactModel>? deleteContactStateParam,
    BaseState<ContactEntity>? updateContactStateParam,
    BaseState<ContactEntity>? createContactStateParam,
  }) {
    return ContactsStates(
      contactsState: contactsStateParam ?? contactsState,
      contactState: contactStateParam ?? contactState,
      deleteContactState: deleteContactStateParam ?? deleteContactState,
      updateContactState: updateContactStateParam ?? updateContactState,
      createContactState: createContactStateParam ?? createContactState,
    );
  }
}
