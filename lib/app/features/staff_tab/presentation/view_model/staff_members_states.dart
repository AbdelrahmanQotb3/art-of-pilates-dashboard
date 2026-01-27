import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/model/delete_staff_member_model.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/model/staff_members_model.dart';

class StaffMembersStates {
  BaseState<StaffMembersModel>? staffMembersState;
  BaseState<StaffMemberEntity>? staffMemberState;
  BaseState<StaffMemberEntity>? addStaffMemberState;
  BaseState<DeleteStaffMemberModel>? deleteStaffMemberState;
  BaseState<StaffMemberEntity>? updateStaffMemberState;

  StaffMembersStates({
    this.staffMembersState,
    this.staffMemberState,
    this.addStaffMemberState,
    this.deleteStaffMemberState,
    this.updateStaffMemberState,
  });

  StaffMembersStates copyWith({
    BaseState<StaffMembersModel>? staffMembersState,
    BaseState<StaffMemberEntity>? staffMemberState,
    BaseState<StaffMemberEntity>? addStaffMemberState,
    BaseState<DeleteStaffMemberModel>? deleteStaffMemberState,
    BaseState<StaffMemberEntity>? updateStaffMemberState,
  }) {
    return StaffMembersStates(
      staffMembersState: staffMembersState ?? this.staffMembersState,
      staffMemberState: staffMemberState ?? this.staffMemberState,
      addStaffMemberState: addStaffMemberState ?? this.addStaffMemberState,
      deleteStaffMemberState:
          deleteStaffMemberState ?? this.deleteStaffMemberState,
      updateStaffMemberState:
          updateStaffMemberState ?? this.updateStaffMemberState,
    );
  }
}
