import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:face_quack/src/models/face.dart';

class QuackAppBar extends StatelessWidget with PreferredSizeWidget{
  const QuackAppBar();

  @override
  Widget build(BuildContext context) {
    var face = context.read<FaceModel>();
    return AppBar(
      title: Text(face.nickname, style: Theme.of(context).textTheme.headline5,),
      backgroundColor: Color(0xFFffce3b),
      shadowColor: Colors.transparent,
      // elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);



}
