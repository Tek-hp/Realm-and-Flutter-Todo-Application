import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:oktoast/oktoast.dart';

abstract class GoogleUserSource {
  Future<GoogleSignInAccount?> signInUser();
  Future<GoogleSignInAccount?> signOutUser();
}

class GoogleUserSourceImpl implements GoogleUserSource {
  GoogleUserSourceImpl() : _googleSignIn = GoogleSignIn();

  late final GoogleSignIn _googleSignIn;

  @override
  Future<GoogleSignInAccount?> signInUser() async {
    await signOutUser();

    final googleAccount = await _googleSignIn.signIn();

    try {
      // await _realmService.logInAnonymous();

      log('Logged in', name: 'Realm Login - Ann ::');
    } on Exception catch (e) {
      showToast('Could not log into Realm');
      log('', error: e.toString(), name: 'Realm Login - Ann ::');
    }

    return googleAccount;
  }

  @override
  Future<GoogleSignInAccount?> signOutUser() async {
    final googleAccount = await _googleSignIn.signOut();
    return googleAccount;
  }
}
