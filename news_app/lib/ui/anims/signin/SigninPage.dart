import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/repo/authentication_service.dart';
import 'package:news_app/ui/anims/signin/LoginViewModel.dart';
import 'package:news_app/utils/Utils.dart';

import 'package:flutter/animation.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:stacked/stacked.dart';
import 'SignInButtonAnimating.dart';
import 'package:provider/provider.dart';



class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignInState();
  }
}

class SignInState extends State<SignInPage> with TickerProviderStateMixin {

  late AnimationController _loginButtonController;

  @override
  void initState() {
    super.initState();

    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 16000), vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    var _formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return ViewModelBuilder<LoginVM>.reactive(
      viewModelBuilder: () => LoginVM(),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: Container(
            child: SafeArea(
              child: Stack(
                children: [

                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null ||
                                      !Utils.isEmailValid(value)) {
                                    return "Please enter valid email.";
                                  }
                                },

                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                obscureText: true,
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),

                  Container(
                      alignment: FractionalOffset.center,
                      child: !viewModel.apiCallStarted
                          ? GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  var email =
                                      emailController.text.toString().trim();
                                  var password =
                                      passwordController.text.toString().trim();

                                  viewModel.changeAnimationStatus(true);
                                  _playAnimation();

                                  viewModel.loginToFirebase(email, password, context.read<AuthenticationService>());


                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: new BorderRadius.all(
                                        const Radius.circular(30.0)),
                                  ),
                                  margin: EdgeInsets.only(left: 22, right: 22),
                                  height: 60,
                                  child: Center(child: Text('Login My App'))),
                            )
                          : animateSignInButtonAndCallApi(buttonController: _loginButtonController,loginVM: viewModel,))
                ],
              ),
            ),
          )),
    );
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      // await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }
}
