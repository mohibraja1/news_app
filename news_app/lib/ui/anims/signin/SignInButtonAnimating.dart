import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/repo/FireBaseDatabase.dart';
import 'package:news_app/ui/anims/signin/LoginViewModel.dart';

class animateSignInButtonAndCallApi extends StatefulWidget {

  final AnimationController buttonController;
  final LoginVM loginVM;

  animateSignInButtonAndCallApi(
      {Key? key, required this.buttonController, required this.loginVM})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AnimButton(buttonController: buttonController, loginVM: loginVM);
  }
}

class AnimButton extends State<animateSignInButtonAndCallApi>
    with SingleTickerProviderStateMixin {
  final LoginVM loginVM;
  final AnimationController buttonController;
  late Animation buttonSqueezeanimation;
  late Animation buttomZoomOut;

  AnimButton({Key? key, required this.buttonController, required this.loginVM})
      : super();

  @override
  void initState() {
    super.initState();

    buttonSqueezeanimation = Tween(
      begin: 320.0,
      end: 70.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController,
        curve: Interval(
          0.0,
          0.150,
        ),
      ),
    );

    buttomZoomOut = Tween(
      begin: 70.0,
      end: 1000.0,
    ).animate(
      CurvedAnimation(
        parent: buttonController,
        curve: Interval(
          0.550,
          0.999,
          curve: Curves.bounceOut,
        ),
      ),
    );


    buttonSqueezeanimation.addListener(() {
      log('buttonSqueezeanimation is = ${buttonSqueezeanimation.value}');
    });

    buttomZoomOut.addListener(() {
      log('buttomZoomOut is = ${buttomZoomOut.value}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Hero(
      tag: "fade",
      child: loginVM.apiInProgress
          ? Container(
              width: buttomZoomOut.value == 70
                  ? buttonSqueezeanimation.value
                  : buttomZoomOut.value,
              height: buttomZoomOut.value == 70 ? 60.0 : buttomZoomOut.value,
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: buttomZoomOut.value < 400
                    ? BorderRadius.all(const Radius.circular(30.0))
                    : BorderRadius.all(const Radius.circular(3.0)),
              ),
              child: buttonSqueezeanimation.value > 75.0
                  ? Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.3,
                      ),
                    )
                  : buttomZoomOut.value < 300.0
                      ? CircularProgressIndicator(
                          value: null,
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                      : null)
          : Container(
              width: buttomZoomOut.value,
              height: buttomZoomOut.value,
              decoration: BoxDecoration(
                shape: buttomZoomOut.value < 500
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                color: Colors.red,
              ),
            ),
    );
  }
}
