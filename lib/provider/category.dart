import 'package:flutter/cupertino.dart';
import 'package:store_app/ui/home.dart';

class CategoryProvider with ChangeNotifier {
  category _categorySelected = category.clocks;

  category get getCategory => _categorySelected;

  void changeCategory(category newCategory) {
    _categorySelected = newCategory;
    notifyListeners();
  }

}