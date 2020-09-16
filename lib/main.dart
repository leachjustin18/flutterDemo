import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to flutter',
        home: Scaffold(
          appBar: AppBar(title: Text('Welcome to flutter')),
          body: Center(
            child: Text('Hello World!'),
          ),
        ));
  }
}
