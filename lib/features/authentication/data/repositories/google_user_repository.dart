import 'package:google_sign_in/google_sign_in.dart';
import 'package:todorealm/core/service_locator/service_locator.dart';
import 'package:todorealm/features/authentication/data/datasources/google_user_source.dart';
import 'package:todorealm/features/authentication/domain/repositories/google_user_repository.dart';

class GoogleUserRepositoryImpl implements GoogleUserRepository {
  late final GoogleUserSource _remoteSource;

  GoogleUserRepositoryImpl() : _remoteSource = GoogleUserSourceImpl(locator());

  @override
  Future<GoogleSignInAccount?> signInUser() async {
    return await _remoteSource.signInUser();
  }

  @override
  Future<GoogleSignInAccount?> signOutUser() async {
    return await _remoteSource.signOutUser();
  }
}
