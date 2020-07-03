import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:task_reminder/models/tasl_table.dart';
 
class DatabaseHelper{

  static DatabaseHelper _databasehelper;
  static Database _database;

  String taskTable ='task_table';
  String colId='id';
  String colTitle='title';
  String colDescription ='description';
  String colpriority ='priority';
  String coldate='date';
  DatabaseHelper._createInstance();
  factory DatabaseHelper(){
    if(_databasehelper==null)
    {
      _databasehelper=DatabaseHelper._createInstance();
    }
    return _databasehelper;
   
  }
   Future<Database> get database async{
      if(_database==null)
      {
        _database=await initializeDatabase();
      }
      return _database;
    }
  Future<Database> initializeDatabase()  async{
    Directory directory= await getApplicationDocumentsDirectory();
    String path =directory.path +'task.db';
    
    var taskDatabase=openDatabase(path,version: 1 , onCreate: _createDb);
    return taskDatabase;
    

  }
  void _createDb(Database db,int newVersion) async{
    await db.execute('CREATE TABLE $taskTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,$colDescription TEXT , $colpriority INTEGER, $coldate TEXT)');
  }


  // Fetch Operation: Get all note objects from database
	Future<List<Map<String, dynamic>>> getNoteMapList() async {
		Database db = await this.database;

  //var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
		var result = await db.query(taskTable, orderBy: '$colpriority ASC');
		return result;
	}

	// Insert Operation: Insert a Note object to database
	Future<int> insertNote(TaskTable note) async {
		Database db = await this.database;
		var result = await db.insert(taskTable, note.toMap());
		return result;
	}

	// Update Operation: Update a Note object and save it to database
	Future<int> updateNote(TaskTable note) async {
		var db = await this.database;
		var result = await db.update(taskTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
		return result;
	}

	// Delete Operation: Delete a Note object from database
	Future<int> deleteNote(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $taskTable WHERE $colId = $id');
		return result;
	}

	// Get number of Note objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $taskTable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

	// Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
	Future<List<TaskTable>> getNoteList() async {

		var noteMapList = await getNoteMapList(); // Get 'Map List' from database
		int count = noteMapList.length;         // Count the number of map entries in db table

		List<TaskTable> noteList = List<TaskTable>();
		// For loop to create a 'Note List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			noteList.add(TaskTable.fromMapToObject(noteMapList[i]));
		}

		return noteList;
	}
  

}