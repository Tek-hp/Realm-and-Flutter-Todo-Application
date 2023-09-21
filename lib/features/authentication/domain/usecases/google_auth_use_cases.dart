import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todorealm/core/use_cases/usecases.dart';
import 'package:todorealm/features/authentication/domain/repositories/google_user_repository.dart';

typedef GoogleSignInResponse = Future<Either<String, GoogleSignInAccount>>;
typedef RegisterUserResponse = Future<Either<String, GoogleSignInAccount>>;

class GoogleSignInUseCase implements UseCase<GoogleSignInResponse, dynamic> {
  const GoogleSignInUseCase(this._repository);

  final GoogleUserRepository _repository;

  @override
  GoogleSignInResponse call(parms) async {
    try {
      final googleUser = await _repository.signInUser();

      if (googleUser != null) {
        return Right(googleUser);
      } else {
        return const Left('User null');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}

class GoogleSignOutUseCase implements UseCase<GoogleSignInResponse, dynamic> {
  const GoogleSignOutUseCase(this._repository);

  final GoogleUserRepository _repository;

  @override
  GoogleSignInResponse call(parms) async {
    try {
      final googleUser = await _repository.signOutUser();

      if (googleUser != null) {
        return Right(googleUser);
      } else {
        return const Left('User null');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}

class RegisterUserUseCase implements UseCase<RegisterUserResponse, dynamic> {
  const RegisterUserUseCase(this._repository);

  final GoogleUserRepository _repository;

  @override
  GoogleSignInResponse call(parms) async {
    try {
      final googleUser = await _repository.signInUser();

      if (googleUser != null) {
        return Right(googleUser);
      } else {
        return const Left('User null');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
