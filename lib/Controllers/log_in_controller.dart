import 'dart:async';

import 'package:flutter/material.dart';
import 'package:listenmoe/Controllers/player_controller.dart';
import 'package:listenmoe/Models/enums.dart';
import 'package:listenmoe/Requests/listenMoe+requests.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LoginController extends StatelessWidget {
  final TextEditingController _usernameField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final controller = _Transformer();
  
  final _errorMessage = ValueNotifier<String>(null);
  final _isAuthenticating = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      top: true,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 50,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/images/listenMoeIcon.png')),
                ),

                StreamBuilder<String>(
                  stream: controller.usernameStream,
                  builder: (context, snapshot) {
                    return _InputtingText(controller: _usernameField, icon: Icons.supervised_user_circle, hint: 'Username or Email', onCallback: controller.usernameChanged );
                  }
                ),

                StreamBuilder<String>(
                  stream: controller.passwordStream,
                  builder: (context, snapshot) {
                    return _InputtingText(controller: _passwordField, hint: 'Password',icon: Icons.lock,  isObscured: true, onCallback: controller.passwordChanged, );
                  }
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 55,
                                    child: StreamBuilder<bool>(
                                      stream: controller.submitCheck,
                                      builder: (context, snapshot) {
                      return FlatButton(
                      color: Colors.pinkAccent,
                      disabledColor: Colors.pink.shade200,
                      onPressed: snapshot.hasData ?  () => _signIn(context) : null,
                      child:  ValueListenableBuilder(
                        valueListenable: _isAuthenticating,
                        builder: (context, bool value, _) =>
                          !value ? Text(
                          'SIGN IN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),
                        ) : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white),),
                      ) 
                    );
                                      }
                                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ValueListenableBuilder<String>(
                    valueListenable: _errorMessage,
                    builder: (context,value, _)=>
                     Text(
                       value ?? '',
                       style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                )
              ]),
        ),
      ),
    ));
  }

  _signIn(BuildContext context) async {
    //Disable the keyboard
    FocusScope.of(context)..unfocus();
    
    _errorMessage.value = null;
String _user = _usernameField.text;
                        String _pass = _passwordField.text;
                        if (_user.length > 3 && _pass.length > 3) {
                        _isAuthenticating.value = true;
                         var auth = await  ListenMoeRequests().authenticateUser(username: _user, password: _pass);
                         if (auth == 200) {

                           _isAuthenticating.value = false;
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => PlayerController(radioChoice: RadioChoice.jpop))
                            ).whenComplete(() => controller?.dispose());
                           
                         } else {
                           _isAuthenticating.value = false;
                           _errorMessage.value = auth.returnStatusMessages;
                           
                           

                         }
                        } 
  }
}

class _InputtingText extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isObscured;
  final Function(String) onCallback;
  _InputtingText({this.controller, this.hint, this.onCallback, this.icon, this.isObscured = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.grey.shade700,
          ),
          height: 75,
          width: MediaQuery.of(context).size.width - 50,
          child: Row(
            children: <Widget>[
              Container(
                  color: Colors.black54,
                  width: 75,
                  height: double.infinity,
                  child: Icon(
                    icon,
                    size: 30,
                    color: Colors.grey,
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: TextField(
                    onChanged: onCallback,
                    obscureText: isObscured,
                    decoration: InputDecoration(
                        hoverColor: Colors.white,
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        hintText: hint,
                        hintStyle: TextStyle(color: Colors.white60)),
                    controller: controller,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class _Transformer {

    var _usernameStream = BehaviorSubject<String>();
    var _passwordStream  = BehaviorSubject<String>();

    Function(String) get usernameChanged => _usernameStream.sink.add;
    Function(String) get passwordChanged => _passwordStream.sink.add;

    Stream<String> get usernameStream => _usernameStream.stream;
    Stream<String> get passwordStream => _passwordStream.stream;
      Stream<bool> get submitCheck => Rx.combineLatest2(usernameStream, passwordStream, (user, pass) => true);


    Future<void> dispose() {
      _usernameStream.close();
      _passwordStream.close();
      return Completer().future;
    }
}

extension _ErrorCodes on int {
  String get returnStatusMessages {
    switch(this) {
      //Client side problem
      case 400: return 'Invalide data was provided';
      //Unauthorized
      case  401: return 'Incorrect Username or Password was provided';
      case 403: return 'Account has been deactivated. See website for details';
      default: return null;
    }
  }
}