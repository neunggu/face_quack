import 'package:flutter/material.dart';

class FaceModel {
  String nickname;
  String imagePath;
  String selfPrice;
  String resultPrice;
  Image photo;

  FaceModel(
      this.nickname,
      this.imagePath,
      this.selfPrice,
      this.resultPrice,
      this.photo
  );

  @override
  String toString() {
    return 'FaceModel{nickname: $nickname, photo: $photo, selfPrice: $selfPrice, resultPrice: $resultPrice}';
  }
}
