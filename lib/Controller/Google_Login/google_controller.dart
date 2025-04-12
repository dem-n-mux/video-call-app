import 'dart:developer';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  @override
  void onInit() async {
    super.onInit();
    _user = await _googleSignIn.signInSilently();
  }

  GoogleSignInAccount? get user => _user;

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      _user = googleUser;
      log(googleUser!.email.toString());
      return googleUser;
    } catch (error) {
      log('Error signing in with Google: $error');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      _user = null;
    } catch (error) {
      log('Error signing out: $error');
    }
  }
}
