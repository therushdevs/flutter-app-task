import 'package:flutter/material.dart';

import '../models/models.dart';

class WebView extends StatefulWidget {
  const WebView({Key? key}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          body: Container(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Center(
                  child: Text(
                    'Web View',
                    style: TextStyle(fontSize: 54, fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  child: const Padding(
                    padding: EdgeInsets.only(top: 0, left: 10),
                    child: Text('please click on the below links to see my portfolio in Webview.',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: ElevatedButton(
                          autofocus: true,
                          child: const Text('GitHub(Portfolio)', style: TextStyle(fontSize: 20),),
                          onPressed: () async {
                            openWebView('https://github.com/the-third-robot');
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        child: const Text('My Blog',style: TextStyle(fontSize: 20),),
                        onPressed: () async {
                          openWebView('https://rpvk.hashnode.dev/');
                        },
                      ),
                    ),
                  ]
                ),

              ],
            ),
          ),
        ),
    );
  }
}
