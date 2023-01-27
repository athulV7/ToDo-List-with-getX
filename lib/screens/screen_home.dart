import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list_getx/controller/note_controller.dart';
import 'package:todo_list_getx/model/note_model.dart';
import 'package:todo_list_getx/screens/screen_search.dart';
import 'package:todo_list_getx/screens/widgets/update_widget.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  final titleController = TextEditingController();
  final noteController = Get.put(NoteController());
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'TO DO',
          style: GoogleFonts.maidenOrange(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Get.to(
              SearchScreen(),
              transition: Transition.cupertino,
            ),
            icon: const Icon(Icons.search),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          createNewTask(context);
        },
      ),
      body: GetBuilder<NoteController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: noteController.notelist.isEmpty
              ? Container()
              : ListView.separated(
                  itemCount: noteController.notelist.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Colors.grey.shade700,
                            icon: Icons.edit_note_outlined,
                            label: 'Edit',
                            onPressed: (context) {
                              showDialog(
                                context: context,
                                builder: (context) => UpdateNoteWidget(
                                  index: index,
                                  model: noteController.notelist[index],
                                ),
                              );
                            },
                          ),
                          SlidableAction(
                            backgroundColor: Colors.grey.shade700,
                            icon: Icons.delete,
                            label: 'Delete',
                            onPressed: (context) => deleteNote(context, index),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Checkbox(
                          value: noteController.notelist[index].checkStatus ??
                              false,
                          onChanged: (value) {
                            noteController.checkBoxChanged(
                                noteController.notelist[index], value, index);
                          },
                        ),
                        visualDensity: const VisualDensity(vertical: 1),
                        tileColor: Colors.lightGreen,
                        title: Text(noteController.notelist[index].note),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
        ),
      ),
    );
  }

  void createNewTask(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.lightGreen[300],
          content: SizedBox(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Form(
                  key: formkey,
                  child: TextFormField(
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your task';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add a new task",
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
                        if (formkey.currentState!.validate()) {
                          saveNote();
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
      },
    );
  }

  Future<void> saveNote() async {
    final taskName = titleController.text.trim();
    if (taskName.isEmpty) {
      return;
    }
    final newNote = NoteModel(note: taskName);
    noteController.addNote(newNote);
    titleController.clear();
    Get.back();
  }

  deleteNote(context, int index) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.lightGreen[300],
        title: const Text('Delete?'),
        content: const Text('Do you want to delete this task?'),
        actions: [
          MaterialButton(
            color: Theme.of(context).primaryColor,
            child: const Text("No"),
            onPressed: () => Get.back(),
          ),
          MaterialButton(
            color: Theme.of(context).primaryColor,
            child: const Text("Yes"),
            onPressed: () {
              noteController.deleteNote(index);
              Get.back();
              Get.snackbar(
                'Done',
                'Task deleted successfully',
                icon: const Icon(
                  Icons.delete_rounded,
                  color: Colors.white,
                ),
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white,
                backgroundColor: Colors.grey.withOpacity(0.2),
              );
            },
          ),
        ],
      ),
    );
  }
}
