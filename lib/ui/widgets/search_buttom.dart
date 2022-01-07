import 'package:flutter/material.dart';
import 'package:store_app/const/const.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key? key,
    required double sizeHamburguerMenu,
    required ThemeData theme,
  }) : _sizeHamburguerMenu = sizeHamburguerMenu, _theme = theme, super(key: key);

  final double _sizeHamburguerMenu;
  final ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _sizeHamburguerMenu*.05,
      right: defaultPadding,
      child: SafeArea(
        child: Container(
          width: _sizeHamburguerMenu*.9,
          height: _sizeHamburguerMenu*.9,
          decoration: BoxDecoration(
            color: _theme.primaryColor,
            borderRadius: BorderRadius.circular(_sizeHamburguerMenu*5)
          ),
          child: const Icon(Icons.search, color: Colors.white,),
        ),
      ),
    );
  }
}