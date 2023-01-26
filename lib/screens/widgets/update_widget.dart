import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_getx/controller/note_controller.dart';

import '../../model/note_model.dart';

class UpdateNoteWidget extends StatelessWidget {
  UpdateNoteWidget({super.key, required this.index, required this.model});
  final int index;
  final NoteModel model;

  final noteController = Get.put(NoteController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    noteController.titleController.text = model.note;
    return AlertDialog(
      backgroundColor: Colors.lightGreen[300],
      content: SizedBox(
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Form(
              key: formKey,
              child: TextFormField(
                controller: noteController.titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your task';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () => Get.back(),
                  color: Theme.of(context).primaryColor,
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                MaterialButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      editedNote(index);
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void editedNote(int index) {
    final editedNote = noteController.titleController.text.trim();
    final updatedModel = NoteModel(note: editedNote);
    noteController.updateNote(index, updatedModel);
    Get.back();
  }
}
