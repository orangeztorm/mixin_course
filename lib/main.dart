import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:meta/meta.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() {
  runApp(const MyApp());
}

extension GetOnUri on Object {
  Future<HttpClientResponse> getUrl(String url) =>
      HttpClient().getUrl(Uri.parse(url)).then((req) => req.close());
}

mixin CanMakeCall {
  String get url;

  @useResult
  Future<String> getString() => getUrl(url)
      .then((resp) => resp.transform(utf8.decoder).join().toString());
}

@immutable
class People with CanMakeCall {
  const People();

  @override
  String get url => 'http://127.0.0.1:5500/apis/people.json';
}

void testIt() async {
  final people = await const People().getString();
  people.log();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    testIt();
    return const Scaffold();
  }
}
