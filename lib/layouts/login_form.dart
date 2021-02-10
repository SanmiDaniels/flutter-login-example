import 'package:flutter/material.dart';
import 'package:login_test/model/login_request.dart';
import 'package:login_test/services/user_service.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  UserService _userService = new UserService();

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: emailEditingController,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Email',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          TextFormField(
            obscureText: true,
            controller: passwordEditingController,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a valid password';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: <Widget>[
                Visibility(
                    visible: !this._loading,
                    child: FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _loading = !_loading;
                          });
                          _userService
                              .login(new LoginRequest(
                                  email: emailEditingController.text,
                                  password: passwordEditingController.text))
                              .then((onValue) => {
                                    setState(() {
                                      showAlertDialog(
                                          context, onValue.values.elementAt(1));
                                      _loading = !_loading;
                                    })
                                  })
                              .catchError((onError) => {
                                     setState(() {
                                      showAlertDialog(
                                          context, "An error occured");
                                      _loading = !_loading;
                                    })
                                  
                                  });
                        }
                      },
                      child: Text('Login'),
                    )),
                Visibility(
                  visible: this._loading,
                  child: CircularProgressIndicator(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, String message) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
