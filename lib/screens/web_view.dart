import 'package:flutter/material.dart';

class WebView extends StatefulWidget {
  const WebView({Key? key}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
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
        body: const Center(child: Text('This is web view'),
          ),
      );
  }
}
