import 'package:flutter/cupertino.dart';

class AnimateProvider with ChangeNotifier {
  bool _startAnimation = false;

  bool get getStateAnimartion => _startAnimation;

  
  void animate(bool newStateAnimation) {
    _startAnimation = newStateAnimation;
    notifyListeners();
  }

}