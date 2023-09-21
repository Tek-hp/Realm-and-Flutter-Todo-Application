import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    final user = await _googleSignIn.signIn();

    return user;
  }

  Future<dynamic> signOutFromGoogle() async {
    final result = await _googleSignIn.signOut();

    return result;
  }
}
