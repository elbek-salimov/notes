import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/screens/widgets/global_iconbutton.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/note_bloc.dart';
import '../../bloc/note_state.dart';
import '../../data/models/note_model.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../../utils/size/app_size.dart';
import '../../utils/styles/app_text_styles.dart';
import '../routes.dart';
import 'dialogs/about_me_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Timer? _timer;
  final int timeoutSeconds = 15;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void _startTimer() {
    _timer = Timer(Duration(seconds: timeoutSeconds), () {
      Navigator.pushReplacementNamed(context, RouteNames.enterPinRoute);
    });
  }

  void _cancelTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        debugPrint("App is inactive");
        break;
      case AppLifecycleState.paused:
        debugPrint("App is in background");
        _startTimer();
        break;
      case AppLifecycleState.resumed:
        debugPrint("App is in foreground");
        _cancelTimer();
        break;
      case AppLifecycleState.detached:
        debugPrint("App is detached");
        break;
      case AppLifecycleState.hidden:
        debugPrint("App is hidden");

        break;
    }
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
              padding: EdgeInsets.only(
                  left: 24.w, right: 24.w, top: 10.h, bottom: 5.h),
              child: Row(
                children: [
                  const Text('Notes', style: AppTextStyles.nunitoSemiBold),
                  const Spacer(),
                  Semantics(
                    label: 'Navigate to search screen',
                    child: GlobalIconButton(
                      icon: Icons.search,
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteNames.searchNoteRoute);
                      },
                    ),
                  ),
                  20.getW(),
                  Semantics(
                    label: 'About developer',
                    child: GlobalIconButton(
                      icon: Icons.error_outline,
                      onTap: () {
                        aboutMeDialog(context: context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
              indent: 15.w,
              endIndent: 15.w,
              thickness: 1.h,
              height: 0,
            ),
            5.getH(),
            BlocBuilder<NoteBloc, NoteState>(
              builder: (context, state) {
                if (state is NotesLoadingState) {
                  return Expanded(
                    child: ListView(
                      children: [
                        ...List.generate(10, (index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white70,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 15.w),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [BoxShadow(blurRadius: 10.w)]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('', style: TextStyle(fontSize: 18.w)),
                                    Text('', style: TextStyle(fontSize: 14.w)),
                                    3.getH(),
                                    Text('', style: TextStyle(fontSize: 10.w)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  );
                }
                if (state is NotesErrorState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.errorText),
                    ],
                  );
                } else if (state is NotesSuccessState) {
                  return Expanded(
                    child: state.notes.isEmpty
                        ? Padding(
                            padding: EdgeInsets.all(50.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppImages.empty),
                                Text(
                                  'Create your first note !',
                                  style: AppTextStyles.nunitoRegular.copyWith(
                                      color: Colors.white, fontSize: 20),
                                )
                              ],
                            ),
                          )
                        : ListView(
                            physics: const BouncingScrollPhysics(),
                            children:
                                List.generate(state.notes.length, (index) {
                              NoteModel note = state.notes[index];
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd – kk:mm')
                                      .format(note.time);
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 20.w),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteNames.watchNoteRoute,
                                        arguments: {
                                          'title': note.title,
                                          'text': note.text,
                                          'id': note.id,
                                        });
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          note.title,
                                          style: AppTextStyles.nunitoRegular
                                              .copyWith(
                                            color: Colors.white,
                                            fontSize: 18.w,
                                          ),
                                        ),
                                        Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          note.text,
                                          style: AppTextStyles.nunitoRegular
                                              .copyWith(
                                            color: Colors.grey,
                                            fontSize: 14.w,
                                          ),
                                        ),
                                        3.getH(),
                                        Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          formattedDate,
                                          style: AppTextStyles.nunitoRegular
                                              .copyWith(
                                            color: AppColors.cf1da95,
                                            fontSize: 10.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.c252525,
        elevation: 0,
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.addNoteRoute);
        },
        child: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
            color: const Color(0xFF2c3135),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.09),
                offset: const Offset(-8, 0),
                blurRadius: 10,
              ),
              BoxShadow(
                color: Colors.black87.withOpacity(0.5),
                offset: const Offset(7, 7),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
