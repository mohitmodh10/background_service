import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const channel = MethodChannel('com.example.background_service/backgroundService');

  void _incrementCounter() async{
    final String batteryLevel = await channel.invokeMethod('showToast',<String,String>{
      'message':'It is working'
    });
    print(batteryLevel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async{
              await channel.invokeMethod('startService');
            },
              child: Center(child: Container(height: 50,width: 150,color: Colors.blue,child: const Center(child:  Text("Start Service",style: TextStyle(color: Colors.white),)),))),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async{
              await channel.invokeMethod('stopService');
            },
              child: Center(child: Container(height: 50,width: 150,color: Colors.blue,child: const Center(child:  Text("Stop Service",style: TextStyle(color: Colors.white),)),))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
