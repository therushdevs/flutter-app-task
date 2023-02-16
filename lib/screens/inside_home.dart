import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';

class ApiCalledPage extends StatefulWidget {
  const ApiCalledPage({Key? key}) : super(key: key);

  @override
  State<ApiCalledPage> createState() => _ApiCalledPageState();
}

class _ApiCalledPageState extends State<ApiCalledPage> {

  textEdited(String title, String text, var color, double size){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        overflow:TextOverflow.clip,
        maxLines: 1,
        '$title: $text',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size,
          color: color
        ),
      ),
    );
  }
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
        body: FutureBuilder(
          future: homeApiCall(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.hasData){
            var entries = snapshot.data.entries;
            return SizedBox(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: entries.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: ()async{
                      var url = entries[index].link;
                      openWebView(url);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Card(
                          color: Colors.pink.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/2,
                                      child: textEdited( 'Api Title' ,entries[index].api, Colors.black, 20),
                                    ),
                                    Icon(Icons.ads_click_rounded),
                                  ],
                                ),
                                textEdited( 'Description',entries[index].description, Colors.grey.shade700, 16),
                                textEdited( 'Api Link ',entries[index].link, Colors.grey.shade700, 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/2,
                                      child: textEdited( 'Category of API' ,entries[index].category, Colors.purple, 16),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/3,
                                      child: entries[index].https? textEdited( ' || HTTPS','Yes', Colors.purple, 16)
                                          : textEdited( ' || HTTPS','No',Colors.red, 16),                                    ),

                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }else if (snapshot.hasError){
            return Center(child: Text('Error: ${snapshot.error}'));
          }else{
            return const Center(child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),);
          }
        },

        ),
      ),
    );
  }
}