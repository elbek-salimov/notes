import 'package:flutter/material.dart';

import 'note_model_constants.dart';

class NoteModel {
  final int? id;
  final String title;
  final String text;
  final DateTime time;
  final Color color;

  NoteModel({
    this.id,
    required this.title,
    required this.text,
    required this.time,
    required this.color,
  });

  NoteModel copyWith({
    int? id,
    String? title,
    String? text,
    DateTime? time,
    Color? color,
  }) {
    return NoteModel(
      title: title ?? this.title,
      text: text ?? this.text,
      time: time ?? this.time,
      color: color ?? this.color,
    );
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      title: json[NoteModelConstants.title] as String? ?? "",
      text: json[NoteModelConstants.text] as String? ?? "",
      time: DateTime.parse(json[NoteModelConstants.time] as String? ??
          DateTime.now().toIso8601String()),
      color: Color(
          int.parse(json[NoteModelConstants.color] as String? ?? "0xff000000")),
      id: json[NoteModelConstants.id] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NoteModelConstants.title: title,
      NoteModelConstants.text: text,
      NoteModelConstants.time: time.toIso8601String(),
      NoteModelConstants.color: color.value.toString(),
    };
  }

  static NoteModel initialValue = NoteModel(
    title: "",
    text: "",
    time: DateTime.now(),
    color: Colors.green,
  );
}
