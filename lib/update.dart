import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_flutter_sqflite/dbhelper.dart'; // Ensure this path is correct

class UpdateTodo extends StatefulWidget {
  final Map<String, dynamic> todo;

  const UpdateTodo(this.todo, {super.key});

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  DatabaseHelper db = DatabaseHelper.instance;
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    titlecontroller.text = widget.todo['Title'] ?? '';
    descontroller.text = widget.todo['Description'] ?? '';
  }

  upDateData(String title, String desc) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: widget.todo['id'], // Correcting the id reference
      DatabaseHelper.columnTitle: title,
      DatabaseHelper.columnDesc: desc,
    };
    final id = await db.update(row);
    print('Updated row id: $id');
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Todo ${widget.todo['id']}"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: titlecontroller,
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.grey, fontSize: 18.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: descontroller,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: const TextStyle(color: Colors.grey, fontSize: 18.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => upDateData(titlecontroller.text, descontroller.text),
            child: Container(
              margin: const EdgeInsets.all(20),
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Center(
                child: Text(
                  "Update Todo",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
