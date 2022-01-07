import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_app/const/const.dart';
import 'package:store_app/data/categorys.dart';
import 'package:store_app/models/category.dart';
import 'package:store_app/provider/animate.dart';
import 'package:store_app/provider/category.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
    required AnimationController animationController,
  }) : _animationController = animationController, super(key: key);

  final AnimationController _animationController;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
late Animation<double> _animationDrawer;
// late Animation<double> _animationOnTap;
// final ValueNotifier<bool> _isDrawerOpen = ValueNotifier(false);
  @override
  void initState() {
    super.initState();    
    _animationDrawer = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: widget._animationController, curve: const Interval(0.500, 0.700, curve: Curves.ease)));
    // _animationOnTap = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: widget._animationController, curve: const Interval(0.600, 1.0, curve: Curves.ease)));
  }
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;
    final _sizeStatusBar = MediaQuery.of(context).viewPadding.top;
    final _widthDrawer = lerpDouble(0, _size.width,  _animationDrawer.value)!;
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      width: _widthDrawer,
      child: Stack(
        children: [
          AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarIconBrightness: _animationDrawer.value>.5? Brightness.light: Brightness.dark
            ),
            child: Container(
              color: _theme.primaryColor,
              child: _size.width==_widthDrawer?
              BodyDrawer(sizeStatusBar: _sizeStatusBar, width: _widthDrawer, animationController: widget._animationController,):null,
            ),
          ),
          // TODO: create effect ontap here
          // if(widget._animationController.status!=AnimationStatus.dismissed)
          // Positioned(
          //   left: lerpDouble(defaultPadding, 0.0, _animationOnTap.value),
          //   top: _size.height*.45,
          //   // right: 0,
          //   width: lerpDouble(20, 0.0, _animationOnTap.value),
          //   bottom: _size.height*.45,
          //   child: Container(color: Colors.red)
          // )
        ],
      ),
    );
  }
}

class BodyDrawer extends StatefulWidget {
  const BodyDrawer({
    Key? key,
    required double sizeStatusBar,
    required double width,
    required AnimationController animationController,
    // required ValueNotifier<bool> isDrawerOpen,
  }) : _sizeStatusBar = sizeStatusBar, _width = width, _animationController = animationController, super(key: key);

  final double _sizeStatusBar;
  final double _width;
  final AnimationController _animationController;
  // final ValueNotifier<bool> _isDrawerOpen;

  @override
  State<BodyDrawer> createState() => _BodyDrawerState();
}

class _BodyDrawerState extends State<BodyDrawer> {

  @override
  void initState() {
    super.initState();
    // widget._isDrawerOpen.value = true;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: defaultPadding, top: defaultPadding+widget._sizeStatusBar, right: defaultPadding, bottom: defaultPadding),
      width: widget._width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          categorys.length, (i) => DrawerItem(category: categorys[i], animationController: widget._animationController)),
    
      ),
    );
  }
}

class DrawerItem extends StatefulWidget {
  const DrawerItem({
    Key? key,
    required Category category,
    required AnimationController animationController,
    // required ValueNotifier<bool> notifier,
  }) : _category = category, _animationController = animationController, super(key: key);

  final Category _category;
  final AnimationController _animationController;

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  // final ValueNotifier<bool> _notifier;
  late Animation<double> _animationDrawer;


  @override
  void initState() {
    super.initState();
    _animationDrawer = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: widget._animationController, curve: const Interval(0.700, 1.0, curve: Curves.easeInOut)));
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _theme = Theme.of(context);
    final _dxPosition = lerpDouble(30, 0, _animationDrawer.value)!;
    return GestureDetector(
      onTap: (){
        widget._animationController.reverse();
        context.read<CategoryProvider>().changeCategory(widget._category.value);
        context.read<AnimateProvider>().animate(true);
      },
      child: ClipRect(
        child: Container(
          width: _size.width,
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Transform.translate(
              offset: Offset(0,_dxPosition),
              child: Text('-  ${widget._category.name}', style: _theme.textTheme.headline1?.copyWith(color: _theme.colorScheme.onPrimary), maxLines: 1, overflow: TextOverflow.ellipsis,),
          ),
        ),
      ),
    );
  }
}