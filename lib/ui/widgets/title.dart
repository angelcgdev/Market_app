import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({
    Key? key,
    required double sizeHamburguerMenu,
  }) : _sizeHamburguerMenu = sizeHamburguerMenu, super(key: key);

  final double _sizeHamburguerMenu;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _sizeTitle = _size.width*.5;
    return Positioned(
      top: 0,
      left: (_size.width*.5)-(_sizeTitle/2),
      child: SafeArea(
        child: SizedBox(
          height: _sizeHamburguerMenu,
          width: _sizeTitle,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('ALL PRODUCTS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Icon(Icons.keyboard_arrow_down)
              ],
          ))
        )
      ),
    );
  }
}