import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
 
class databaseHelper{

  static databaseHelper _databasehelper;
  static Database _database;

  String taskTable ='task_table';
  String colId='id';
  String colTitle='title';
  String colDescription ='description';
  String colpriority ='priority';
  String coldate='date';
  databaseHelper._createInstance();
  factory databaseHelper(){
    if(_databasehelper==null)
    {
      _databasehelper= databaseHelper._createInstance();
    }
    return _databasehelper;
  }
  initializeDatabase()  async{
    Directory directory= await getApplicationDocumentsDirectory();
    String path =directory.path +'task.db';

    
  }
  void _create(Database db,int newVersion) async{
    await db.execute('CREATE TABLE $taskTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,$colDescription TEXT , $colpriority INTEGER, $coldate TEXT)');
  }
}