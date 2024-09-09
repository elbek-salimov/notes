import 'dart:async';
import 'package:flutter/material.dart';

import '../../data/local/storage_repository.dart';
import '../../utils/images/app_images.dart';
import '../../utils/size/app_size.dart';
import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;
  bool isVisible = false;

  _init() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isVisible = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    if(StorageRepository.getString(key: 'pin').isEmpty){
      Navigator.pushReplacementNamed(context, RouteNames.setPinRoute);
    }else{
      Navigator.pushReplacementNamed(context, RouteNames.enterPinRoute);
    }
  }

  @override
  void initState() {
    _init();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation1 = ColorTween(
      begin: const Color(0xFF262325),
      end: const Color(0xFF245C73),
    ).animate(_animationController);

    _colorAnimation2 = ColorTween(
      begin: const Color(0xFFF6F6F6),
      end: const Color(0xFF2F2F2F),
    ).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  _colorAnimation1.value!,
                  _colorAnimation2.value!,
                ],
              ),
            ),
            child: child,
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Center(
            child: AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: isVisible ? 1 : 0,
              child: Image.asset(AppImages.intro),
            ),
          ),
        ),
      ),
    );
  }
}
