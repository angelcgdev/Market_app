import 'package:flutter/cupertino.dart';

class AnimateProvider with ChangeNotifier {
  bool _startAnimation = false;
  bool _isFirstTime = true;

  bool get getStateAnimartion => _startAnimation;
  bool get isFirstTime => _isFirstTime;

  
  void animate(bool newStateAnimation) {
    _startAnimation = newStateAnimation;
    _isFirstTime = false;
    notifyListeners();
  }

}