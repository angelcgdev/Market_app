import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/const/const.dart';
import 'package:store_app/models/product.dart';
import 'package:store_app/provider/animate.dart';

class CardProduct extends StatefulWidget {
  const CardProduct(
      {Key? key, required int order, required Product data, required double maxHeight})
      : _order = order,
        _product = data,
        _maxHeight = maxHeight,
        super(key: key);

  final int _order;
  final Product _product;
  final double _maxHeight;

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> with SingleTickerProviderStateMixin  {
  late AnimationController _animationControllerTransForm; 
  late Animation<double> _animation;
  late ThemeData _theme;
  late Size _size;
  final _degrees = 180;

  @override
  void initState() {
    super.initState();
    _animationControllerTransForm = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    final curve = CurvedAnimation(parent: _animationControllerTransForm, curve: Curves.easeIn);
    _animation = Tween<double>(begin: 0, end: pi * 4).animate(curve);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {_animate();});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = Theme.of(context);
    _size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    _animationControllerTransForm.dispose();
    super.dispose();
  }

  void _animate () {
    final _delayAnimation = !context.read<AnimateProvider>().isFirstTime?(500):0;
    final _intervalDuration = (200*widget._order)+_delayAnimation;
    Future.delayed(Duration(milliseconds: _intervalDuration),(){
        _animationControllerTransForm.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget._maxHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedBuilder(
            animation: _animation,
            child: Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  defaultPadding * .3,
                  defaultPadding * 2,
                  defaultPadding * .3,
                  defaultPadding * .5),
              child: Column(
                children: [
                  SizedBox(
                    height: widget._maxHeight * .4,
                    width: _size.width * .3,
                    child: Image.asset(
                      widget._product.path,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: defaultPadding * .5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.favorite_border, size: 16),
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(5),
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          elevation: 7),
                    ),
                  )
                ],
              ),
            ),
            elevation: 0,
              ),
            builder: (context, child){
              final _range = lerpDouble(-90, 0, _animationControllerTransForm.value)!;
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_range / _degrees * pi),
                alignment: Alignment.center,
                origin: const Offset(0, 0),
                child: child,
              );
            },
          ),
          const SizedBox(height: defaultPadding * .5),
          Flexible(
              child: SizedBox(
                  height: widget._maxHeight * .18,
                  child: Text(widget._product.name.toUpperCase(),
                      style: _theme.textTheme.headline3
                          ?.copyWith(color: _theme.colorScheme.onBackground),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis))),
          const SizedBox(
            height: defaultPadding * .5,
          ),
          Text(
            '${widget._product.price} USD',
            style: _theme.textTheme.headline4
                ?.copyWith(color: _theme.primaryColor),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
