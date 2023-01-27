import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  const Photo(this.myPhoto);

  final Image myPhoto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Container (
          height: 280,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: myPhoto
      ),
    );
  }
}
