import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../data/local/storage_repository.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../../utils/size/app_size.dart';
import '../routes.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  bool pinEntered = false;
  String firstPin = '';

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.c252525,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            children: [
              20.getH(),
              Image.asset(AppImages.security, height: 150.h),
              Text(
                '${pinEntered ? 'Reenter' : 'Set'} your PIN code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.w,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              5.getH(),
              Text(
                'We use state of art the security measures to'
                ' protect your information at all times',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.w,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.start,
              ),
              15.getH(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: PinCodeTextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  appContext: context,
                  length: 4,
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8.w),
                    fieldHeight: 40.w,
                    fieldWidth: 30.w,
                    inactiveFillColor: Colors.white,
                    activeFillColor: Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                ),
              ),
              Text(
                hasError ? "*Please fill up all the cells properly" : "",
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              10.getH(),
              SizedBox(
                width: width - 200,
                height: 35.h,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                  ),
                  onPressed: () async {
                    if (textEditingController.text.isEmpty ||
                        textEditingController.text.length < 4) {
                      errorController!.add(ErrorAnimationType.shake);
                      setState(() => hasError = true);
                    } else if (pinEntered) {
                      if (firstPin == textEditingController.text) {
                        setState(() {
                          hasError = false;
                        });
                        await StorageRepository.setString(
                            key: 'pin', value: firstPin);
                        if(!context.mounted) return;
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteNames.homeRoute,
                            (Route<dynamic> route) => false);
                      } else {
                        errorController!.add(ErrorAnimationType.shake);
                        setState(() => hasError = true);
                        textEditingController.clear();
                      }
                    } else {
                      firstPin = textEditingController.text;
                      textEditingController.clear();
                      setState(() {
                        hasError = false;
                        pinEntered = true;
                      });
                    }
                  },
                  child: Center(
                    child: Text(
                      pinEntered ? "SAVE" : "SET",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
