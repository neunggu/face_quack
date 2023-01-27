import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:face_quack/src/component/app_bar.dart';
import 'package:face_quack/src/component/photo.dart';
import 'package:face_quack/src/models/face.dart';
import 'package:face_quack/src/models/overlay.dart';


class Result extends StatefulWidget {
  const Result({super.key});
  @override
  _ResultState createState() => _ResultState();
}
class _ResultState extends State<Result> {
  int _getPrice() {
    var r = Random();
    var power = r.nextInt(3)+1;
    return r.nextInt(pow(10, power).toInt());
  }
  void quackEffect(BuildContext context){
    var overlay = context.read<OverlayModel>();
    overlay.showSurprise(true);
    Future.delayed(const Duration(milliseconds:500),(){
      overlay.showSurprise(false);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds:50),(){
        quackEffect(this.context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var face = context.read<FaceModel>();
    final p = _getPrice();
    NumberFormat usFormat = NumberFormat.decimalPattern('en_us');
    face.resultPrice = usFormat.format(p);
    return Scaffold(
        extendBodyBehindAppBar:true,
        appBar: QuackAppBar(),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 0),
                child: Column(
                    children: [
                      Photo(face.photo),
                      Text(
                        '${face.nickname}, Your price is',
                        style: Theme.of(context).textTheme.headline6
                            ?.merge(TextStyle(height:4)),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            SizedBox(
                              // width: 250,
                              child: Text(
                                face.resultPrice+"  ",
                                style: TextStyle(fontSize: 30),

                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                'Quack',
                              ),
                            ),
                          ]
                      ),
                      Text(
                        '(You set ${face.selfPrice} Quack)',
                        style: Theme.of(context).textTheme.bodyLarge
                            ?.merge(TextStyle(height:2)),
                      ),
                      // Container(
                      //   margin: EdgeInsets.all(30),
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       print("share");
                      //
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       foregroundColor: Colors.white,
                      //     ),
                      //     child: const Text('share'),
                      //   ),
                      // )
                    ]
                )
            )
        )
    );
  }
}

