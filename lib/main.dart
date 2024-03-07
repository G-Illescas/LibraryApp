import 'dart:html';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'libraries.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Routes
      routes: {
        '/': (context) => const MyHomePage(titleImage: AssetImage('assets/images/logo.png')),
        '/libraries': (context) => const LibrariesPage(titleImage: AssetImage('assets/images/logo.png')),
      },
      // Application name
      title: "Hello",
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      // A widget which will be started on application startup
      //home: const MyHomePage(titleImage: AssetImage('assets/images/logo.png')),
    );
  }
}

class SignUpForm extends StatefulWidget{
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late Database _database;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  void _initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'users_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT)',
        );
      },
      version: 1,
    );
  }

  void _addUser(BuildContext context, String name, String email) async {
    await _database.insert(
      'users',
      {
        'name': name,
        'email': email,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    Navigator.pushNamed(
      context,
      '/libraries',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Title(
            color: Colors.green,
            child: const Text("Sign Up", style: TextStyle(fontSize: 40, color: Colors.green)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25),
          child: TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: "Name",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            String name = _nameController.text.trim();
            String email = _emailController.text.trim();

            if (name.isNotEmpty && email.isNotEmpty) {
              _addUser(context, name, email);
              _nameController.clear();
              _emailController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User added successfully')),
              );
            }
            else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill all fields')),
              );
            }
          },
          child: const Text('Sign Up', style: TextStyle(fontSize: 24)),
        ),
      ],
    );
  }

}

class MyHomePage extends StatelessWidget {
  final ImageProvider titleImage;

  const MyHomePage({super.key, required this.titleImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(
          image: titleImage, 
          height: 80, 
          fit: BoxFit.contain
        )
      ),
      body: const SignUpForm(),
    );
  }
}
