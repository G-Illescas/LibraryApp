import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MyCustomForm extends StatefulWidget {
  final Function(String) onSubmit;
  final String initialText;

  const MyCustomForm({Key? key, required this.onSubmit, required this.initialText});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm>{
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: myController,
          decoration: const InputDecoration(
            labelText: 'Enter your username',
          ),
          onSubmitted: (text) {
            widget.onSubmit(text);
          },
        ),
      ),
    );
}
}

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late SharedPreferences _prefs;
  String? enteredText;

  @override
  void initState() {
    super.initState();
    _loadSavedText();
  }

  void _loadSavedText() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      enteredText = _prefs.getString('enteredText');
    });
  }

  void _saveText(String text) {
    _prefs.setString('enteredText', text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
              actions: [
                  BackButton(
                      onPressed: () => {Navigator.pop(context)},
                    )
                ],
              title: Text("Profile")
            ),
          body: Column(children: [
              Center(child: 
                Title(color: Colors.green, child: Text("Profile", style: const TextStyle(fontSize: 40))),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Text("P", style: TextStyle(fontSize: 48)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              enteredText != null
                ? Text(
                  enteredText!,
                  style: TextStyle(fontSize: 32),
                )
                : Center(
                  child: Title(
                      color: Colors.green, 
                      child: Text(
                        "Waiting", 
                        style: TextStyle(fontSize: 32)
                      ),
                    ),
                  ),
              SizedBox(
                height: 100,
                child: MyCustomForm(
                  initialText: enteredText ?? '',
                  onSubmit: (text){
                    setState(() {
                      enteredText = text;
                    });
                    _saveText(text);
                  },
                ),
              )
            ],
          )
        );
  }
}