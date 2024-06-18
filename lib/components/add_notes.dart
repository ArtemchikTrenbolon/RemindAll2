import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:RemindAll/components/blocs/create_note_bloc/create_note_bloc.dart';
import 'package:RemindAll/components/category_creation.dart';
import 'package:RemindAll/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:note_repository/note_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../services/notifi_service.dart';
import 'blocs/get_categories_bloc/get_categories_bloc.dart';

DateTime scheduleTime = DateTime.now();

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  TextEditingController notesController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

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
    timeController.text = DateFormat('HH:mm').format(DateTime.now());
    note = Note.empty;
    note.expenseId = Uuid().v1();
    super.initState();
  }

  void scheduleNotification() {
    debugPrint('Notification Scheduled for $scheduleTime');
    NotificationService().scheduleNotification(
      title: 'Напоминание',
      body: notesController.text,
      scheduledNotificationDateTime: scheduleTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateNoteBloc, CreateNoteState>(
      listener: (context, state) {
        if (state is CreateNoteSuccess) {
          scheduleNotification(); // Вызываем расписание уведомлений при успешном сохранении
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
                        "Добавить напоминание",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: notesController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.background,
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
                            ),
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
                          fillColor: note.category == RepositoryCategory.empty || note.category.icon == null || note.category.icon.isEmpty
                              ? Theme.of(context).colorScheme.background
                              : Color(note.category.color),
                          prefixIcon: note.category == RepositoryCategory.empty || note.category.icon == null || note.category.icon.isEmpty
                              ? Icon(
                            Icons.list,
                            size: 20,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          )
                              : _buildCategoryIcon(note.category.icon),
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
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
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
                                  leading: _buildCategoryIcon(state.categories[i].icon),
                                  title: Text(
                                    "${state.categories[i].name}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  tileColor: Color(state.categories[i].color),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: dateController,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        onTap: () {
                          DatePicker.showDateTimePicker(
                            context,
                            showTitleActions: true,
                            onChanged: (date) => scheduleTime = date,
                            onConfirm: (date) {
                              setState(() {
                                dateController.text = DateFormat('dd/MM/yyyy HH:mm').format(date);
                                note.date = date;
                              });
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.ru,
                          );
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.background,
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            size: 20,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          hintText: "Дата и Время",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
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
                              borderRadius: BorderRadius.circular(12),
                            ),
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
              } else {
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

  Widget _buildCategoryIcon(String iconFileName) {
    if (iconFileName != null && iconFileName.isNotEmpty) {
      try {
        return Image.asset(
          "icons/$iconFileName.png",
          scale: 3,
          color: Colors.white,
        );
      } catch (e) {
        print("Error loading category icon: $e");
      }
    }
    // Если имя файла пустое или иконка не найдена, возвращаем заменяющий виджет
    return Container(
      width: 35,
      height: 35,
      child: Center(
        child: Icon(
          Icons.notifications,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
