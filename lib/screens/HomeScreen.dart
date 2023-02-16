import 'package:flutter/material.dart';
import 'package:raftlabs_assignment/constants.dart';
import 'package:raftlabs_assignment/screens/payment_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
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
          body:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                 const Padding(
                   padding: EdgeInsets.only(bottom: 20.0),
                   child: Center(
                     child: Text(
                      'Hello Friend!',
                       style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                   ),
                 ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height:  MediaQuery.of(context).size.width/1.4,
                  child: FadeInImage(
                    image: const NetworkImage("https://media.giphy.com/media/Vbtc9VG51NtzT1Qnv1/giphy.gif"),
                    placeholder: const AssetImage(
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
                    height: 40,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ApiCalledPage()));
                      },
                      child: const Text(
                        'Fetch Data',
                        style: TextStyle(fontSize: 18),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: SizedBox(
                    width: 160,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PaymentScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(Icons.payment),
                          Text(
                            'RazorPay',
                            style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
      ),
    );
  }
}


