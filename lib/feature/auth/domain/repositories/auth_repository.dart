import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(String email, String password);
  Future<Either<Failure, void>> signup(
    String email,
    String password,
    String name,
  );
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserModel?>> getCurrentUser();
  Future<Either<Failure, void>> signInWithGoogle();
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
  // Future<Either<Failure, void>> confirmPasswordReset(String code, String newPassword);
}
