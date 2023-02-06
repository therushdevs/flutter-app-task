import 'package:flutter/material.dart';

import 'inside_home.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool apiCalled = false;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
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
          body:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
               Padding(
                 padding: const EdgeInsets.only(bottom: 20.0),
                 child: const Center(
                   child: Text(
                    'Hello Friend!',
                     style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
                 ),
               ),
              Container(
                width: MediaQuery.of(context).size.width,
                height:  MediaQuery.of(context).size.width/1.4,
                child: FadeInImage(
                  image: NetworkImage("https://media.giphy.com/media/Vbtc9VG51NtzT1Qnv1/giphy.gif"),
                  placeholder: AssetImage(
                      "assets/images/download.jpg"),
                  imageErrorBuilder:
                      (context, error, stackTrace) {
                    return Image.asset(
                        'assets/images/download.jpg',
                        fit: BoxFit.fitWidth);
                  },
                  fit: BoxFit.fitWidth,
                ),

              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: SizedBox(
                  width: 160,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ApiCalledPage()));
                    },
                    child: Text(
                      'Fetch Data',
                      style: TextStyle(fontSize: 24),),
                  ),
                ),
              ),

            ],
          ),
      ),
    );
  }
}


