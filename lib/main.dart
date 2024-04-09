import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue[400]),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RemindAll'),
          backgroundColor:Colors.blue,
        ),
        body: Center(
          //child: Icon(Icons.settings, size: 45, color: Colors.blue),

          //TextButton.icon(onPressed: () {},
          //label: const Text('wqef'),icon: const Icon(Icons.adb_sharp),) ,

          // TextButton.icon(
          //     onPressed: () {},
          //     icon: Icon(Icons.adb_sharp),
          //     label: Text('settings'))
          // child:TextButton(
          //    onPressed: () {},
          //     child: Text('fewf'),
          //    style: ButtonStyle(
          //        backgroundColor: MaterialStateProperty.all(Colors.blue)),),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('+'),
          backgroundColor: Colors.blue,
          onPressed: () {
            print('click');
          },
        ),
      ),
    );
  }
}


