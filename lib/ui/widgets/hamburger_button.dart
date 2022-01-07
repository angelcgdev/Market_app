import 'package:flutter/material.dart';
import 'package:store_app/const/const.dart';

import 'effect_buttom.dart';

class HamburgerMenuButton extends StatefulWidget {
  const HamburgerMenuButton({
    Key? key,
    required double sizeButtom,
    required AnimationController animationController,
  }) : _sizeHamburguerMenu = sizeButtom, _animationController = animationController, super(key: key);

  final double _sizeHamburguerMenu;
  final AnimationController _animationController;

  @override
  State<HamburgerMenuButton> createState() => _HamburgerMenuButtonState();
}

class _HamburgerMenuButtonState extends State<HamburgerMenuButton> {

  late ThemeData _theme;
  late Animation<double> _animatedIcon;
  late Animation<double> _animatedIconEffect;


  @override
  void initState() {
    super.initState();
    _animatedIcon = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: widget._animationController, curve: const Interval(0.0, 0.250, curve: Curves.easeInOut)));
    _animatedIconEffect = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: widget._animationController, curve: const Interval(0.250, 0.500, curve: Curves.easeInOut)));
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = Theme.of(context);
  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: defaultPadding-(widget._sizeHamburguerMenu*.25),
      child: SafeArea(
        child: GestureDetector(
          onTap: (){
            final _state = widget._animationController.status;
            if(_state == AnimationStatus.completed){
              widget._animationController.reverse();
            }else{
              widget._animationController.forward();
            }
          },
          child: SizedBox(
            height: widget._sizeHamburguerMenu,
            width: widget._sizeHamburguerMenu,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                AnimatedIcon(
                  progress: widget._animationController,
                  icon: AnimatedIcons.menu_close,
                  color: widget._animationController.value>.6?Colors.white:Colors.black,
                  size: widget._sizeHamburguerMenu*.5,
                ),
                Positioned(
                  height: widget._sizeHamburguerMenu,
                  width: widget._sizeHamburguerMenu,
                  child: Opacity(
                    opacity: widget._animationController.value>.6?0:1,
                    child: CustomPaint(
                      painter: EffectButtom(
                        maxSize: widget._sizeHamburguerMenu,
                        animationScale: _animatedIcon.value,
                        animationBorder: _animatedIconEffect.value,
                        colorEffect: _theme.primaryColor,
                      )
                    )
                  ),
                )
              ],
            ),
          )
          ),
      )
    );
  }
}