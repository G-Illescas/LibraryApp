import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: "Hello",
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      // A widget which will be started on application startup
      home: MyHomePage(title: 'Library App'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  Container buildProfileCard(String profileType) {
    return Container(
      width: 100,
      height: 140,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green, // Border color
          width: 2.0, // Border width
        ),
      ),
      child: Column(
        children: [Text(profileType)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text("Library App"),
      ),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
            ),
            child: Text("Books", style: TextStyle(fontSize: 20)),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildProfileCard("The Hunger Games"),
            buildProfileCard("The Hunger Games: Mockingjay"),
            buildProfileCard("The Hunger Games: Catching Fire")
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 10),
          child: Text("Movies", style: TextStyle(fontSize: 20)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildProfileCard("Encanto"),
            buildProfileCard("Tangled"),
            buildProfileCard("The Princess and the Frog")
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 10),
          child: Text("Albums", style: TextStyle(fontSize: 20)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildProfileCard("SOUR"),
            buildProfileCard("1989 Taylor's Version")
          ],
        ),
      ])),
      bottomNavigationBar: BottomNavigationBar(currentIndex: 0, items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.book_sharp), label: "Libraries"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
      ]),
    );
  }
}
