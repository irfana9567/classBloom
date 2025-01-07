
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

QuestionModel chatModelFromJson(String str) => QuestionModel.fromJson(json.decode(str));

String chatModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
  String id;
  String question;
  String correctAnswer;
  bool delete;
  List<dynamic> options;
  DateTime uploadDate;
  DocumentReference? reference;

  QuestionModel({
    required this.id,
    required this.question,
    required this.correctAnswer,
    required this.delete,
    required this.options,
    required this.uploadDate,
    required this.reference,
  });

  QuestionModel copyWith({
    String? id,
    String? question,
    String? correctAnswer,
    bool? delete,
    List<dynamic>? options,
    DateTime? uploadDate,
    DocumentReference? reference,
  }) =>
      QuestionModel(
        id: id ?? this.id,
        question: question ?? this.question,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        delete: delete ?? this.delete,
        options: options ?? this.options,
        uploadDate: uploadDate ?? this.uploadDate,
        reference: reference ?? this.reference,
      );

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    id: json["id"],
    question: json["question"],
    correctAnswer: json["correctAnswer"],
    delete: json["delete"],
    options: List<dynamic>.from(json["options"].map((x) => x)),
    reference: json["reference"],
    uploadDate: DateTime.parse(json["uploadDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "correctAnswer": correctAnswer,
    "delete": delete,
    "options": List<dynamic>.from(options.map((x) => x)),
    "reference": reference,
    "uploadDate": uploadDate.toIso8601String(),
  };
}
