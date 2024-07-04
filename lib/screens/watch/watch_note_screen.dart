import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/note_bloc.dart';
import '../../bloc/note_event.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/size/app_size.dart';
import '../../utils/styles/app_text_styles.dart';
import '../routes.dart';
import 'dialogs/delete_dialog.dart';

class WatchNoteScreen extends StatelessWidget {
  const WatchNoteScreen({
    super.key,
    required this.id,
    required this.title,
    required this.text,
  });

  final int id;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.c252525,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(10.w),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Ink(
                      height: 35.w,
                      width: 35.w,
                      decoration: BoxDecoration(
                          color: AppColors.c3B3B3B,
                          borderRadius: BorderRadius.circular(10.w)),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 16.w,
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(10.w),
                    onTap: () {
                      deleteDialog(context, () {
                        context
                            .read<NoteBloc>()
                            .add(DeleteNoteEvent(noteId: id));
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      });
                    },
                    child: Ink(
                      height: 35.w,
                      width: 35.w,
                      decoration: BoxDecoration(
                          color: AppColors.c3B3B3B,
                          borderRadius: BorderRadius.circular(10.w)),
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 16.w,
                      ),
                    ),
                  ),
                  20.getW(),
                  InkWell(
                    borderRadius: BorderRadius.circular(10.w),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, RouteNames.updateNoteRoute,
                          arguments: {'id': id, 'title': title, 'text': text});
                    },
                    child: Ink(
                      height: 35.w,
                      width: 35.w,
                      decoration: BoxDecoration(
                          color: AppColors.c3B3B3B,
                          borderRadius: BorderRadius.circular(10.w)),
                      child: Icon(
                        Icons.create_outlined,
                        color: Colors.white,
                        size: 16.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            20.getH(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h, width: double.infinity),
                      Text(
                        title,
                        style: AppTextStyles.nunitoRegular
                            .copyWith(fontSize: 35, color: Colors.white),
                      ),
                      30.getH(),
                      Text(
                        text,
                        style: AppTextStyles.nunitoRegular
                            .copyWith(fontSize: 23, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
