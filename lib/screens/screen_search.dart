import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_getx/model/note_model.dart';

import '../controller/note_controller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CupertinoTextField(
                onChanged: (String value) => search(value),
                padding: const EdgeInsets.all(12),
                autofocus: true,
                prefix: const Icon(
                  Icons.search,
                  color: Colors.white70,
                ),
                clearButtonMode: OverlayVisibilityMode.editing,
                style: const TextStyle(
                  color: Colors.white70,
                  letterSpacing: 1,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            noteController.notelist.isEmpty
                ? Container()
                : Expanded(
                    child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        tileColor: Colors.lightGreen,
                        title: Text(
                          noteController.notelist[index].note,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      itemCount: noteController.notelist.length,
                      separatorBuilder: (context, index) => const Divider(),
                    ),
                  ))
          ],
        ),
      ),
    );
  }

  search(String typedKeyword) {
    //   List<NoteModel> results =

    //     noteController.notelist
    //         .where(
    //           (element) =>
    //               element.note.toLowerCase().contains(typedKeyword.toLowerCase()),
    //         )
    //         .toList();
  }
}
