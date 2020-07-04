import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:task_reminder/models/tasl_table.dart';

import "package:flutter/material.dart";
import 'package:task_reminder/screens/task_detail.dart';
import 'package:task_reminder/utils/databaseHelper.dart';

class Tasklist extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TasklistState();
  }
}

class TasklistState extends State<Tasklist> {
  DatabaseHelper databasehelper = DatabaseHelper();
  List<TaskTable> taskList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (taskList == null) {
      taskList = List<TaskTable>();
      updateListView();
    }
    updateListView();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Task Manager"),
          iconTheme: IconThemeData(),
          leading: Icon(Icons.assignment_turned_in),
          centerTitle: false,
        ),
        body: gettasklist(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint("floadting button");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Taskdetail(TaskTable('', '', 2), 'Add Note');
            }));
          },
          tooltip: 'add Note',
          child: Icon(Icons.add),
          elevation: 10,
          hoverElevation: 15,
          autofocus: true,
        ));
  }

  ListView gettasklist() {
    //TextStyle titlestyle= Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemBuilder: (BuildContext context, int position) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
          child: Opacity(
            opacity: 0.8,
            child: Card(
              borderOnForeground: true,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.lightBlue,
              elevation: 15,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      getPriorityColor(this.taskList[position].priority),
                  child: getPriorityIcon(this.taskList[position].priority),
                ),
                title: Text(
                  this.taskList[position].title,
                ),
                subtitle: Text(this.taskList[position].date),
                trailing: GestureDetector(
                  child: Icon(
                    Icons.done,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _delete(context, taskList[position]);
                  },
                ),
                onTap: () {
                  debugPrint("listtile");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Taskdetail(this.taskList[position], 'Edit Note');
                  }));
                },
              ),
            ),
          ),
        );
      },
      itemCount: count,
    );
  }

// Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, TaskTable note) async {
    int result = await databasehelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(TaskTable note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Taskdetail(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databasehelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TaskTable>> noteListFuture = databasehelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.taskList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
