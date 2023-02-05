import 'package:flutter/material.dart';
import 'package:raftlabs_assignment/screens/HomeScreen.dart';
import 'package:raftlabs_assignment/screens/web_view.dart';
import 'package:raftlabs_assignment/screens/welcome_screen.dart';


class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  var pageIndex = 0;
  List pages = [
    const HomeScreen(),
    const WelcomeScreen(),
    const WebView()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        backgroundColor: Colors.deepOrangeAccent.shade100,
        body: pages[pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.deepOrange.shade100,
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: Colors.deepOrange,
          currentIndex: pageIndex,
          items:  const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
              label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.work),
              label: 'Welcome'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
              label: 'WebView'
            ),
          ],

          onTap: (index){
            setState(() {
              pageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
