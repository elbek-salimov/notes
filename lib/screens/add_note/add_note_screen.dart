import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/screens/widgets/global_iconbutton.dart';

import '../../bloc/note_bloc.dart';
import '../../bloc/note_event.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/functions/app_functions.dart';
import '../../utils/size/app_size.dart';
import '../../utils/styles/app_text_styles.dart';
import 'dialogs/show_dialog.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  final FocusNode titleFocusNode = FocusNode();
  final FocusNode textFocusNode = FocusNode();

  @override
  void dispose() {
    titleController.dispose();
    textController.dispose();
    titleFocusNode.dispose();
    textFocusNode.dispose();
    super.dispose();
  }

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
                    onTap: () {
                      titleFocusNode.unfocus();
                      textFocusNode.unfocus();
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  GlobalIconButton(
                    icon: Icons.remove_red_eye_outlined,
                    onTap: () {
                      titleFocusNode.unfocus();
                      textFocusNode.unfocus();
                    },
                  ),
                  20.getW(),
                  GlobalIconButton(
                    icon: Icons.save_outlined,
                    onTap: () async {
                      titleFocusNode.unfocus();
                      textFocusNode.unfocus();
                      await Future.delayed(const Duration(milliseconds: 300));
                      if (!context.mounted) return;
                      aboutDialog(
                        context: context,
                        onTap: () {
                          if (titleController.text.isNotEmpty &&
                              textController.text.isNotEmpty) {
                            context.read<NoteBloc>().add(
                                  AddNotesEvent(
                                    title: titleController.text,
                                    text: textController.text,
                                    time: DateTime.now(),
                                  ),
                                );
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else {
                            showSnackbar(context, 'Enter title and text!');
                          }
                        },
                      );
                    },
                  )
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
                      EdgeInsets.only(left: 14.w, right: 14.w, bottom: 20.h),
                  child: Column(
                    children: [
                      10.getH(),
                      TextField(
                        autofocus: true,
                        focusNode: titleFocusNode,
                        controller: titleController,
                        maxLines: null,
                        textInputAction: TextInputAction.next,
                        style: AppTextStyles.nunitoRegular
                            .copyWith(color: Colors.white, fontSize: 35),
                        decoration: InputDecoration(
                          hintText: 'Title',
                          hintStyle: AppTextStyles.nunitoRegular
                              .copyWith(color: AppColors.c9A9A9A, fontSize: 48),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                      TextField(
                        focusNode: textFocusNode,
                        controller: textController,
                        maxLines: null,
                        textInputAction: TextInputAction.done,
                        style: AppTextStyles.nunitoRegular.copyWith(
                            color: Colors.white, fontSize: 23, height: 1.h),
                        decoration: InputDecoration(
                          hintText: 'Type something...',
                          hintStyle: AppTextStyles.nunitoRegular
                              .copyWith(color: AppColors.c9A9A9A, fontSize: 23),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
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
