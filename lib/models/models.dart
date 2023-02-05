import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../constants.dart';
import '../view_model/home_api_vm.dart';

Future<dynamic> homeApiCall() async{
  try{
    var response = await http.get(Uri.parse(homeApi));
    if (response.statusCode == 200){
       var welcome = welcomeFromJson(response.body);
       // context.read<StateProvider>().addHomeScreenData(welcome);
       return welcome;
      print(response.body.toString());
    }else{
      print('${response.statusCode} : Oops! something went wrong.');
    }
  }catch(error){
    print('Error: ${error.toString()}');
  }
}




