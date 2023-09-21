import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:realm/realm.dart';
import 'package:todorealm/core/google/google_auth_service.dart';

class RealmService {
  User? loggedInuser;
  late App app;
  late Realm realmHelper;
  late final GoogleAuthService _googleAuthService;

  RealmService(GoogleAuthService googleAuthService)
      : app = App(AppConfiguration(dotenv.env['APPLICATION_ID']!)),
        _googleAuthService = googleAuthService;

  Future<void> loginWithGoogle() async {
    try {
      final user = await _googleAuthService.signInWithGoogle();
      log(user.toString(), name: 'Realm Service - Login with Google');
    } catch (e) {
      log('Error :', error: e.toString(), name: 'Realm Service - Login with Google');
    }
  }
}
