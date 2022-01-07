import 'dart:ui';
import 'package:flutter/material.dart';



class EffectButtom extends CustomPainter {

  final Color colorEffect;
  final double animationScale;
  final double animationBorder;
  final double maxSize;

  EffectButtom({required this.colorEffect, required this.animationScale, required this.animationBorder, required this.maxSize});

  @override
  void paint(Canvas canvas, size) {
    final paint = Paint();
    paint.color = colorEffect;
    // first circle
    final _fix = lerpDouble(0, maxSize*.5, animationScale)!;
    final _holeSize = (maxSize*.92)*_inverValur(animationBorder);

    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          // Path()..addRRect(RRect.fromLTRBR(_fix, _fix, size-_fix, size-_fix, Radius.circular(size))),
          Path()..addRRect(RRect.fromLTRBR(_fix, _fix, maxSize-_fix, maxSize-_fix, Radius.circular(maxSize))),
          Path()
            ..addRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(maxSize*.5, maxSize*.5), width: _holeSize, height: _holeSize), Radius.circular(maxSize)))
            ..close(),
        ),
        paint,
    );

    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>true;
  
  double _inverValur(double val){
    return 1.0-val;
  }

}