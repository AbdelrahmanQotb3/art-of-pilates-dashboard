import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/model/staff_members_model.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/use_cases/staff_members_use_case.dart';
import 'package:pilates_dashboard/app/features/staff_tab/presentation/view_model/staff_members_states.dart';

@injectable
class StaffMembersViewModel extends Cubit<StaffMembersStates> {
  StaffMembersUseCase staffMembersUseCase;
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController customActionController = TextEditingController();
  StaffMembersViewModel(this.staffMembersUseCase) : super(StaffMembersStates());

  Future<void> doIntent() async {
    await getStaffMembers();
  }

  Future<BaseResponse<StaffMembersModel>> getStaffMembers() async {
    emit(
      state.copyWith(
        staffMembersState: BaseState<StaffMembersModel>(isLoading: true),
      ),
    );
    final response = await staffMembersUseCase.getStaffMembers();
    switch (response) {
      case SuccessResponse<StaffMembersModel>():
        emit(
          state.copyWith(
            staffMembersState: BaseState<StaffMembersModel>(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
      case ErrorResponse<StaffMembersModel>():
        emit(
          state.copyWith(
            staffMembersState: BaseState<StaffMembersModel>(
              isLoading: false,
              errorMessage: response.error.toString(),
            ),
          ),
        );
    }
    return response;
  }

  Future<bool> addStaffMember(
    String name,
    String email,
    String? phone,
    String customAction,
    bool? visibility,
  ) async {
    emit(
      state.copyWith(
        addStaffMemberState: BaseState<StaffMemberEntity>(isLoading: true),
      ),
    );
    final response = await staffMembersUseCase.addStaffMember(
      name,
      email,
      phone,
      customAction,
      visibility!,
    );
    switch (response) {
      case SuccessResponse<StaffMemberEntity>():
        emit(
          state.copyWith(
            addStaffMemberState: BaseState<StaffMemberEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return true;
      case ErrorResponse<StaffMemberEntity>():
        emit(
          state.copyWith(
            addStaffMemberState: BaseState<StaffMemberEntity>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return false;
    }
  }

  @override
  Future<void> close() {
    searchController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    customActionController.dispose();
    return super.close();
  }
}
