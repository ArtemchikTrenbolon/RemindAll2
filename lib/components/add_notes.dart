import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  TextEditingController notesController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

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
    dateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Добавить напоминание",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
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
                          size: 20
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none
                      )
                  ),
                ),
              ),
              const SizedBox(height: 32),

              TextFormField(
                controller: categoryController,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                onTap: () {

                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background,
                    prefixIcon: Icon(
                      Icons.list,
                      size: 20,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              bool isExpended = false;
                              String iconSelected = '';
                              Color categoryColor = Colors.white;
                              return StatefulBuilder(
                                  builder: (context, setState) {

                                    return AlertDialog(
                                      title: Text(
                                          "Создать категорию"
                                      ),
                                      content: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              textAlignVertical: TextAlignVertical.center,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  hintText: "Название",
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                      borderSide: BorderSide.none
                                                  )
                                              ),
                                            ),


                                            const SizedBox(height: 16),
                                            TextFormField(
                                              onTap: () {
                                                setState(() {
                                                  isExpended = !isExpended;
                                                });
                                              },
                                              textAlignVertical: TextAlignVertical.center,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  filled: true,
                                                  suffixIcon: Icon(
                                                    CupertinoIcons.chevron_down,
                                                    size: 20,
                                                  ),
                                                  fillColor: Colors.white,
                                                  hintText: "Иконка",
                                                  border: OutlineInputBorder(
                                                      borderRadius: isExpended
                                                          ? BorderRadius.vertical(
                                                          top: Radius.circular(12)
                                                      )
                                                          : BorderRadius.circular(12),
                                                      borderSide: BorderSide.none
                                                  )
                                              ),
                                            ),
                                            isExpended
                                                ? Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.vertical(
                                                    bottom: Radius.circular(12)
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: GridView.builder(
                                                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        mainAxisSpacing: 5,
                                                        crossAxisSpacing: 5
                                                    ),
                                                    itemCount: myCategoriesIcons.length,
                                                    itemBuilder: (context, int i) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          setState((){
                                                            iconSelected = myCategoriesIcons[i];
                                                          });
                                                        },
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 3,
                                                                  color: iconSelected == myCategoriesIcons[i]
                                                                      ? Colors.green
                                                                      : Colors.grey
                                                              ),
                                                              borderRadius: BorderRadius.circular(12),
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'icons/${myCategoriesIcons[i]}.png'
                                                                  )
                                                              )
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                ),
                                              ),
                                            )
                                                : Container(),
                                            const SizedBox(height: 16),
                                            TextFormField(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (ctx2) {
                                                      return AlertDialog(
                                                        content: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            ColorPicker(
                                                              pickerColor: categoryColor,
                                                              onColorChanged: (value) {
                                                                setState(() {
                                                                  categoryColor = value;
                                                                });
                                                              },
                                                            ),
                                                            SizedBox(
                                                              width: double.infinity,
                                                              height: 50,
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(ctx2);
                                                                },
                                                                style: TextButton.styleFrom(
                                                                    backgroundColor: Colors.black,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(12)
                                                                    )
                                                                ),
                                                                child: Text(
                                                                  "Ок",
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
                                                );
                                              },
                                              textAlignVertical: TextAlignVertical.center,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  filled: true,
                                                  fillColor: categoryColor,
                                                  hintText: "Цвет",
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                      borderSide: BorderSide.none
                                                  )
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            SizedBox(
                                              width: double.infinity,
                                              height: kToolbarHeight,
                                              child: TextButton(
                                                onPressed: () {
                                                  // Create Category Object and Pop
                                                  Navigator.pop(context);
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
                                      ),
                                    );
                                  }
                              );
                            }
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        size: 20,
                      ),
                    ),
                    hintText: "Категории",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none
                    )
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
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365))
                  );

                  if(newDate != null) {
                    setState(() {
                      dateController.text = DateFormat("dd/MM/yyyy").format(newDate);
                      selectedDate = newDate;
                    });
                  }

                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background,
                    prefixIcon: Icon(
                      Icons.access_time,
                      size: 20,
                    ),
                    hintText: "Дата",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none
                    )
                ),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: TextButton(
                  onPressed: () {},
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
        ),
      ),
    );
  }
}