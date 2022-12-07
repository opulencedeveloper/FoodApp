import 'package:flutter/material.dart';

class PasswordObsure with ChangeNotifier {
    bool passwordObsureVal = true;

  bool confirmPasswordObsureVal = true;
    
    
    
    void passwordObsure() {

    passwordObsureVal = !passwordObsureVal;

    notifyListeners();

  }
    
    void confirmpasswordObsure() {

    confirmPasswordObsureVal = !confirmPasswordObsureVal;

    notifyListeners();

  }
    
    bool get passwordObsureMode {

    return passwordObsureVal;

  }
    
    bool get confirmpasswordObsureMode {

    return confirmPasswordObsureVal;

  }
    
} 