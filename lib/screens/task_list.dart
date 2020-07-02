


import "package:flutter/material.dart";
import 'package:task_reminder/screens/task_detail.dart';
int count=0;
String title="Add Task";
class Tasklist extends StatefulWidget {
  @override
  _TasklistState createState() => _TasklistState();
}

class _TasklistState extends State<Tasklist> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task !."),
        
      ),
      body: gettasklist(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          debugPrint("floadting button");
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return Taskdetail(title);
          }
          ));
        },
        tooltip: 'add Note',
        child: Icon(Icons.add),
      )
    );
  }

ListView gettasklist()
{
  //TextStyle titlestyle= Theme.of(context).textTheme.subhead;
  
    return ListView.builder(itemBuilder: (BuildContext context,int position){
       return Card(
          color: Colors.white,
          elevation: 20,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),
            ),
            title: Text("Dummy title",),
            subtitle: Text("Dummy subtitle"),
            trailing: Icon(Icons.done,color: Colors.grey,),
            onTap: (){
              debugPrint("listtile");
              Navigator.push(context, MaterialPageRoute(builder: (context)
              {
                  return Taskdetail(title);
              }));
            },
          ),
       );
    },
    itemCount: count,);
}


}