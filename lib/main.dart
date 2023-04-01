import 'package:flutter/material.dart';

import 'api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jeevini i-NOS Internal-Flow',
      theme: ThemeData(
        textTheme:TextTheme(
            headline6:TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins',
                fontSize: 20,color:Color.fromRGBO(255, 255, 255, 1)),
            headline1: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,color:Color.fromRGBO(0, 0, 0, 1),
            ),
            headline2: TextStyle(
                color:Color.fromRGBO(0, 0, 0, 1),
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
                fontSize: 18),

            headline3: TextStyle(color:Color.fromRGBO(0, 0, 0, 1),
                fontWeight: FontWeight.w200,
                fontFamily: 'Poppins',
                fontSize: 14)
        ),
        primarySwatch: Colors.blue,
      ),
      home:CustomerAgentForm(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _formKey = GlobalKey<FormState>();

  int _counter = 0;


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('API'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Form(
          key:_formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
