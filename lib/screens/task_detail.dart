import 'package:flutter/material.dart';

import 'package:task_reminder/models/tasl_table.dart';
import 'package:task_reminder/utils/databaseHelper.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Taskdetail extends StatefulWidget {
  String appBarTitle;
  final TaskTable note;
  Taskdetail(this.note, this.appBarTitle);

  State<StatefulWidget> createState() {
    return TaskdetailState(this.note, this.appBarTitle);
  }
}

class TaskdetailState extends State<Taskdetail> {
  String appBarTitle;
  static var _priorities = ['High', 'low'];

  DatabaseHelper helper = DatabaseHelper();

  TaskTable note;

  TextEditingController _first = new TextEditingController();
  TextEditingController _second = new TextEditingController();

  TaskdetailState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    _first.text = note.title;
    _second.text = note.description;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ),
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                SizedBox(
                  height: 150,
                ),
                ListTile(
                  title: DropdownButton(
                      items: _priorities.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      style: textStyle,
                      value: 'low',
                      onChanged: (valueSelectedByUser) {
                        setState(() {
                          debugPrint('user select');
                          updatePriorityAsInt(valueSelectedByUser);
                        });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: _first,
                    style: textStyle,
                    onChanged: (value) {
                      updateTitle();
                      debugPrint("first controller");
                    },
                    decoration: InputDecoration(
                        labelText: 'Ttile',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: _second,
                    style: textStyle,
                    onChanged: (value) {
                      updateDescription();
                      debugPrint("second controller");
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Save",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("saved button");
                            _save();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Delete",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            _delete();
                            debugPrint("delete button");
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // ignore: missing_return
      ),
      // ignore: missing_return
      onWillPop: () {
        Navigator.pop(context, true);
      },
    );
  }

  void movetolastscreen() {
    Navigator.pop(context, true);
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0]; // 'High'
        break;
      case 2:
        priority = _priorities[1]; // 'Low'
        break;
    }
    return priority;
  }

  // Update the title of Note object
  void updateTitle() {
    note.title = _first.text;
  }

  // Update the description of Note object
  void updateDescription() {
    note.description = _second.text;
  }

  // Save data to database
  void _save() async {
    movetolastscreen();
    //Navigator.pop(context, true);
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      // Case 1: Update operation
      result = await helper.updateNote(note);
      debugPrint("not insert queery");
    } else {
      // Case 2: Insert Operation
      result = await helper.insertNote(note);
      debugPrint("insert queery");
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void _delete() async {
    movetolastscreen();
    //Navigator.pop(context, true);
    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
