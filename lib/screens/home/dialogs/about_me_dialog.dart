import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/colors/app_colors.dart';
import '../../../utils/images/app_images.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';

aboutMeDialog({required BuildContext context}) {
  width = MediaQuery.of(context).size.width;
  height = MediaQuery.of(context).size.height;
  showGeneralDialog(
      context: context,
      pageBuilder: (context, a1, a2) {
        return const SizedBox();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
            backgroundColor: Colors.transparent,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: AppColors.c3B3B3B.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      30.getH(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Elbek Salimov',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.nunitoSemiBold.copyWith(
                              fontSize: 24,
                            ),
                          ),
                          5.getW(),
                          const Icon(
                            Icons.verified,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      10.getH(),
                      GestureDetector(
                        onTap: (){
                          launchUrl(
                              Uri.parse("https://t.me/Elbek_Salimov"));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(14.w),
                            ),
                            color: const Color(0xFF2c3135),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.06),
                                offset: const Offset(-10, -10),
                                spreadRadius: 0,
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color:
                                Colors.black87.withOpacity(0.3),
                                offset: const Offset(10, 10),
                                spreadRadius: 0,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Image.asset(AppImages.telegram, height: 25.w),
                              10.getW(),
                              Text(
                                'Telegram',
                                style: AppTextStyles.nunitoRegular.copyWith(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      7.getH(),
                      GestureDetector(
                        onTap: (){
                          launchUrl(Uri.parse(
                              "https://github.com/elbek-salimov"));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(14.w),
                            ),
                            color: const Color(0xFF2c3135),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.06),
                                offset: const Offset(-10, -10),
                                spreadRadius: 0,
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color:
                                Colors.black87.withOpacity(0.3),
                                offset: const Offset(10, 10),
                                spreadRadius: 0,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Image.asset(AppImages.github, height: 25.w),
                              10.getW(),
                              Text(
                                'GitHub',
                                style: AppTextStyles.nunitoRegular.copyWith(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      7.getH(),
                      GestureDetector(
                        onTap: (){
                          launchUrl(Uri.parse(
                              "https://www.linkedin.com/in/elbek-salimov/"));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(14.w),
                            ),
                            color: const Color(0xFF2c3135),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.06),
                                offset: const Offset(-10, -10),
                                spreadRadius: 0,
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color:
                                Colors.black87.withOpacity(0.3),
                                offset: const Offset(10, 10),
                                spreadRadius: 0,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Image.asset(AppImages.linkedin, height: 25.w),
                              10.getW(),
                              Text(
                                'LinkedIn',
                                style: AppTextStyles.nunitoRegular.copyWith(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      10.getH(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -50,
                  child: CircleAvatar(
                    backgroundColor: Colors.lightGreenAccent,
                    radius: 50,
                    child: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Image.asset(AppImages.developer),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      barrierColor: Colors.black87);
}
