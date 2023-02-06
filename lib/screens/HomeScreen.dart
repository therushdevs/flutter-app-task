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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
               const Center(
                 child: Text(
                  'Hello Friend!',
                   style: TextStyle(fontSize: 54, fontWeight: FontWeight.bold),
              ),
               ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
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
                padding: const EdgeInsets.all(22.0),
                child: SizedBox(
                  width: 200,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: ()async{
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ApiCalledPage()));
                      setState(() {
                        apiCalled = true;
                      });
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


