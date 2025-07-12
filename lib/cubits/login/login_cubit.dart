import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/login_services.dart';
import '../../services/storage_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiService apiService;
  final StorageService storageService;

  LoginCubit(this.apiService, this.storageService) : super(LoginInitial());

  Future<void> login(String username, String password) async {
    emit(LoginLoading());
    try {
      final token = await apiService.login(username, password);
      if (token.isNotEmpty) {
        await storageService.saveToken(token);
        emit(LoginSuccess(token: token));
      } else {
        emit(LoginFailure('Invalid credentials'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
