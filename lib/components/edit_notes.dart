import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_repository/note_repository.dart';
import 'blocs/create_note_bloc/create_note_bloc.dart';
import 'blocs/get_categories_bloc/get_categories_bloc.dart';

class EditPage extends StatefulWidget {
  final Note note;

  const EditPage({required this.note, Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController notesController;
  late TextEditingController categoryController;
  late TextEditingController dateController;
  late Note note;
  bool isLoading = false;

  List<String> myCategoriesIcons = [
    "food",
    "health",
    "education",
    "event",
    "finance",
    "work",
    "home"
  ];

  @override
  void initState() {
    super.initState();
    note = widget.note;
    notesController = TextEditingController(text: note.nameNote);
    categoryController = TextEditingController(text: note.category.name);
    dateController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(note.date));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateNoteBloc, CreateNoteState>(
      listener: (context, state) {
        if (state is CreateNoteSuccess) {
          Navigator.pop(context, note);
        } else if (state is CreateNoteLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
            builder: (context, state) {
              if (state is GetCategoriesSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Редактировать напоминание",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      TextField(
                        controller: notesController,
                        decoration: InputDecoration(labelText: 'Note'),
                      ),
                      TextField(
                        controller: categoryController,
                        decoration: InputDecoration(labelText: 'Category'),
                      ),
                      TextField(
                        controller: dateController,
                        decoration: InputDecoration(labelText: 'Date'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add your logic to update the note
                        },
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text('Save'),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
