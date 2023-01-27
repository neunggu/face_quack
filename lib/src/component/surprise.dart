import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Surprise extends StatefulWidget{
  final img;
  final duration;
  const Surprise({Key? key, this.img = 'assets/images/face_quack.png', this.duration=1000}) : super(key: key);

  @override
  _SurpriseState createState() => _SurpriseState();
}
class _SurpriseState extends State<Surprise> with TickerProviderStateMixin{
  AnimationController? _animationController;
  List<Animation<double>> _animations = [];
  bool _visible = true;

  @override
  void initState() {
    super.initState();

    _initAnimation();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _visible = false;
      });
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: widget.duration),
        opacity: _visible? 1.0: 0.0,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.deepOrange.withOpacity(0)),
          child: AnimatedBuilder(
            animation: _animationController!,
            builder: (context, child) {
              return Container(
                // padding: EdgeInsets.all(10),
                width: _animations[0].value,
                height: _animations[0].value,
                child: Image.asset(widget.img),
              );
            },
          ),
        ),
      ),
    );
  }

  void _initAnimation() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration))
      ..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
        }
        if (status == AnimationStatus.completed) {
        }
        if (status == AnimationStatus.dismissed) {
        }
      });
    _animations.add(
        Tween<double>(begin:10, end: 700).animate(_animationController!));

    AudioPlayer().play(AssetSource('sounds/duck_default_sound.mp3'), mode: PlayerMode.lowLatency)
        .whenComplete(() =>_animationController!.forward());

  }

}