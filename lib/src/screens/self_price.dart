import 'dart:io';

import 'package:face_quack/src/component/waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:face_quack/src/component/app_bar.dart';
import 'package:face_quack/src/component/photo.dart';
import 'package:face_quack/src/models/face.dart';

class SelfPrice extends StatefulWidget {
  const SelfPrice({super.key});

  @override
  _SelfPriceState createState() => _SelfPriceState();
}

class _SelfPriceState extends State<SelfPrice> {
  final TextEditingController  _textController = TextEditingController();
  late bool _loaded;
  // late Image myPhoto;

  @override
  void initState() {
    super.initState();
    var face = context.read<FaceModel>();
    _loaded = false;
    // myPhoto = Image.file(File(face.imagePath), fit: BoxFit.contain);
    Future.delayed(const Duration(milliseconds:500),(){
      setState(() {
        _loaded = true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var face = context.read<FaceModel>();
    precacheImage(face.photo.image, context);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat usFormat = NumberFormat.decimalPattern('en_us');
    var face = context.read<FaceModel>();
    return Scaffold(
        extendBodyBehindAppBar:true,
        appBar: QuackAppBar(),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 0),
                  child: Column(
                      children: [
                        _loaded ? Photo(face.photo) : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                            child: Container (
                                height: 280,
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                child: Waiting(opacity: 0,)
                            ),
                          ),
                        Text(
                          'What price do you think?',
                          style: Theme.of(context).textTheme.headline6
                              ?.merge(TextStyle(height:4)),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              SizedBox(
                                width: 250,
                                child: TextFormField(
                                  controller: _textController,
                                  decoration: const InputDecoration(
                                    hintText: '0 ~ 999',
                                  ),
                                  textAlign: TextAlign.center,
                                  // keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  maxLength: 3,
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
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            var p = int.parse(_textController.text);
                            face.selfPrice = usFormat.format(p);
                            // overlay.showWaiting(true);
                            Future.delayed(const Duration(milliseconds:500),(){
                              // overlay.showWaiting(false);
                              Navigator.pushReplacementNamed(context, '/result');
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Confirm'),
                        )
                      ]
                  )
              )
          ),
        )
    );
  }
}
