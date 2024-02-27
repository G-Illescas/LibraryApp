import 'package:flutter/material.dart';

import 'profile.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key});
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
      home: const MyHomePage(titleImage: AssetImage('assets/images/logo.png')),
    );
  }
}

Widget buildLibraryItem(BuildContext context, String profileType) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => LibraryDetails(profileType: profileType)),
      );
    },
    child: Container(
      width: 100,
      height: 140,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 2.0
        ),
      ),
      child: Column(
        children: [Text(profileType)]
      ),
    ),
  );
}

  Container buildTitle(String titlename) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 10),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
        child: Text((titlename), style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  class LibraryDetails extends StatefulWidget{
    final String profileType;

    const LibraryDetails({Key? key, required this.profileType});

    @override
    _LibraryDetails createState() => _LibraryDetails();
  }

  class _LibraryDetails extends State<LibraryDetails>{
    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          actions: [
            BackButton(onPressed: () => {Navigator.pop(context)},)
          ],
          title: Text(widget.profileType),
        ),
        body: Center(child: Text("Details")
        ),
      );
    }
  }

class MyHomePage extends StatelessWidget {
  final ImageProvider titleImage;
  const MyHomePage({Key? key, required this.titleImage});

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 1;
    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Image(image: titleImage, height: 80, fit: BoxFit.contain),
      ),
      body: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  buildTitle("Books"),
                  const SizedBox(
                      height: 10,
                    ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        buildLibraryItem(context, "The Hunger Games"),
                        buildLibraryItem(context, "The Hunger Games: Mockingjay"),
                        buildLibraryItem(context, "The Hunger Games: Catching Fire")
                      ],
                    ),
                  buildTitle("Movies"),
                  const SizedBox(
                      height: 10,
                    ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        buildLibraryItem(context, "Encanto"),
                        buildLibraryItem(context, "Tangled"),
                        buildLibraryItem(context, "The Princess and the Frog")
                      ],
                    ),
                  buildTitle("Albums"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      buildLibraryItem(context, "SOUR"),
                      buildLibraryItem(context, "1989 Taylor's Version")
                      ],
                    ),
                ]
                )
          ),
      bottomNavigationBar: BottomNavigationBar(currentIndex: _currentIndex, items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        const BottomNavigationBarItem(icon: Icon(Icons.book_sharp), label: "Libraries"),
        const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
        onTap: (int index) => {
          if (index == 2) {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Profile()),
            ),
          }
        },
      ),
    );
  }
}
