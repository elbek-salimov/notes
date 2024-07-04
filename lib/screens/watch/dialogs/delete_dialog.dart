import 'package:flutter/material.dart';

import '../../../utils/colors/app_colors.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';

deleteDialog(BuildContext context, VoidCallback onTap) {
  return showDialog(
      context: context,
      builder: (context) {
        height = MediaQuery.of(context).size.height;
        width = MediaQuery.of(context).size.width;
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: AppColors.c252525,
            contentPadding: EdgeInsets.only(
                bottom: 25.h, top: 25.h, left: 30.w, right: 30.w),
            content: Text(
              'Do you want to delete this note?',
              textAlign: TextAlign.center,
              style: AppTextStyles.nunitoRegular
                  .copyWith(fontSize: 22, color: AppColors.c9A9A9A),
            ),
            icon: const Icon(Icons.error, color: AppColors.c9A9A9A),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actionsPadding: EdgeInsets.only(bottom: 25.h),
            actions: [
              TextButton(
                style: TextButton.styleFrom(backgroundColor: AppColors.green),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Close',
                  style: AppTextStyles.nunitoRegular
                      .copyWith(fontSize: 18, color: Colors.white),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: AppColors.red),
                onPressed: onTap,
                child: Text(
                  'Delete',
                  style: AppTextStyles.nunitoRegular
                      .copyWith(fontSize: 18, color: Colors.white),
                ),
              ),
            ]);
      },
      barrierColor: Colors.white.withOpacity(0.2));
}
