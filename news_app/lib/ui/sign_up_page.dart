import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/blocs/BaseBlock.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';
import 'package:news_app/repo/authentication_service.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  HashMap<String, dynamic> resultMap = new HashMap();

  final TextEditingController nameController = TextEditingController();
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
        title: Text('Sign Up Account', style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Display Name",
              ),
            ),
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
                  if (nameController.text.trim().isEmpty) {
                    bloc.toast('Name can not be empty');

                    return;
                  }

                  if (emailController.text.trim().isEmpty) {
                    bloc.toast('email can not be empty');

                    return;
                  }

                  if (passwordController.text.trim().isEmpty) {
                    bloc.toast('email can not be empty');

                    return;
                  }

                  context
                      .read<AuthenticationService>()
                      .signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      )
                      .then((value) => {
                            if (value)
                              {
                                updatingUserName(bloc, nameController.text.trim())
                              }
                            else
                              {bloc.toast('authentication failed')}
                          });
                },
                child: Text("Sign up Account"),
              ),
            ),
          ],
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
    }else{
      bloc.toast('User is Null');
    }
  }
}
