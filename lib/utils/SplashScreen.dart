
import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:kvn11mart/utils/Routes_name.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late final AnimationController _animationController =
  AnimationController(duration: const Duration(seconds: 4), vsync: this)
    ..repeat();
  @override

  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.pushNamed(context, RoutesName.productList)
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _animationController,
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: const Center(
                    child: Image(image: AssetImage('asserts/splashscreen.png')),
                  ),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _animationController.value * 2 * math.pi,
                    child: child,
                  );
                }),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.04,
            ),
            Align(
              alignment: Alignment.center,
              child: Text("KVN11 Mart",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
