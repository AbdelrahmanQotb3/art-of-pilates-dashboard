import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/model/delete_staff_member_model.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/model/staff_members_model.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/use_cases/staff_members_use_case.dart';
import 'package:pilates_dashboard/app/features/staff_tab/presentation/view_model/staff_members_states.dart';

@injectable
class StaffMemberViewModel extends Cubit<StaffMembersStates> {
  StaffMembersUseCase staffMembersUseCase;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController customActionController = TextEditingController();
  TextEditingController visibilityController = TextEditingController();
  StaffMemberViewModel(this.staffMembersUseCase) : super(StaffMembersStates());
  Future<BaseResponse<StaffMemberEntity>> getStaffMember(int id) async {
    emit(
      state.copyWith(
        staffMemberState: BaseState<StaffMemberEntity>(isLoading: true),
      ),
    );
    final response = await staffMembersUseCase.getStaffMember(id);
    switch (response) {
      case SuccessResponse<StaffMemberEntity>():
        emit(
          state.copyWith(
            staffMemberState: BaseState<StaffMemberEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        break;
      case ErrorResponse<StaffMemberEntity>():
        emit(
          state.copyWith(
            staffMemberState: BaseState<StaffMemberEntity>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        break;
    }
    return response;
  }

  Future<bool> deleteStaffMember(int index, String id) async {
    emit(
      state.copyWith(
        deleteStaffMemberState: BaseState<DeleteStaffMemberModel>(
          isLoading: true,
        ),
      ),
    );
    final response = await staffMembersUseCase.deleteStaffMember(index, id);
    switch (response) {
      case SuccessResponse<DeleteStaffMemberModel>():
        emit(
          state.copyWith(
            deleteStaffMemberState: BaseState<DeleteStaffMemberModel>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return true;
      case ErrorResponse<DeleteStaffMemberModel>():
        emit(
          state.copyWith(
            deleteStaffMemberState: BaseState<DeleteStaffMemberModel>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return false;
    }
  }

  Future<bool> updateStaffMember(
    int index,
    String? name,
    String? email,
    String? phone,
    String? customAction,
    bool? visibility,
  ) async {
    emit(
      state.copyWith(
        updateStaffMemberState: BaseState<StaffMemberEntity>(isLoading: true),
      ),
    );
    final response = await staffMembersUseCase.updateStaffMember(
      index,
      name,
      email,
      phone,
      customAction,
      visibility,
    );
    switch (response) {
      case SuccessResponse<StaffMemberEntity>():
        emit(
          state.copyWith(
            updateStaffMemberState: BaseState<StaffMemberEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return true;
      case ErrorResponse<StaffMemberEntity>():
        emit(
          state.copyWith(
            updateStaffMemberState: BaseState<StaffMemberEntity>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return false;
    }
  }
}
