import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Homepage(),
    );
  }
}


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
          centerTitle: true,),
      body:
       Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Container(
            height:350,
            width: 2000,
            alignment: Alignment.center,
            //padding:const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'data:image/jpeg;base64,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'
                  ),
                  fit:BoxFit.cover
              ),
            ),
            child: FutureBuilder(
                future: apicall(),
                builder: (context,snapshot){
                  if (snapshot.hasData){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children:[
                        Text(snapshot.data['temp'].toString()),
                        Text(snapshot.data['description'].toString()),
                        // Text(snapshot.data['clouds'].toString()),
                        // Text(snapshot.data['feelslike'].toString()),
                      ],
                    );

                  }
                  else{
                    return CircularProgressIndicator();
                  }

                }
            )  ,
          ),

        ],
      ),

      );
  }
}
Future apicall() async {
  final url=Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=bangalore&appid=4ac7dcfaaa25c3af92f29b6e04ea7f1f');

  final response=await http.get(url);
  print(response.body);
  final json=jsonDecode(response.body);
  print(json['weather'][0]['description']);
  final output={'description': json['weather'][0]['description'],
    'temp': json['main']['temp'],
    'clouds' :json['clouds']['clouds.all']};
  return output;

}

