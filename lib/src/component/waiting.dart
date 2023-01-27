import 'package:flutter/material.dart';

class Waiting extends StatefulWidget{
  final int numberOfDots;
  final duration;
  final double opacity;
  const Waiting({Key? key, this.numberOfDots = 5, this.duration=200, this.opacity=0.3}) : super(key: key);

  @override
  _WaitingState createState() => _WaitingState();
}
class _WaitingState extends State<Waiting> with TickerProviderStateMixin{
  List<AnimationController>? _animationControllers;
  List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    for (var controller in _animationControllers!) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.deepOrange.withOpacity(widget.opacity)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(widget.numberOfDots, (index) {
            return AnimatedBuilder(
              animation: _animationControllers![index],
              builder: (context, child) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Transform.translate(
                    offset: Offset(0, _animations[index].value),
                    child:
                      Image.asset('assets/images/quack.png', width: 15*(1+index/3),)
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _initAnimation() {
    _animationControllers = List.generate(
      widget.numberOfDots,
          (index) {
        return AnimationController(
            vsync: this, duration: Duration(milliseconds: widget.duration));
      },
    ).toList();

    for (int i = 0; i < widget.numberOfDots; i++) {
      _animations.add(
          Tween<double>(begin: 0, end: -20).animate(_animationControllers![i]));
    }

    for (int i = 0; i < widget.numberOfDots; i++) {
      _animationControllers![i].addStatusListener((status) {
        //On Complete
        if (status == AnimationStatus.completed) {
          //return of original postion
          _animationControllers![i].reverse();
          //if it is not last dot then start the animation of next dot.
          if (i != widget.numberOfDots - 1) {
            _animationControllers![i + 1].forward();
          }
        }
        //if last dot is back to its original postion then start animation of the first dot.
        // now this animation will be repeated infinitely
        if (i == widget.numberOfDots - 1 &&
            status == AnimationStatus.dismissed) {
          _animationControllers![0].forward();
        }
      });
    }

    //trigger animtion of first dot to start the whole animation.
    _animationControllers!.first.forward();
  }

}