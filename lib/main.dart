import 'dart:io';

import 'package:face_quack/src/ad/ad_banner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:face_quack/src/component/surprise.dart';
import 'package:face_quack/src/component/waiting.dart';
import 'package:face_quack/src/models/face.dart';
import 'package:face_quack/src/models/overlay.dart';
import 'package:window_size/window_size.dart';
import 'package:face_quack/src/common/theme.dart';
import 'package:face_quack/src/screens/home.dart';
import 'package:face_quack/src/screens/login.dart';
import 'package:face_quack/src/screens/result.dart';
import 'package:face_quack/src/screens/self_price.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:face_quack/src/ad/ad_helper.dart';

Future<void> main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  setupWindow();
  await _initGoogleMobileAds();
  runApp(const MyApp());
}

Future<InitializationStatus> _initGoogleMobileAds() {
  return MobileAds.instance.initialize();
}

const double windowWidth = 400;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    setWindowTitle('Face Quack');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key,});

  @override
  _MyAppState createState()=>_MyAppState();
}

class _MyAppState extends State<MyApp> {
  BannerAd? _bannerAd;
  @override
  void initState(){
    super.initState();
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }
  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  bool _isWaiting = false;
  bool _isSurprise = false;

  showWaiting(bool state){
    setState(() {
      _isWaiting = state;
    });
  }
  showSurprise(bool state){
    setState(() {
      _isSurprise = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => FaceModel('', '', '0', '0', Image.asset('assets/images/face_quack.png'))),
        Provider(create: (context) => OverlayModel(showWaiting, showSurprise))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Face Quack',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const Login(),
          '/home': (context) => const Home(),
          '/self_price': (context) => const SelfPrice(),
          '/result': (context) => const Result(),
          '/waiting': (context) => const Waiting(),
          '/surprise': (context) => const Surprise(),
        },
        builder: (context, child){
          return Stack(
            children: [
              child!,
              if(_isWaiting) Waiting(),
              if(_isSurprise) Surprise(),
              if(_bannerAd != null) AdBanner(_bannerAd),
            ],
          );
        },
      ),
    );
  }
}
