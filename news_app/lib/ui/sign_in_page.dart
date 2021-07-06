import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';
import 'package:news_app/repo/authentication_service.dart';
import 'package:news_app/ui/sign_up_form.dart';
import 'package:news_app/utils/Utils.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  HashMap<String, dynamic> resultMap = HashMap();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();

    final bloc = BaseBlock(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // change your color here
        ),
        title: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(top : 20 ,left: 20, right: 20),
          child: Column(

            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || !Utils.isEmailValid(value)) {
                    return "Please enter valid email.";
                  }
                },
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return "Please enter password.";
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

                      context.read<AuthenticationService>().signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),)
                          .then((value) => {
                                if (value)
                                  {
                                    resultMap.clear(),
                                    resultMap["isLoggedIn"] = value,
                                    bloc.goBackScreen(resultMap)
                                  }
                                else
                                  {bloc.toast('authentication failed')}
                              });
                    }
                  },
                  child: Text("Sign in"),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password',
                              style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline,
                              )))),
                  Container(
                    width: 30,
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            //MR : creating new account
                            goSignUpScreen(bloc, context);
                          },
                          child: Text(
                            'Signup',
                            style: TextStyle(
                              color: Colors.green,
                              decoration: TextDecoration.underline,
                            ),
                          )))
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  goSignUpScreen(BaseBlock bloc, BuildContext context) async {
    var results = await Navigator.of(context).push(MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return SignUpForm();
      },
    ));

    //MR: getting result from signup screen
    if (results != null && results.containsKey('isLoggedIn')) {
      log('isLoggedIn');
      bool value = results['isLoggedIn'];
      if (value) {
        //MR: going back screen with results
        bloc.goBackScreen(results);
      }
    } else {
      log('control should not come her');
    }
  }
}
