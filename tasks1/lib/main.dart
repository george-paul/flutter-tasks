import "package:flutter/material.dart";

void main()
{
  runApp(MyApp());
}

class MyApp extends StatefulWidget
{
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp>
{
  List<String> allTasks = ["one","two","three"];
  var them = ThemeData.dark();
  Widget build(BuildContext context)
  {
    //var con = context;
    return MaterialApp
    (
      theme: them,
      title: "ToDo",
      home: Builder(builder: (context) => Scaffold
      (
        appBar: AppBar
        (
          title: Text("ToDo"),
          actions: <Widget>
          [
            IconButton(icon: Icon(Icons.palette), onPressed: pushTheme,),
          ],
        ),
        floatingActionButton: FloatingActionButton
        (
          onPressed: () => addTask(context),
          child: Icon(Icons.add),
        ),
        body: ListView.builder
        (
          itemCount: allTasks.length*2,
          padding: const EdgeInsets.all(16),
          itemBuilder: (BuildContext context, int index)
          {
            int i = index ~/ 2;
            if(index.isEven)
            {
              return buildRow(i);
            }
            return Divider();
          }
        ),
      )),
    );
  }

  void pushTheme()
  {
    setState(()
    {
      them = (them == ThemeData.dark()) ? ThemeData.light() : ThemeData.dark();
    });
  }

  Widget buildRow(int index)
  {
    return ListTile
    (
      title: Text(allTasks[index]),
      leading: IconButton
      (
        icon: Icon(Icons.check),
        onPressed: () => taskDone(index),
      ),
    );
  }

  void addTask(var context)
  {
    final TextEditingController txtcont = new TextEditingController();
    showDialog
    (
      context: context,
      builder: (BuildContext context)
      {
        return AlertDialog
        (
          title: Text("Add a new Task:"),
          content: TextField
          (
            decoration: const InputDecoration
            (
              icon: Icon(Icons.arrow_forward_ios),
              hintText: "Enter task description",
            ),
            controller: txtcont,
          ),
          actions: <Widget>
          [
            FlatButton
            (
              child: Text("CANCEL"),
              onPressed: ()
              {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton
            (
              child: Text("ADD"),
              onPressed: ()
              {
                setState(()
                {
                  allTasks.add(txtcont.text);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  void taskDone(int index)
  {
    setState(()
    {
      allTasks.removeAt(index);
    });
  }
}