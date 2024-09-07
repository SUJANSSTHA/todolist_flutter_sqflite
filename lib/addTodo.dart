import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
import 'package:todolist_flutter_sqflite/dbhelper.dart'; // Make sure this path is correct


class Addtodo extends StatefulWidget {
  const Addtodo({super.key});

  @override
  State<Addtodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Addtodo> {
  DatabaseHelper db = DatabaseHelper.instance;
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descontroller = TextEditingController();

  insertData(title,desc)async{
    Map<String,dynamic> row = {
      DatabaseHelper.columnTitle:title,
      DatabaseHelper.columnDesc:title,
    };
    final id = await db.insert(row);
    print(id);
    Get.back();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add todo"),backgroundColor: Colors.orange,centerTitle: true,),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: titlecontroller,
              decoration: const InputDecoration(
                labelText:'Title',
                labelStyle: TextStyle(color: Colors.grey,fontSize: 18.0,)
              ),
              
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: descontroller,
              decoration: InputDecoration(
                labelText:'Description',
                labelStyle: const TextStyle(color: Colors.grey,
                fontSize: 18.0,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )

              ),
              
            ),
          ),
        GestureDetector(
          onTap: () => insertData(titlecontroller.text,descontroller.text),
          child: Container(
            margin: const EdgeInsets.all(20),
            height: 60,
            width: 200,
            decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(5.0)),
            child: const Center(child: Text("Add",style: TextStyle(fontSize: 30,),))
          ),
        )
        ]
        ,
      ),
    );
  }
}