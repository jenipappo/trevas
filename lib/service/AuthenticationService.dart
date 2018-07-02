import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trevas/model/User.dart';

class AuthenticationService {

  Future<User> loginWithCredentials(String email, String password) async {
    return await
      FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((u) => _parseFirebaseUser(u));
  }

  Future<void> forgotPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<User> loginWithGoogle(User user, String idToken, String accessToken) async {
    var firebaseUser = await FirebaseAuth.instance.signInWithGoogle(idToken: idToken, accessToken: accessToken);
    return await _signUp(user, firebaseUser);
  }

  Future<User> signUpWithLoginAndPassword(User user, String password) async {
    var firebaseUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: password);
    return await _signUp(user, firebaseUser);
  }

  Future<User> currentUser() async {
    return FirebaseAuth.instance.currentUser().then((u) => _parseFirebaseUser(u));
  }

  Future<User> _signUp(User user, FirebaseUser firebaseUser) async {
    await firebaseUser.sendEmailVerification();

    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = user.name;
    userUpdateInfo.photoUrl = user.avatarImageUrl;

    await FirebaseAuth.instance.updateProfile(userUpdateInfo);

    return User(firebaseUser.uid, user.avatarImageUrl, user.name, user.email);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User _parseFirebaseUser(FirebaseUser firebaseUser) {
    return User(firebaseUser.uid, firebaseUser.photoUrl, firebaseUser.displayName, firebaseUser.email);
  }
}