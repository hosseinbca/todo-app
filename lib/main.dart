import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
/*
باید در پورتهای مورد قبول ران شود که پورت استفاد شده در بک اند 8070 است
 */
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class todo {
  final String? title;
  final String? body;
  final String? id;

  todo({this.id, this.title, this.body});
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    gettodo();
  }

List Todos = [];

  Future gettodo() async {
    var res = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/?format=json'),
    );

    setState(() {
      Todos = jsonDecode(res.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ss"),
      ),
      body: ListView.builder(
          itemCount: Todos.length,
          itemBuilder: (context, index) => ListTile(
                title: Text(Todos[index]['title']),
                leading: Text(Todos[index]['id'].toString()),
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => showtodo(
                            title: Todos[index]['title'],
                            body: Todos[index]['body']),
                      ));
                }),
              )),
    );
  }
}

class showtodo extends StatelessWidget {
  showtodo({Key? key, required this.title, required this.body})
      : super(key: key);
  String title;
  String body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FractionallySizedBox(
          widthFactor: 0.9,
          child: Text(
            body,
            softWrap: true,
          )),
    );
  }
}
