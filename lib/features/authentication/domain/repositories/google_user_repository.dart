import 'package:google_sign_in/google_sign_in.dart';

abstract class GoogleUserRepository {
  Future<GoogleSignInAccount?> signInUser();
  Future<GoogleSignInAccount?> signOutUser();
}
