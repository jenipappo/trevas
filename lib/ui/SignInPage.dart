import 'package:flutter/material.dart';
import 'package:trevas/bloc/SignInBloc.dart';
import 'package:trevas/service/AuthenticationService.dart';
import 'package:trevas/mediator/SyndicatedAuthenticationMediator.dart';

class SignInPage extends StatelessWidget {

  final bloc = SignInBloc(AuthenticationService(), SyndicatedAuthenticationMediator());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 64.0, right: 64.0, top: 64.0, bottom: 64.0),
            child: Image.asset('assets/logo.png'),
          ),
          RaisedButton(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset('assets/google.png', height: 42.0),
                ),
                new Center(child: Text('Sign In With Google', style: TextStyle(color: Colors.white)))
              ],
            ),
            color: Colors.blue,
            onPressed: () => bloc.loginWithGoogle(),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Divider(height: 48.0),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Email',
              contentPadding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0)
              )
            ),
            validator: (text) {
              bloc.email.add(text);
              return text.contains("@") ? null : "Invalid email";
            },
          ),
          SizedBox(height: 8.0),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              contentPadding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0)
              )
            ),
            validator: (text) {
              bloc.email.add(text);
              return text.length >= 8 ? null : "Password must be 8 caracters long or more";
            },
          ),
          SizedBox(height: 24.0),
          RaisedButton(
            child: Text('Enter'),
            onPressed: () => bloc.login(),
          ),
          SizedBox(height: 8.0),
          MaterialButton(
            child: Text('Forgot your password?'),
            height: 42.0,
            onPressed: () => bloc.forgotPassword(),
          ),
        ],
      )
    );
  }

}