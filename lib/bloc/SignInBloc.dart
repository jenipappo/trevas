import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:trevas/mediator/SyndicatedAuthenticationMediator.dart';
import 'package:trevas/service/AuthenticationService.dart';

class SignInBloc {
  final AuthenticationService authService;
  final SyndicatedAuthenticationMediator syndicatedAuthenticationMediator;

  final _emailStream = BehaviorSubject<String>();
  final _passwordStream = BehaviorSubject<String>();
  final _loginSuccessful = StreamController<void>();
  final _forgotPasswordSuccessful = StreamController<void>();

  // inputs
  Sink<String> get email => _emailStream.sink;
  Sink<String> get password => _passwordStream.sink;

  // outputs
  Stream<void> get loginSuccessful => _loginSuccessful.stream;
  Stream<void> get forgotPasswordSuccessful => _forgotPasswordSuccessful.stream;

  SignInBloc(this.authService, this.syndicatedAuthenticationMediator);

  login() async {
    var email = _emailStream.value;
    var password = _passwordStream.value;
    await authService.loginWithCredentials(email, password);

    _loginSuccessful.add(null);
  }

  loginWithGoogle() async {
    var result = await syndicatedAuthenticationMediator.signInWithGoogle();
    await authService.loginWithGoogle(result.user, result.idToken, result.accessToken);

    _loginSuccessful.add(null);
  }

  forgotPassword() async {
    var email = _emailStream.value;
    await authService.forgotPassword(email);

    _forgotPasswordSuccessful.add(null);
  }
}