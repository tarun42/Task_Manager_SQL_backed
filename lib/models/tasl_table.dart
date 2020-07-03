
class TaskTable{
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  TaskTable(this._title,this._date,this._priority,[this._description]);

  TaskTable.withId(this._id,this._title,this._date,this._priority,[this._description]);

  int get id =>  _id;
  String get title =>  _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;


  set title(String newTitle){
    if(newTitle.length <= 255)
    {
      this._title=newTitle;
    }
  }
  set description(String newdescription){
    if(newdescription.length <= 255)
    {
      this._description=newdescription;
    }
  }
  set priority(int newpriority){
    if( newpriority >= 1 && newpriority <= 2)
    {
      this._priority=newpriority;
    }
  }

  set date(String newdate){
    if(newdate.length <= 255)
    {
      this._date=newdate;
    }
  }

  Map<String,dynamic> toMap(){
    var map=Map<String , dynamic>();
    if(id!=null)
    {
      map['id']=_id;
    }
    map['title']=_title;
    map['description']=_description;
    map['priority']=_priority;
    map['date']=_date;
    return map;
    

  }

  TaskTable.fromMapToObject(Map<String,dynamic> map)
  {
    this._id=map['id'];
    this._priority=map['priority'];
    this._title=map['title'];
    this._description=map['description'];
    this._date=map['date'];
    
  }
}