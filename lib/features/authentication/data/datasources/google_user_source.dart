import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:oktoast/oktoast.dart';
import 'package:realm/realm.dart';
import 'package:todorealm/core/realm/realm_service.dart';

abstract class GoogleUserSource {
  Future<GoogleSignInAccount?> signInUser();
  Future<GoogleSignInAccount?> signOutUser();
}

class GoogleUserSourceImpl implements GoogleUserSource {
  GoogleUserSourceImpl(RealmService realmService)
      : _googleSignIn = GoogleSignIn(),
        _realmService = realmService;

  late final RealmService _realmService;
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
