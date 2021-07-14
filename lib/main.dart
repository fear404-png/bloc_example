import 'package:flutter/material.dart';
import 'package:learnbloc/color_bloc.dart';
import 'package:learnbloc/size_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ColorBloc _bloc = ColorBloc();
  SizeBloc _size = SizeBloc();

  @override
  void dispose() {
    _bloc.dispoce();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLoC example"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
              child: StreamBuilder(
                  stream: _size.outputStateStream,
                  initialData: 100.0,
                  builder: (context, snapshot) {
                    return AnimatedContainer(
                      width: snapshot.data as double,
                      height: snapshot.data as double,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                  })),
          Center(
              child: StreamBuilder(
                  stream: _bloc.outputStateStream,
                  initialData: Colors.green,
                  builder: (context, snapshot) {
                    return AnimatedContainer(
                      width: 100,
                      height: 100,
                      color: snapshot.data as Color,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                  })),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _bloc.inputEventSink.add(ColorEvent.event_red);
              _size.inputEventSink.add(SizeEvent.event_small);
            },
            backgroundColor: Colors.red,
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              _bloc.inputEventSink.add(ColorEvent.event_blue);
              _size.inputEventSink.add(SizeEvent.event_middle);
            },
            backgroundColor: Colors.blue,
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              _bloc.inputEventSink.add(ColorEvent.event_green);
              _size.inputEventSink.add(SizeEvent.event_big);
            },
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
