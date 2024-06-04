import 'package:auth_client/auth_client.dart';
import 'package:db_client/common.dart';
import 'package:models/models.dart';

class AuthRepository {
  final AuthClient authClient;
  final DbClient dbClient;

  const AuthRepository({
    required this.authClient,
    required this.dbClient,
  });

  Stream<User?> get authStateChanges => authClient.authStateChanges;

  User get currentUser => authClient.currentUser ?? User.anonymous;

  Future<bool> register({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    try {
      final user = await authClient.register(
        email: email,
        password: password,
      );

      return (user == null) ? false : true;
    } catch (error, stackTrace) {
      rethrow;
      // Error.throwWithStackTrace(LoginWithGoogleFailure(error), stackTrace);
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authClient.login(email: email, password: password);
      if (user == null) {
        return false;
      }

      return true;
    } catch (error, stackTrace) {
      rethrow;
      // Error.throwWithStackTrace(LoginWithGoogleFailure(error), stackTrace);
    }
  }

  Future<void> loginWithApple() async {
    try {
      await authClient.loginWithApple();
    } on LoginWithAppleFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LoginWithAppleFailure(error), stackTrace);
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      await authClient.loginWithGoogle();
    } on LoginWithGoogleFailure {
      rethrow;
    } on LoginWithGoogleCanceled {
      rethrow;
    } catch (error, stackTrace) {
      rethrow;
      // Error.throwWithStackTrace(LoginWithGoogleFailure(error), stackTrace);
    }
  }

  Future<void> loginWithFacebook() async {
    try {
      await authClient.loginWithFacebook();
    } on LoginWithFacebookFailure {
      rethrow;
    } on LoginWithFacebookCanceled {
      rethrow;
    } catch (error, stackTrace) {
      rethrow;
      // Error.throwWithStackTrace(LoginWithFacebookFailure(error), stackTrace);
    }
  }

  Future<void> logout() async {
    try {
      await authClient.logout();
    } catch (error, stackTrace) {
      rethrow;
      // Error.throwWithStackTrace(LoginWithGoogleFailure(error), stackTrace);
    }
  }

  Future<void> deleteAccount() async {
    try {
      await authClient.deleteAccount();
    } catch (err, stackTrace) {
      rethrow;
      // Error.throwWithStackTrace(LoginWithGoogleFailure(error), stackTrace);
    }
  }
}
