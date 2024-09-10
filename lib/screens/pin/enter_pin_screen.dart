import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:notes/utils/functions/app_functions.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../data/local/storage_repository.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../../utils/size/app_size.dart';
import '../routes.dart';
import 'dialogs/alert_dialog.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({super.key});

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  StreamController<ErrorAnimationType>? errorController;

  final LocalAuthentication auth = LocalAuthentication();

  bool hasError = false;
  String pin = '';
  int enterCount = 0;
  bool platformError = false;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    pin = StorageRepository.getString(key: 'pin');
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  Future<bool> _authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (_) {
      platformError = true;
      return false;
    }
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
              Image.asset(AppImages.security, height: 140.h),
              Text(
                'Enter your PIN code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.w,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              25.getH(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: PinCodeTextField(
                  autoFocus: true,
                  focusNode: focusNode,
                  onCompleted: (v) async {
                    if (v != pin) {
                      errorController!.add(ErrorAnimationType.shake);
                      setState(() => hasError = true);
                      enterCount++;
                      textEditingController.clear();
                    } else {
                      focusNode.unfocus();
                      setState(() {
                        hasError = false;
                      });
                      if (!context.mounted) return;
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteNames.homeRoute,
                          (Route<dynamic> route) => false);
                    }
                  },
                  autoDismissKeyboard: false,
                  enablePinAutofill: false,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  appContext: context,
                  length: 4,
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(6.w),
                    fieldHeight: 40.w,
                    fieldWidth: 30.w,
                    activeColor: Colors.white30,
                    inactiveColor: Colors.transparent,
                    inactiveFillColor: Colors.white38,
                    selectedColor: Colors.white60,
                    activeFillColor: Colors.white38,
                    selectedFillColor: Colors.white70,
                    errorBorderColor: Colors.redAccent,
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
                hasError ? "*Please enter correct pin" : "",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 10.w,
                  fontWeight: FontWeight.w400,
                ),
              ),
              10.getH(),
              Visibility(
                visible: enterCount >= 2,
                child: TextButton(
                  onPressed: () async {
                    focusNode.unfocus();
                    await Future.delayed(const Duration(milliseconds: 300));
                    if (!context.mounted) return;
                    alertDialog(context, () async {
                      bool authenticated = await _authenticate();
                      if (authenticated) {
                        StorageRepository.deleteString(key: 'pin');
                        if (!context.mounted) return;
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteNames.setPinRoute,
                            (Route<dynamic> route) => false);
                      }else if(platformError){
                        if (!context.mounted) return;
                        showSnackbar(context, 'Set a phone screen lock!');

                        AppSettings.openAppSettings(type: AppSettingsType.lockAndPassword);

                      }else{
                      if (!context.mounted) return;
                      showSnackbar(context, 'Incorrect Password, try again!');
                      }
                    });
                  },
                  child: Text(
                    'Recovery Pin Code',
                    style: TextStyle(
                      fontSize: 12.w,
                      fontWeight: FontWeight.w500,
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
