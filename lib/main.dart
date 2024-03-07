import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'libraries.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  MaterialColor _customPrimarySwatch(int hexColor) {
    Map<int, Color> color = {
      50: Color.fromRGBO(
          Color(hexColor).red, Color(hexColor).green, Color(hexColor).blue, .1),
      100: Color.fromRGBO(
          Color(hexColor).red, Color(hexColor).green, Color(hexColor).blue, .2),
      200: Color.fromRGBO(
          Color(hexColor).red, Color(hexColor).green, Color(hexColor).blue, .3),
      300: Color.fromRGBO(
          Color(hexColor).red, Color(hexColor).green, Color(hexColor).blue, .4),
      400: Color.fromRGBO(
          Color(hexColor).red, Color(hexColor).green, Color(hexColor).blue, .5),
      500: Color.fromRGBO(
          Color(hexColor).red, Color(hexColor).green, Color(hexColor).blue, .6),
      600: Color.fromRGBO(
          Color(hexColor).red, Color(hexColor).green, Color(hexColor).blue, .7),
      700: Color.fromRGBO(
          Color(hexColor).red, Color(hexColor).green, Color(hexColor).blue, .8),
      800: Color.fromRGBO(
          Color(hexColor).red, Color(hexColor).green, Color(hexColor).blue, .9),
      900: Color.fromRGBO(
          Color(hexColor).red, Color(hexColor).green, Color(hexColor).blue, 1),
    };
    return MaterialColor(hexColor, color);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello",
      theme: ThemeData(
        primarySwatch: _customPrimarySwatch(0xFF0a481e),
      ),
      home: const MyHomePage(titleImage: AssetImage('assets/images/logo.png')),
    );
  }
}

class SignUpForm extends StatefulWidget {
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

  Future<void> _addUser(BuildContext context, String name, String email) async {
    await _database.insert(
      'users',
      {
        'name': name,
        'email': email,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const LibrariesPage(
              titleImage: AssetImage('assets/images/logo.png'))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Title(
            color: Colors.green,
            child: const Text("Sign Up",
                style: TextStyle(fontSize: 40, color: Color(0xFF0a481e))),
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
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Please do not leave any fields blank')),
              );
            }
          },
          child: const SizedBox(
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text('Sign Up', style: TextStyle(fontSize: 24)),
            ),
          ),
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
          title: Image(image: titleImage, height: 80, fit: BoxFit.contain)),
      body: const SignUpForm(),
    );
  }
}
