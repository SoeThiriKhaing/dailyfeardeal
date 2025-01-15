import '../repositories/auth_repository.dart';

class AuthService {
  final AuthRepository authRepository;

  AuthService({required this.authRepository});

  Future<String?> login(String email, String password) async {
    return await authRepository.login(email, password);
  }

  Future<String?> register(String name, String email, String password) async {
    return await authRepository.register(name, email, password);
  }
}
