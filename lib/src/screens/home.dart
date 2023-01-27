import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:face_quack/src/component/app_bar.dart';
import 'package:face_quack/src/models/face.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Future<void> _openModule(ImageSource source, {required BuildContext context,}) async {
      try {
        final XFile? pickedFile = await ImagePicker().pickImage(
          source: source,
          maxWidth: null,
          maxHeight: null,
          imageQuality: null,
        );
        var face = context.read<FaceModel>();
        face.imagePath = (pickedFile == null ? null : <XFile>[pickedFile][0].path)!;
        face.photo = Image.file(File(face.imagePath), fit: BoxFit.contain);
        // precacheImage(
        //   Image.file(File(face.photo)).image,
        //   context,
        // );
        Navigator.pushReplacementNamed(context, '/self_price');
      } catch (e) {

      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar:true,
      appBar: QuackAppBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 0),
          child: Column(
            children: [
              Text(
                'Take your face from what?',
                style: Theme.of(context).textTheme.headline6
                    ?.merge(TextStyle(height:5)),
              ),
              InkWell(
                child: Text(
                  'Camera',
                  style: Theme.of(context).textTheme.displayLarge
                      ?.merge(TextStyle(height:5)),
                ),
                onTap: (){
                  // Navigator.pushReplacementNamed(context, '/take_picture');
                  _openModule(ImageSource.camera, context: context);
                },
              ),
              InkWell(
                child: Text(
                  'Album',
                  style: Theme.of(context).textTheme.displayLarge
                      ?.merge(TextStyle(height:5)),
                ),
                onTap: (){
                  _openModule(ImageSource.gallery, context: context);
                },
              ),
            ]
          )
        )
      )
    );
  }
}