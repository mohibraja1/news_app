
import 'dart:async';

import 'package:news_app/repo/authentication_service.dart';
import 'package:news_app/viewmodels/MyBaseViewModel.dart';

class LoginVM extends MyBaseViewModel {

  bool apiCallStarted = false;

  var apiInProgress = false;
  bool firstAnimStarted = false;
  bool firstAnimCompleted = false;


  Timer? _timer;

  @override
  initialise() {

    changeAnimationStatus(false);

  }
  void loginToFirebase(String userName, String userPassword,
      AuthenticationService authenticationService) {
    setApiInProcessResult(true,false);
    authenticationService
        .signUp(
          email: userName,
          password: userPassword,
        )
        .then((value) => {
              setApiInProcessResult(false,true),
              if (value)
                {
                  //MR: user has sign up scuccessfully now we will update name
                  // updatingUserName(bloc, nameController.text.trim())
                }
              else
                {
                  // bloc.toast('signup failed')}
                }
            });
  }

  void changeAnimationStatus(bool isCallStarted) {
    notifyListeners();
    apiCallStarted = isCallStarted;
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void setApiInProcessResult(bool value, bool shouldDelay) {

    var delay = shouldDelay ? 8 : 0;

    _timer = new Timer(Duration(seconds: delay), () {

      log('setApiCallGotResult value - =$value');
      notifyListeners();
      apiInProgress = value;

    });
  }
}
