import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/screens/widgets/global_iconbutton.dart';

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
                  GlobalIconButton(
                    icon: Icons.arrow_back_ios,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  GlobalIconButton(
                    icon: Icons.delete_outline,
                    onTap: () {
                      deleteDialog(context, () {
                        context
                            .read<NoteBloc>()
                            .add(DeleteNoteEvent(noteId: id));
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      });
                    },
                  ),
                  20.getW(),
                  GlobalIconButton(
                    icon: Icons.edit_outlined,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, RouteNames.updateNoteRoute,
                          arguments: {'id': id, 'title': title, 'text': text});
                    },
                  ),
                ],
              ),
            ),
            15.getH(),
            Divider(
              color: Colors.white,
              indent: 15.w,
              endIndent: 15.w,
              thickness: 1.h,
              height: 0,
            ),
            5.getH(),
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
