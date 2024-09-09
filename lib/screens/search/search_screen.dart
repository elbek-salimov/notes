import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes/screens/widgets/global_iconbutton.dart';

import '../../bloc/note_bloc.dart';
import '../../bloc/note_event.dart';
import '../../bloc/note_state.dart';
import '../../data/models/note_model.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/images/app_images.dart';
import '../../utils/size/app_size.dart';
import '../../utils/styles/app_text_styles.dart';
import '../routes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        isVisible = controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return PopScope(
      onPopInvoked: (v) {
        context.read<NoteBloc>().add(GetNotesEvent());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.c252525,
        body: SafeArea(
          child: Column(
            children: [
              Semantics(
                label: 'Search bar',
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                  child: Row(
                    children: [
                      GlobalIconButton(
                        icon: Icons.arrow_back_ios,
                        onTap: () => Navigator.pop(context),
                      ),
                      10.getW(),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(20)),
                            color: const Color(0xFF2c3135),
                            boxShadow: [
                              BoxShadow(
                                color:
                                Colors.white.withOpacity(0.06),
                                offset: const Offset(-4, -6),
                                spreadRadius: 0,
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color:
                                Colors.black87.withOpacity(0.3),
                                offset: const Offset(6, 4),
                                spreadRadius: 0,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextField(
                            focusNode: focusNode,
                            controller: controller,
                            autofocus: true,
                            onChanged: (value) {
                              // context.read<NoteBloc>().add(SearchNoteEvent(searchText: value));
                              if (value.isEmpty) {
                                context.read<NoteBloc>().add(GetNotesEvent());
                              } else {
                                context
                                    .read<NoteBloc>()
                                    .add(SearchNoteEvent(searchText: value));
                              }
                            },
                            textInputAction: TextInputAction.search,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              isDense: false,
                              contentPadding: EdgeInsets.only(left: 15.w),
                              hintText: 'Search by the keyword...',
                              hintStyle: AppTextStyles.nunitoRegular
                                  .copyWith(fontSize: 14.w, color: AppColors.cCCCCCC),
                              suffixIcon: Semantics(
                                label: 'Clear search bar',
                                child: Visibility(
                                  visible: isVisible,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      splashRadius: 20,
                                      onPressed: () {
                                        controller.clear();
                                        context
                                            .read<NoteBloc>()
                                            .add(GetNotesEvent());
                                      },
                                      icon: const Icon(
                                        Icons.clear,
                                        color: AppColors.cCCCCCC,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // filled: true,
                              // fillColor: AppColors.c252525,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(10.w),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(10.w),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
              BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  if (state is NotesLoadingState) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50.w, vertical: 30.h),
                              child: Column(
                                children: [
                                  Image.asset(AppImages.search),
                                  Text(
                                    'File not found. Try searching again.',
                                    textAlign: TextAlign.center,
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
                                      vertical: 10.h, horizontal: 15.w),
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
                                          horizontal: 20.w, vertical: 10.h),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        color: const Color(0xFF2c3135),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.white.withOpacity(0.06),
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
      ),
    );
  }
}
