import 'package:hive_flutter/hive_flutter.dart';
part 'note_model.g.dart';

@HiveType(typeId: 1)
class NoteModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String note;

  NoteModel({required this.note, this.id});
}
