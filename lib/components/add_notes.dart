import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app3/components/blocs/create_note_bloc/create_note_bloc.dart';
import 'package:flutter_app3/components/category_creation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_repository/note_repository.dart';
import 'package:uuid/uuid.dart';


import 'blocs/get_categories_bloc/get_categories_bloc.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  TextEditingController notesController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  // DateTime selectedDate = DateTime.now();
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
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    note = Note.empty;
    note.expenseId = Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateNoteBloc, CreateNoteState>(
  listener: (context, state) {
    if(state is CreateNoteSuccess) {
      Navigator.pop(context, note);
    }
    else if(state is CreateNoteLoading) {
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
              "Добавить напоминание",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.7,
              child: TextFormField(
                controller: notesController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme
                        .of(context)
                        .colorScheme
                        .background,
                    prefixIcon: Icon(
                        Icons.edit,
                        size: 20,
                        color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.0,
                        ),
                    )
                ),
              ),
            ),
            const SizedBox(height: 32),

            TextFormField(
              controller: categoryController,
              textAlignVertical: TextAlignVertical.center,
              readOnly: true,
              onTap: () async {
                // Ваш код для выбора категории
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: note.category == RepositoryCategory.empty
                    ? Theme.of(context).colorScheme.background
                    : Color(note.category.color),
                prefixIcon: note.category == RepositoryCategory.empty
                    ? Icon(
                  Icons.list,
                  size: 20,
                  color: Theme.of(context).colorScheme.inversePrimary,
                )
                    : Image.asset(
                  "icons/${note.category.icon}.png",
                  scale: 3,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    var newCategory = await getCategoryCreation(context);
                    setState(() {
                      // Обновляем состояние, когда категория выбрана
                      state.categories.insert(0, newCategory);
                      note.category = newCategory; // Устанавливаем выбранную категорию
                      categoryController.text = newCategory.name; // Обновляем текст в поле категории
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    size: 20,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                hintText: "Категории",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            Container(
              height: 200,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .colorScheme
                    .background,
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12)
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                          itemCount: state.categories.length,
                          itemBuilder: (context, int i) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    note.category = state.categories[i];
                                    categoryController.text = note.category.name;
                                  });

                                },
                                leading: Image.asset(
                                  "icons/${state.categories[i].icon}.png",
                                  scale: 3,
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                ),
                                title: Text(
                                    "${state.categories[i].name}",
                                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                                ),
                                tileColor: Color(state.categories[i].color),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                ),
                              ),
                            );
                          })
                      ),
                     ),
            const SizedBox(height: 16),

            TextFormField(
              controller: dateController,
              textAlignVertical: TextAlignVertical.center,
              readOnly: true,
              onTap: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: note.date,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.dark().copyWith(
                      // Установка цветов для кнопок и фона
                      colorScheme: ColorScheme.dark(
                        primary: Colors.deepPurple,
                        onPrimary: Colors.white,
                        surface: Theme.of(context).colorScheme.background,
                        onSurface: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      dialogBackgroundColor: Colors.blue[900], // Цвет фона диалога
                    ),
                    child: child!,
                  );
                },
                );

                if (newDate != null) {
                  setState(() {
                    dateController.text =
                        DateFormat("dd/MM/yyyy").format(newDate);
                    // selectedDate = newDate;
                    note.date = newDate;
                  });
                }
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme
                      .of(context)
                      .colorScheme
                      .background,
                  prefixIcon: Icon(
                    Icons.access_time,
                    size: 20,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  hintText: "Дата",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none
                  )
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: kToolbarHeight,
              child: isLoading
              ? Center(child: CircularProgressIndicator())
              : TextButton(
                onPressed: () {
                  setState(() {
                    note.nameNote = notesController.text;
                  });
                  context.read<CreateNoteBloc>().add(CreateNote(note));
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    )
                ),
                child: Text(
                  "Сохранить",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  },
),
      ),
    ),
);
  }
}