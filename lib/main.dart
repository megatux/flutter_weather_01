import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Weather Demo App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Super Weather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _json = '...';

  @override
  void initState() {
    super.initState();
    _readWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Weather info:',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              '$_json',
              style: Theme.of(context).textTheme.display2,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _readWeatherData,
        tooltip: 'Reload',
        child: Icon(Icons.refresh),
      ),
    );
  }

  _readWeatherData() async {
    String dataURL =
        "https://api.darksky.net/forecast/841ce40e2a4665884c6f4830c2ba0aac/37.8267,-122.4233?lang=en&units=si";
    http.Response response = await http.get(dataURL);
    setState(() {
      if (response.statusCode == 200) {
        final membersJSON = json.decode(response.body);
        final summary = membersJSON['currently']['summary'].toString();
        final temperature = membersJSON['currently']['temperature'].toString();
        _json = '$summary, $temperature';
        print(_json);
      } else {
        _json = 'Error';
      }
    });
  }
}
