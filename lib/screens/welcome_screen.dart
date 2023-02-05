import 'package:flutter/material.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  StreamController streamController = StreamController();
  StreamController internetConnection = StreamController();

  @override
  initState(){
    super.initState();
    streamController.stream.asBroadcastStream();
    internetConnection.stream.asBroadcastStream();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      greetings();
    });
  }

  Future<void> greetings() async{
    var message = {};
    var dateTime = DateTime.now().toString().split(' ');
    var date = dateTime[0];
    int hour = int.parse(dateTime[1].substring(0, 2));
    //( a % 2 != 0 && a % 5 != 0 )
    if (!streamController.isClosed && (hour >= 5 && hour <= 12) ){
      message = {
        'date' : date,
        'greet' : 'Good Morning',
        'time'  : dateTime[1],
      };

      streamController.sink.add(message);
    }else if ( !streamController.isClosed && (hour > 12 && hour <= 18)){
      //(a % 2 == 0 && a % 5 == 0)
      message = {
        'date' : date,
        'greet' : 'Good Afternoon',
        'time'  : dateTime[1],
      };
      streamController.sink.add(message);
    }else if (!streamController.isClosed ){
      message = {
        'date' : date,
        'greet' : 'Good Evening',
        'time'  : dateTime[1],
      };
      streamController.sink.add(message);
    }
  }

  @override
  void dispose(){
    super.dispose();
    streamController.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange.shade100,
        shadowColor: Colors.deepOrange.shade50,
        title:  Center(
          child: Text(
            'RaftLabs',
            style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 22,
                fontWeight:
                FontWeight.w600),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: streamController.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot){
              if (snapshot.hasData){
                return Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text('Hello There, ${snapshot.data['greet']}!',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text('Date ${snapshot.data['date']}',
                            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                          Text('Time ${snapshot.data['time']}',
                            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),
                );
              }else if (snapshot.hasError){
                return const Center(child: Text('Error'));
              }else{
                  return Center(child: CircularProgressIndicator(),
                  );
                }
              },
          ),
          StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData){
                var isConnected = snapshot.data.toString();
                // print(isConnected);
                if (isConnected == 'ConnectivityResult.none'){
                  return const Text(
                    'No internet connection',
                    style: TextStyle(color: Colors.red,fontSize: 24, fontWeight: FontWeight.bold),
                  );
                }else{
                  return  Text(
                    'Internet connected with ${isConnected.toString().split('.')[1]}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                  );
                }
              }else if (snapshot.hasError){
                return  Center(child: Text('Error: ${snapshot.error}'));
              }else{
                return const Center(child: CircularProgressIndicator(),
                );
              }
            }
            ,)
        ],
      ),
    );
  }
}
