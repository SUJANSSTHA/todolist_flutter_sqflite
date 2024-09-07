import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:todolist_flutter_sqflite/addTodo.dart';
import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
import 'package:todolist_flutter_sqflite/dbhelper.dart'; // Make sure this path is correct
import 'package:todolist_flutter_sqflite/update.dart'; // Make sure this path is correct


class MyTodos extends StatefulWidget {
  const MyTodos({super.key});

  @override
  State<MyTodos> createState() => _MyTodosState();
}

class _MyTodosState extends State<MyTodos> {
  DatabaseHelper db = DatabaseHelper.instance;
  List<Map<String, dynamic>> allData = [];

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  getAllData() async {
    allData = [];
    var res = await db.queryAll();
    setState(() {
      allData = res;
    });
  }

  deleteData(int id) async {
    await db.delete(id);
    getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todo"),
        backgroundColor: Colors.orange,
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => getAllData(),
            child: const Icon(Icons.refresh, color: Colors.white),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: allData.isEmpty
          ? const Center(
              child: Text(
                "Add your todos",
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  elevation: 2,
                  child: ListTile(
                    isThreeLine: true,
                    leading: GestureDetector(
                      onTap: () => Get.to(UpdateTodo(allData[index])),
                      child: const Icon(Icons.upload_outlined, color: Colors.orange),
                    ),
                    title: Text('${allData[index]['Title']}'),
                    subtitle: Text('${allData[index]['Description']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => deleteData(allData[index]['id']), // Fixing column name here
                    ),
                  ),
                );
              },
              itemCount: allData.length,
              shrinkWrap: true,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(const Addtodo()),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.note_outlined, size: 34),
      ),
    );
  }
}
