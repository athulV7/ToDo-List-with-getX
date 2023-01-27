import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_getx/model/note_model.dart';

class NoteController extends GetxController {
  late Box<NoteModel> notesData;
  
  NoteController() {
    getAllNotes();
  }

  Future<void> checkBoxChanged(NoteModel model, value, int index) async {
    model.checkStatus = value;
    notesData.putAt(index, model);
    getAllNotes();
    update();
  }

  final titleController = TextEditingController();
  List<NoteModel> notelist = [];

  Future<void> addNote(NoteModel model) async {
    notesData = await Hive.openBox<NoteModel>('notes_db');
    await notesData.add(model);
    getAllNotes();
    log('note added');
  }

  Future<void> getAllNotes() async {
    notelist.clear();
    final getNotes = await getNote();
    notelist.addAll(getNotes);
    update();
  }

  Future<List<NoteModel>> getNote() async {
    notesData = await Hive.openBox<NoteModel>('notes_db');
    return notesData.values.toList();
  }

  Future<void> deleteNote(int index) async {
    notesData = await Hive.openBox<NoteModel>('notes_db');
    await notesData.deleteAt(index);
    getAllNotes();
  }

  Future<void> updateNote(int index, NoteModel model) async {
    notesData = await Hive.openBox<NoteModel>('notes_db');
    notesData.putAt(index, model);
    getAllNotes();
  }
}
