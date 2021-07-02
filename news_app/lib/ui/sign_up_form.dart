import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';
import 'package:news_app/repo/authentication_service.dart';
import 'package:news_app/utils/Utils.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _state();
  }
}

class _state extends State<SignUpForm> {
  HashMap<String, dynamic> resultMap = new HashMap();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BaseBlock(context);
    var _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // change your color here
        ),
        title: Text(
          'Sign Up Account',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your display name";
                  }
                  ;
                },
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Display Name",
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty || !Utils.isEmailValid(value)) {
                    return "Please enter valid email";
                  }
                },
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.length < 4) {
                    return 'Please enter atleast 5 digits password';
                  }
                },
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 18),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<AuthenticationService>()
                          .signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          )
                          .then((value) => {
                                if (value)
                                  {
                                    updatingUserName(
                                        bloc, nameController.text.trim())
                                  }
                                else
                                  {bloc.toast('authentication failed')}
                              });
                    } else {
                      log('validation faled');
                    }
                  },
                  child: Text("Sign up Account"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  updatingUserName(BaseBlock bloc, String name) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.updateDisplayName(name).then((value) => {
            log('value coming back'),
            resultMap.clear(),
            resultMap["isLoggedIn"] = true,
            bloc.goBackScreen(resultMap),
          });
    } else {
      bloc.toast('User is Null');
    }
  }
}


