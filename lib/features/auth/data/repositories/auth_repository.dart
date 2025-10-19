import 'package:hungry/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:hungry/features/auth/data/models/user_model.dart';

/// Repository layer: Calls DataSource, adds business logic if needed.
/// Can handle local/remote switching later.
/// Modify to inject DataSource (e.g., via locator).
class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource = AuthRemoteDataSource();

  Future<UserModel> login(String email, String password) async {
    // Add logic if needed (e.g., cache user)
    return await _remoteDataSource.login(email, password);
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    String? image,
  }) async {
    // Add logic if needed
    return await _remoteDataSource.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
      image: image,
    );
  }

  Future<void> logout() async {
    // Add logic if needed (e.g., clear cache)
    return await _remoteDataSource.logout();
  }

  Future<UserModel> getCurrentUser() async {
    return await _remoteDataSource.getCurrentUser();
  }

  Future<UserModel> updateUser({
    required String name,
    required String email,
    required String phone,
    String? image,
    String? address,
    String? visa,
  }) async {
    return await _remoteDataSource.updateUser(
      name: name,
      email: email,
      phone: phone,
      image: image,
      address: address,
      visa: visa,
    );
  }
}
