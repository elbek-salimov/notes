import 'package:flutter/material.dart';

import '../../../utils/colors/app_colors.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';

aboutDialog({required BuildContext context, required VoidCallback onTap}){
  width = MediaQuery.of(context).size.width;
  height = MediaQuery.of(context).size.height;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: AppColors.c252525,
              contentPadding: EdgeInsets.only(bottom: 25.h, top: 25.h),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Save Changes ?',
                    style: AppTextStyles.nunitoRegular.copyWith(
                        fontSize: 22, color: AppColors.c9A9A9A),
                  ),
                ],
              ),
              icon: const Icon(Icons.error,
                  color: AppColors.c9A9A9A),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actionsPadding: EdgeInsets.only(bottom: 25.h),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: AppColors.red
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: AppColors.c252525,
                              contentPadding: EdgeInsets.only(bottom: 25.h, top: 25.h, left: 34.w, right: 34.w),
                              content: Text(
                                'Are your sure you want\n discard your changes ?',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.nunitoRegular.copyWith(
                                    fontSize: 22, color: AppColors.c9A9A9A),
                              ),
                              icon: const Icon(Icons.error,
                                  color: AppColors.c9A9A9A),
                              actionsAlignment: MainAxisAlignment.spaceAround,
                              actionsPadding: EdgeInsets.only(bottom: 25.h),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: AppColors.red
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Discard',
                                    style: AppTextStyles.nunitoRegular
                                        .copyWith(
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: AppColors.green
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Keep',
                                    style: AppTextStyles.nunitoRegular
                                        .copyWith(
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                ),
                              ]);
                        },
                        barrierColor: Colors.white.withOpacity(0.2));
                  },
                  child: Text(
                    'Discard',
                    style: AppTextStyles.nunitoRegular
                        .copyWith(
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: AppColors.green
                  ),
                  onPressed: onTap,
                  child: Text(
                    'Save',
                    style: AppTextStyles.nunitoRegular
                        .copyWith(
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ]);
        },
        barrierColor: Colors.white.withOpacity(0.2));
}