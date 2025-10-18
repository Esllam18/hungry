import 'package:hungry/core/api/pref_helper.dart';
import 'package:hungry/features/auth/data/repositories/auth_repository.dart';
import 'package:hungry/features/auth/persantation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository = AuthRepository();

  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _repository.login(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    String? image,
  }) async {
    emit(AuthLoading());
    try {
      final user = await _repository.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
        image: image,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _repository.logout();
      emit(AuthInitial()); // Reset to initial state on logout
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Check if a user is logged in by verifying the presence of a token
  Future<bool> isLoggedIn() async {
    final token = await PrefHelper.getToken();
    return token != null && token.isNotEmpty;
  }
}
