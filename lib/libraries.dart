import 'package:flutter/material.dart';

Widget buildLibraryItem(BuildContext context, String profileType) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LibraryDetails(profileType: profileType)),
      );
    },
    child: Container(
      width: 100,
      height: 140,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2.0),
      ),
      child: Column(children: [Text(profileType)]),
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

class LibraryDetails extends StatefulWidget {
  final String profileType;

  const LibraryDetails({super.key, required this.profileType});

  @override
  _LibraryDetailsState createState() => _LibraryDetailsState();
}

class _LibraryDetailsState extends State<LibraryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BackButton(
            onPressed: () => {Navigator.pop(context)},
          )
        ],
        title: Text(widget.profileType),
      ),
      body: const Center(child: Text("Details")),
    );
  }
}

class LibrariesPage extends StatelessWidget {
  final ImageProvider titleImage;

  const LibrariesPage({super.key, required this.titleImage});

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libraries'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle("Books"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildLibraryItem(context, "The Hunger Games"),
                buildLibraryItem(context, "The Hunger Games: Mockingjay"),
                buildLibraryItem(context, "The Hunger Games: Catching Fire"),
              ],
            ),
            buildTitle("Movies"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildLibraryItem(context, "Encanto"),
                buildLibraryItem(context, "Tangled"),
                buildLibraryItem(context, "The Princess and the Frog"),
              ],
            ),
            buildTitle("Albums"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildLibraryItem(context, "SOUR"),
                buildLibraryItem(context, "1989 Taylor's Version"),
                IconButton(
                  icon: const Icon(Icons.book),
                  onPressed: () {
                    //Create function that will create a form
                    //Form will be used to create a new LibraryItem
                    //Along with form, allow users to use a barcode scanner
                    //Barcode scanner can be used to auto fill form
                    //Once form is complete add a new LibraryItem where the button was pressed
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.book_sharp), label: "Libraries"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (int index) {
          if (index == 0) {
            // Handle tap on home
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
            );
          }
        },
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement profile screen
    return Container();
  }
}
