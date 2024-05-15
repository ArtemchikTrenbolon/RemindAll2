import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app3/screen/home/blocs/get_note_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app3/components/add_notes.dart';
import 'package:flutter_app3/components/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:note_repository/note_repository.dart';
import 'package:flutter_app3/components/blocs/create_note_bloc/create_note_bloc.dart';

import '../../../components/blocs/get_categories_bloc/get_categories_bloc.dart';
import '../../event/event.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  late Color selectedItem = Colors.white;
  Color unselectedItem = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNoteBloc, GetNoteState>(
  builder: (context, state) {
    if(state is GetNoteSuccess){
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30)
        ),
        child: SizedBox(
          height: 80,
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  index = value;
                });
              },
              backgroundColor: Colors.black,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 3,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.home,
                      color: index == 0 ? selectedItem : unselectedItem
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.graph_square_fill,
                      color: index == 1 ? selectedItem : unselectedItem
                  ),
                  label: "Events",
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => CreateCategoryBloc(
                            FirebaseNoteRepo()
                        ),
                      ),
                      BlocProvider(
                        create: (context) => GetCategoriesBloc(FirebaseNoteRepo())..add(
                            GetCategories()
                        ),
                      ),
                      BlocProvider<CreateNoteBloc>(
                        create: (context) => CreateNoteBloc(FirebaseNoteRepo()),
                      ),
                    ],
                      child: EventPage()
                  ),
              ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              transform: GradientRotation(pi / 4),
            ),
          ),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: index == 0
          ? MainScreen(state.note)
          : EventScreen()
    );
  }
    else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
  );
  }
}