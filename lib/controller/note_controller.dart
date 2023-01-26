import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_getx/model/note_model.dart';

class NoteController extends GetxController {
  NoteController() {
    getAllNotes();
  }

  bool checkBoxValue = false;
  checkBoxChanged() {
    if (checkBoxValue == false) {
      checkBoxValue = true;
    } else {
      checkBoxValue = false;
    }
    update();
  }

  final titleController = TextEditingController();
  List<NoteModel> notelist = [];

  Future<void> addNote(NoteModel model) async {
    final noteDB = await Hive.openBox<NoteModel>('notes_db');
    await noteDB.add(model);
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
    final notesData = await Hive.openBox<NoteModel>('notes_db');
    return notesData.values.toList();
  }

  Future<void> deleteNote(int index) async {
    final noteDB = await Hive.openBox<NoteModel>('notes_db');
    await noteDB.deleteAt(index);
    getAllNotes();
  }

  Future<void> updateNote(int index, NoteModel model) async {
    final noteDB = await Hive.openBox<NoteModel>('notes_db');
    noteDB.putAt(index, model);
    getAllNotes();
  }
}
