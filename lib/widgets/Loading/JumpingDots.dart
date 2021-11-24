import 'package:flutter/material.dart';

import 'package:dutstore/config/AppColors.dart';

class JumpingDots extends StatefulWidget {
  final int numberOfDots;
  final double height;
  const JumpingDots({Key? key, this.numberOfDots = 3, this.height = 40})
      : super(key: key);

  @override
  _JumpingDotsState createState() => _JumpingDotsState();
}

class _JumpingDotsState extends State<JumpingDots>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;

  List<Animation<double>> _animations = [];

  int animationDuration = 200;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.numberOfDots,
            (index) {
              return AnimatedBuilder(
                animation: _animationControllers[index],
                builder: (context, child) {
                  return Container(
                    padding: EdgeInsets.all(2.5),
                    child: Transform.translate(
                      offset: Offset(0, _animations[index].value),
                      child: DotWidget(
                        size: widget.height / 4,
                      ),
                    ),
                  );
                },
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  void _initAnimation() {
    _animationControllers = List.generate(
      widget.numberOfDots,
      (index) {
        return AnimationController(
          vsync: this,
          duration: Duration(milliseconds: animationDuration),
        );
      },
    ).toList();

    for (int i = 0; i < widget.numberOfDots; i++) {
      _animations.add(
        Tween<double>(begin: 0, end: -20).animate(_animationControllers[i]),
      );
    }

    for (int i = 0; i < widget.numberOfDots; i++) {
      _animationControllers[i].addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationControllers[i].reverse();

          if (i != widget.numberOfDots - 1) {
            _animationControllers[i + 1].forward();
          }
        }

        if (i == widget.numberOfDots - 1 &&
            status == AnimationStatus.dismissed) {
          _animationControllers[0].forward();
        }
      });
    }

    _animationControllers.first.forward();
  }
}

class DotWidget extends StatelessWidget {
  final double size;
  const DotWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor),
      height: size,
      width: size,
    );
  }
}
