import 'package:flutter/material.dart';

class Taskdetail extends StatefulWidget {
  @override
  _TaskdetailState createState() => _TaskdetailState();
}

class _TaskdetailState extends State<Taskdetail> {
  
  static var _priorities =['High','low'];
  TextEditingController _first=new TextEditingController();
  TextEditingController _second=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit task"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: DropdownButton(items: _priorities.map((String dropDownStringItem){
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            style: textStyle,
            value: 'low',
             onChanged: (valueSelectedByUser){
               setState(() {
                debugPrint('user select'); 
               });
             }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _first,
              style: textStyle,
              onChanged: (value){
                debugPrint("first controller");
              },
              decoration: InputDecoration(
                labelText: 'Ttile',
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
              
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _second,
              style: textStyle,
              onChanged: (value){
                debugPrint("second controller");
              },
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
              
            ),
          ),

          Row(
            children: <Widget>[
              Expanded(
                  child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text("Save",textScaleFactor: 1.5,),

                  onPressed: (){
                    setState(() {
                      debugPrint("saved button");
                    });
                  },
                  
                ),
              ),
               SizedBox(height: 20,), 
              Expanded(
                  child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text("Delete",textScaleFactor: 1.5,),

                  onPressed: (){
                    setState(() {
                      debugPrint("delete button");
                    });
                  },
                  
                ),
              ),

            ],
          ),
        ],
      ),
    );

  }
}

class _priorities {
  static map(Type string, dropdownStringItem) {}
}