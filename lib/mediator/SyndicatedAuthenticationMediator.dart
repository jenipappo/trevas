import 'dart:async';
import 'package:trevas/model/User.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SyndicatedAuthenticationMediator  {

  Future<GoogleSignInResponse> signInWithGoogle() async {
    var googleUser = await GoogleSignIn(scopes: <String> [ 'profile', 'email' ]).signIn();
    var user = User(null, googleUser.photoUrl, googleUser.displayName, googleUser.email);
    var auth = await googleUser.authentication;

    return GoogleSignInResponse._(user, auth.idToken, auth.accessToken);
  }

}

class GoogleSignInResponse {
  final User user;
  final String idToken;
  final String accessToken;

  GoogleSignInResponse._(this.user, this.idToken, this.accessToken);
}