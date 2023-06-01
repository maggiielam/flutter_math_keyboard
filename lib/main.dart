import 'package:flutter/material.dart';
import 'package:flutter_testing/key.dart';

import 'package:flutter_math_fork/flutter_math.dart';

import 'exprToTeX.dart';





// Example app demonstrating how to use the `math_keyboard` package.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white
      ),
      home: const MyHomePage(title: 'Simple Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<String> keys = 
  [
    '1', '2', '3', 'x', '/',
    '4', '5', '6', '+', '-',
    '7', '8', '9', '=', 'DEL',
    '0', '(', ')', 'Return', 'AC',
  ];

  List<String> eqs = 
  [
    '', '', ''
  ];
  List<String> latex = 
  [
    '', '', ''
  ];

  bool initDeleted = false;
  MathParser p = MathParser();

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
        title: Text(widget.title),
      ),
      body: Column(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        children: <Widget>[
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // SizedBox(height: 60,),
                  Container(padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Math.tex(eqs[2], mathStyle: MathStyle.display, textStyle: TextStyle(fontSize: 40))),

                  Container(padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Math.tex(eqs[1], mathStyle: MathStyle.display, textStyle: TextStyle(fontSize: 40))),

                  Container(padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Math.tex(eqs[0], mathStyle: MathStyle.display, textStyle: TextStyle(fontSize: 40))),

                ]

               )
          ),
          Expanded(
            flex: 1,
            child: GridView.builder(
              itemCount: keys.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, 
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
            itemBuilder: (BuildContext context, int index){
              if (index == 14) {
                return MyKey(
                  keyFace: keys[index],
                  keyValue: keys[index],
                  color: Colors.blue,
                  textColor: Colors.white,
                  pressed: () {
                    setState(() {
                      if (eqs[0].isNotEmpty) {
                        eqs[0] = eqs[0].substring(0, eqs[0].length - 1);
                      }
                    });
                  }
                );
              }
              else if (index == 18) {
                return MyKey(
                  keyFace: keys[index],
                  keyValue: keys[index],
                  color: Colors.blue,
                  textColor: Colors.white,
                  pressed: () {
                    setState(() {
                      print("new line!");
                      
                      eqs.insert(1, eqs[0]);
                      eqs[0] = '';
                      if (eqs.length == 5 && !initDeleted) {
                        eqs.removeLast();
                        eqs.removeLast();
                        initDeleted = true;
                      }
                      print(eqs);
                    });
                  }
                );
              }
              else if (index == 19){
                return MyKey(
                  keyFace: keys[index],
                  keyValue: keys[index],
                  color: Colors.blue,
                  textColor: Colors.white,
                  pressed: () {
                    setState(() {
                      print("cleared line!");
                      eqs[0] = '';
                      
                      // print(l1);
                    });
                  }
                );
              }
              else if (index == 3){
                return MyKey(
                  keyFace: keys[index],
                  keyValue: '*',
                  color: Colors.blue,
                  textColor: Colors.white,
                  pressed: () {
                    setState(() {
                      eqs[0] += '*';
                    });
                  }
                );
              }
              return MyKey(
                keyFace: keys[index],
                keyValue: keys[index],
                color: Colors.blue,
                textColor: Colors.white,
                pressed: () {
                  setState(() {
                    eqs[0] += keys[index];
                    // print(l1);
                  });
                  
                }
              );
            }),
              
            
      ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  bool isOperator(String x){
    return (x == '+' || x == '-' || x == 'x' || x == '='|| x == '/' );
  }
}

