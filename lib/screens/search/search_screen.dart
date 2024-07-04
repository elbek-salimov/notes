import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
          child: GestureDetector(
            onTap: () {
              focusNode.unfocus();
            },
            child: Column(
              children: [
                Semantics(
                  label: 'Search bar',
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
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
                        contentPadding: EdgeInsets.only(left: 15.w),
                        hintText: 'Search by the keyword...',
                        hintStyle: AppTextStyles.nunitoRegular
                            .copyWith(fontSize: 20, color: AppColors.cCCCCCC),
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
                                  context.read<NoteBloc>().add(GetNotesEvent());
                                },
                                icon: const Icon(
                                  Icons.clear,
                                  color: AppColors.cCCCCCC,
                                ),
                              ),
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.c3B3B3B,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
                10.getH(),
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
                                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 30.h),
                                child: Column(
                                  children: [
                                    Image.asset(AppImages.search),
                                    Text(
                                      'File not found. Try searching again.',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.nunitoRegular
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 20),
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
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 10.h),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.black.withOpacity(0.6),
                                                  BlendMode.colorBurn),
                                              image: AssetImage(
                                                  AppImages.background),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                              color: note.color,
                                            ),
                                            boxShadow: [
                                              BoxShadow(blurRadius: 10.w)
                                            ]),
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
                                                color: Colors.white70,
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
      ),
    );
  }
}
