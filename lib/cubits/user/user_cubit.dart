import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_data/user_model.dart';

import '../../services/user_service.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final ApiService apiService;

  UserCubit(this.apiService) : super(UserInitial());

  void fetchUser(int id) async {
    emit(UserLoading());

    try {
      final response = await apiService.getUser(id);
      final user = UserModel.fromJson(response.data);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError('Failed to fetch user data'));
    }
  }
}
