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

  @override
  initState(){
    super.initState();
    streamController.stream.asBroadcastStream();
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
    if (!streamController.isClosed && (hour >= 5 && hour < 12) ){
      message = {
        'date' : date,
        'greet' : 'Good Morning',
        'time'  : dateTime[1],
      };
      streamController.sink.add(message);
    }else if ( !streamController.isClosed && (hour >= 12 && hour <= 18)){
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height/1.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StreamBuilder(
                stream: streamController.stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                  if (snapshot.hasData){
                    var arr = snapshot.data['time'].toString().split(':');
                    String formattedTime = '${arr[0]}:${arr[1]}:${arr[2].substring(0,2)}';
                    var dateFormat = List.from(snapshot.data['date'].toString().split('-').reversed);
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 15,top: 30),
                            child:Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                                decoration:  BoxDecoration(
                                  color: Colors.blueAccent.shade100,
                                ),
                                child: Center(
                                  child: Text(
                                      '${snapshot.data['greet']} friend!',
                                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: Colors.white)
                                  ),
                                )
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height:  MediaQuery.of(context).size.width/1.4,
                                    child:  FadeInImage(
                                      image: NetworkImage("https://media.giphy.com/media/j0qlQDHk2HTVuwImpo/giphy.gif"),
                                      placeholder: AssetImage(
                                          "assets/images/images.png"),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            'assets/images/images.png',
                                            fit: BoxFit.fitWidth);
                                      },
                                      fit: BoxFit.fitWidth,
                                    ),

                                  ),
                                  Text('${dateFormat.join('/')} | ${formattedTime}',
                                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }else if (snapshot.hasError){
                    return const Center(child: Text('Error'));
                  }else{
                      return SizedBox(
                        height: MediaQuery.of(context).size.width/1.1,
                        width: 100,
                        child: Center(child: CircularProgressIndicator(),
                        ),
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
                      return  Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                          ),
                          child: const Center(
                            child: Text(
                                'No Internet Connection',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)
                            ),
                          )
                      );
                    }else{
                      return  Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        decoration: const BoxDecoration(
                            color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                              'Internet connected with ${isConnected.toString().split('.')[1]}',
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white)
                          ),
                        )
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
        ),
      ),
    );
  }
}
