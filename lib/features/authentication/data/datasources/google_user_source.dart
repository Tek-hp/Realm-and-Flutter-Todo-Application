import 'package:google_sign_in/google_sign_in.dart';

abstract class GoogleUserSource {
  Future<GoogleSignInAccount?> signInUser();
  Future<GoogleSignInAccount?> signOutUser();
}

class GoogleUserSourceImpl implements GoogleUserSource {
  GoogleUserSourceImpl() : _googleSignIn = GoogleSignIn();

  late final GoogleSignIn _googleSignIn;

  @override
  Future<GoogleSignInAccount?> signInUser() async {
    final googleAccount = await _googleSignIn.signIn();
    return googleAccount;
  }

  @override
  Future<GoogleSignInAccount?> signOutUser() async {
    final googleAccount = await _googleSignIn.signOut();
    return googleAccount;
  }
}
