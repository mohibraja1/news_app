import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';
import 'package:news_app/repo/authentication_service.dart';
import 'package:news_app/ui/sign_up_page.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  HashMap<String, dynamic> resultMap = new HashMap();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment.center,
            //Center Column contents horizontally,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextField(
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
                    context
                        .read<AuthenticationService>()
                        .signIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        )
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
              Container(
                height: 180,
              )
            ],
          ),
        ),
      ),
    );
  }

  goSignUpScreen(BaseBlock bloc, BuildContext context) async {
    var results =
        await Navigator.of(context).push(new MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return new SignUpPage();
      },
    ));

    log('getting res');
    if (results != null && results.containsKey('isLoggedIn')) {
      log('isLoggedIn');
      bool value = results['isLoggedIn'];
      if (value) {
        bloc.goBackScreen(results);
      }
    } else {
      log('control should not come her');
    }
  }
}
